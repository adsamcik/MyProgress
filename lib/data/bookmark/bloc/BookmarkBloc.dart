import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/bookmark/bloc/BookmarkBlocEvent.dart';
import 'package:MarkMyProgress/data/bookmark/database/DataStore.dart';
import 'package:MarkMyProgress/data/bookmark/runtime/SearchableBookmark.dart';
import 'package:MarkMyProgress/data/database/data/instance/SettingsStore.dart';
import 'package:MarkMyProgress/data/runtime/FilterRuntimeData.dart';
import 'package:MarkMyProgress/data/runtime/Pair.dart';
import 'package:MarkMyProgress/data/runtime/SearchResult.dart';
import 'package:MarkMyProgress/data/settings/FilterData.dart';
import 'package:MarkMyProgress/extensions/StringExtensions.dart';
import 'package:MarkMyProgress/extensions/UserBookmark.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'BookmarkBlocEvent.dart';
import 'BookmarkBlocState.dart';

class BookmarkBloc extends Bloc<BookmarkBlocEvent, BookmarkBlocState> {
  final DataStore dataStore;
  final SettingsStore settingsStore;

  BookmarkBloc({@required this.dataStore, @required this.settingsStore});

  @override
  BookmarkBlocState get initialState => BookmarkBlocState.notReady();

  @override
  Stream<BookmarkBlocState> mapEventToState(BookmarkBlocEvent event) async* {
    yield* event.map(
      load: _mapLoad,
      addBookmark: _mapAddBookmark,
      removeBookmark: _mapRemoveBookmark,
      incrementProgress: _mapIncrementBookmark,
      updateBookmark: _mapUpdateBookmark,
      updateFilterQuery: _mapUpdateFilterQuery,
      updateFilterData: _mapUpdateFilterData,
    );
  }

  Stream<BookmarkBlocState> _mapLoad(Load event) async* {
    var dataList = dataStore.transaction((dataStore) => dataStore.getAll());
    var filterData = settingsStore
        .transaction((settingsStore) => settingsStore.getFilterData());
    yield await Future.wait([dataList, filterData]).then(
      (value) {
        var dataList = (value[0] as Iterable<IPersistentBookmark>)
            .map((e) => SearchableBookmark(e))
            .toList();

        dataList.sort((a, b) => a.bookmark.title
            .toLowerCase()
            .compareTo(b.bookmark.title.toLowerCase()));

        var filterData = FilterRuntimeData(value[1] as FilterData);
        var filterList = _updateFilter(filterData, dataList);
        return BookmarkBlocState.ready(
          version: 0,
          bookmarkList: dataList,
          filteredBookmarkList: filterList,
          filterData: filterData,
        );
      },
      onError: (dynamic obj, StackTrace trace) {
        print(trace);
        return BookmarkBlocState.notReady();
      },
    );
  }

  Stream<BookmarkBlocState> _mapAddBookmark(AddBookmark event) async* {
    yield await state.maybeMap(
        ready: (currentState) {
          return dataStore
              .transaction<dynamic>(
                  (dataStore) => dataStore.insert(event.bookmark))
              .then((dynamic value) {
            currentState.bookmarkList.add(SearchableBookmark(event.bookmark));
            var filterList = _updateFilter(
                currentState.filterData, currentState.bookmarkList);
            return currentState.copyWith(
              version: currentState.version + 1,
              filteredBookmarkList: filterList,
            );
          });
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapRemoveBookmark(RemoveBookmark event) async* {
    yield await state.maybeMap(
        ready: (currentState) {
          return dataStore
              .transaction<dynamic>(
                  (dataStore) => dataStore.delete(event.bookmark))
              .then((dynamic value) {
            currentState.bookmarkList
                .removeWhere((element) => element.bookmark == event.bookmark);
            currentState.filteredBookmarkList
                .removeWhere((element) => element.value == event.bookmark);
            return currentState.copyWith(version: currentState.version + 1);
          });
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapIncrementBookmark(
      IncrementProgress event) async* {
    yield await state.maybeMap(
        ready: (currentState) {
          event.bookmark.incrementProgress();
          return _updateBookmark(event.bookmark).then((dynamic value) {
            return currentState.copyWith(version: currentState.version + 1);
          });
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapUpdateBookmark(UpdateBookmark event) async* {
    yield await state.maybeMap(
        ready: (currentState) =>
            _updateBookmark(event.bookmark).then((dynamic value) {
              return currentState.copyWith(version: currentState.version + 1);
            }),
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapUpdateFilterQuery(
      UpdateFilterQuery event) async* {
    yield await state.maybeMap(
        ready: (currentState) {
          var filterData = FilterRuntimeData(currentState.filterData.filterData,
              query: event.query.toLowerCase());
          return _reFilter(currentState, filterData);
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapUpdateFilterData(
      UpdateFilterData event) async* {
    yield await state.maybeMap(
        ready: (currentState) {
          var filterData = FilterRuntimeData(event.data,
              query: currentState.filterData.query);
          return _reFilter(currentState, filterData);
        },
        orElse: () => state);
  }

  Future _updateBookmark(IPersistentBookmark bookmark) async {
    return await dataStore
        .transaction<dynamic>((dataStore) => dataStore.update(bookmark));
  }

  List<SearchResult<IPersistentBookmark>> _updateFilter(
      FilterRuntimeData filterRuntimeData,
      Iterable<SearchableBookmark> bookmarks) {
    var filterList = bookmarks;

    var filterData = filterRuntimeData.filterData;

    if (!filterData.abandoned) {
      filterList = filterList.where((readable) => !readable.bookmark.abandoned);
    }

    if (!filterData.ended) {
      filterList = filterList.where((readable) => readable.bookmark.ongoing);
    }

    if (!filterData.finished) {
      filterList = filterList.where((readable) =>
          readable.bookmark.ongoing ||
          readable.bookmark.progress < readable.bookmark.maxProgress);
    }

    if (!filterData.ongoing) {
      filterList = filterList.where((readable) => !readable.bookmark.ongoing);
    }

    var strippedFilter = StringExtensions.stripString(filterRuntimeData.query);

    if (strippedFilter.isNotEmpty) {
      var matchList = filterList
          .map((e) => Pair(e.bestMatch(strippedFilter), e))
          .where((element) => element.item1.match > 0)
          .toList();

      matchList.sort((a, b) {
        var aValue = a.item1.match * a.item1.priority;
        var bValue = b.item1.match * b.item1.priority;
        if (aValue > bValue) {
          return -1;
        } else if (aValue < bValue) {
          return 1;
        } else {
          return 0;
        }
      });

      filterList = matchList.map((e) => e.item2).toList();
      return matchList
          .map((e) => SearchResult(e.item2.bookmark, e.item1.match))
          .toList();
    } else {
      return filterList.map((e) => SearchResult(e.bookmark, 1.0)).toList();
    }
  }

  BookmarkBlocState _reFilter(Ready state, FilterRuntimeData newRuntimeData) {
    var newFilter = _updateFilter(newRuntimeData, state.bookmarkList);
    return state.copyWith(
      version: state.version + 1,
      filterData: newRuntimeData,
      filteredBookmarkList: newFilter,
    );
  }
}
