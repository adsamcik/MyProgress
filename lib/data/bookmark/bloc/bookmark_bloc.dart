import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:markmyprogress/data/bookmark/bloc/bookmark_bloc_event.dart';
import 'package:markmyprogress/data/bookmark/database/data_store.dart';
import 'package:markmyprogress/data/bookmark/filter/filter_data.dart';
import 'package:markmyprogress/data/bookmark/filter/filter_runtime_data.dart';
import 'package:markmyprogress/data/bookmark/filter/searchable_bookmark.dart';
import 'package:markmyprogress/data/preference/database/preference.dart';
import 'package:markmyprogress/data/preference/database/preference_store.dart';
import 'package:markmyprogress/data/runtime/pair.dart';
import 'package:markmyprogress/data/runtime/search_result.dart';
import 'package:markmyprogress/data/storage/abstraction/storage_subscribable.dart';
import 'package:markmyprogress/extensions/bookmark_extensions.dart';
import 'package:markmyprogress/extensions/string_extensions.dart';

import 'bookmark_bloc_event.dart';
import 'bookmark_bloc_state.dart';

class BookmarkBloc extends Bloc<BookmarkBlocEvent, BookmarkBlocState> {
  static const double filterThreshold = 0.8;

  final DataStore dataStore;
  final PreferenceStore settingsStore;

  BookmarkBloc({@required this.dataStore, @required this.settingsStore}) {
    settingsStore.subscribeToDataChanges(_onSettingsChanged);
  }

  @override
  Future<void> close() async {
    await super.close();
    await dataStore.close();
  }

  @override
  BookmarkBlocState get initialState => BookmarkBlocState.notReady();

  void _onSettingsChanged(StorageEvent event, Iterable<Preference> preferences) {
    var json = FilterData().toJson();
    if (preferences.any((element) => json.containsKey(element.key))) {
      settingsStore.getFilterData().then((filterData) => add(BookmarkBlocEvent.updateFilterData(data: filterData)));
    }
  }

  @override
  Stream<BookmarkBlocState> mapEventToState(BookmarkBlocEvent event) async* {
    yield* event.map(
      load: _mapLoad,
      saveBookmark: _mapSaveBookmark,
      removeBookmark: _mapRemoveBookmark,
      incrementProgress: _mapIncrementBookmark,
      updateFilterQuery: _mapUpdateFilterQuery,
      updateFilterData: _mapUpdateFilterData,
    );
  }

  void _sortData(List<SearchableBookmark> list) {
    list.sort((a, b) => a.bookmark.title.toLowerCase().compareTo(b.bookmark.title.toLowerCase()));
  }

  Stream<BookmarkBlocState> _mapLoad(Load event) async* {
    var dataList = await await dataStore
        .transactionClosed((dataStore) => dataStore.getAll().map((e) => SearchableBookmark(e)).toList());
    var filterData = await settingsStore.transactionClosed((settingsStore) => settingsStore.getFilterData());

    _sortData(dataList);

    var filterRuntimeData = FilterRuntimeData(filterData);
    var filterList = _updateFilter(filterRuntimeData, dataList);
    yield BookmarkBlocState.ready(
      version: 0,
      bookmarkList: dataList,
      filteredBookmarkList: filterList,
      filterData: filterRuntimeData,
    );
  }

  Stream<BookmarkBlocState> _mapSaveBookmark(AddBookmark event) async* {
    yield await state.maybeMap(
        ready: (ready) {
          return dataStore.transactionClosed<dynamic>((transaction) {
            if (event.bookmark.key == null) {
              ready.bookmarkList.add(SearchableBookmark(event.bookmark));
              _sortData(ready.bookmarkList);
              return transaction.insertAuto(event.bookmark);
            } else {
              _sortData(ready.bookmarkList);
              return transaction.update(event.bookmark);
            }
          }).then((dynamic value) {
            var filterList = _updateFilter(ready.filterData, ready.bookmarkList);
            return ready.copyWith(
              version: ready.version + 1,
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
              .transactionClosed<dynamic>((dataStore) => dataStore.delete(event.bookmark.key))
              .then((dynamic value) {
            currentState.bookmarkList.removeWhere((element) => element.bookmark == event.bookmark);
            currentState.filteredBookmarkList.removeWhere((element) => element.value == event.bookmark);
            return currentState.copyWith(version: currentState.version + 1);
          });
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapIncrementBookmark(IncrementProgress event) async* {
    yield await state.maybeMap(
        ready: (currentState) {
          event.bookmark.incrementProgress();
          return _updateBookmark(event.bookmark).then((dynamic value) {
            return currentState.copyWith(version: currentState.version + 1);
          });
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapUpdateFilterQuery(UpdateFilterQuery event) async* {
    yield await state.maybeMap(
        ready: (ready) {
          var filterData = ready.filterData.copyWith(query: event.query.toLowerCase());
          return _reFilter(ready, filterData);
        },
        orElse: () => state);
  }

  Stream<BookmarkBlocState> _mapUpdateFilterData(UpdateFilterData event) async* {
    yield await state.maybeMap(
        ready: (ready) {
          var filterData = ready.filterData.copyWith(filterData: event.data);
          return _reFilter(ready, filterData);
        },
        orElse: () => state);
  }

  Future _updateBookmark(PersistentBookmark bookmark) async {
    return await dataStore.transactionClosed<dynamic>((dataStore) => dataStore.update(bookmark));
  }

  List<SearchResult<PersistentBookmark>> _updateFilter(
      FilterRuntimeData filterRuntimeData, Iterable<SearchableBookmark> bookmarks) {
    var filterList = bookmarks;

    var filterData = filterRuntimeData.filterData;

    if (!filterData.abandoned) {
      filterList = filterList.where((readable) => !readable.bookmark.abandoned);
    }

    if (!filterData.ended) {
      filterList = filterList.where((readable) => readable.bookmark.ongoing);
    }

    if (!filterData.finished) {
      filterList = filterList
          .where((readable) => readable.bookmark.ongoing || readable.bookmark.progress < readable.bookmark.maxProgress);
    }

    if (!filterData.ongoing) {
      filterList = filterList.where((readable) => !readable.bookmark.ongoing);
    }

    var strippedFilter = StringExtensions.stripString(filterRuntimeData.query);

    if (strippedFilter.isNotEmpty) {
      var matchList = filterList
          .map((e) => Pair(e.bestMatch(strippedFilter), e))
          .where((element) => element.item1.match > filterThreshold)
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
      return matchList.map((e) => SearchResult(e.item2.bookmark, e.item1.match)).toList();
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
