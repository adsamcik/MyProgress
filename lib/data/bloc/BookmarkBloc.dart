import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/bloc/BookmarkBlocEvent.dart';
import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'BookmarkBlocState.dart';

class BookmarkBloc extends Bloc<BookmarkBlocEvent, BookmarkBlocState> {
  final DataStore dataStore;

  BookmarkBloc({@required this.dataStore});

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
    );
  }

  Stream<BookmarkBlocState> _mapLoad(Load event) async* {
    yield await dataStore.transaction((dataStore) => dataStore.getAll()).then(
      (value) =>
          BookmarkBlocState.ready(version: 0, bookmarkList: value.toList()),
      onError: (dynamic obj, StackTrace trace) {
        print(trace);
        return BookmarkBlocState.error();
      },
    );
  }

  Stream<BookmarkBlocState> _mapAddBookmark(AddBookmark event) async* {
    yield await state.maybeWhen(
        ready: (list, version) {
          return dataStore
              .transaction<dynamic>(
                  (dataStore) => dataStore.insert(event.bookmark))
              .then((dynamic value) {
            list.add(event.bookmark);
            return BookmarkBlocState.ready(
                version: ++version, bookmarkList: list);
          });
        },
        orElse: () => BookmarkBlocState.error());
  }

  Stream<BookmarkBlocState> _mapRemoveBookmark(RemoveBookmark event) async* {
    yield await state.maybeWhen(
        ready: (list, version) {
          return dataStore
              .transaction<dynamic>(
                  (dataStore) => dataStore.delete(event.bookmark))
              .then((dynamic value) {
            list.remove(event.bookmark);
            return BookmarkBlocState.ready(
                version: ++version, bookmarkList: list);
          });
        },
        orElse: () => BookmarkBlocState.error());
  }

  Stream<BookmarkBlocState> _mapIncrementBookmark(
      IncrementProgress event) async* {
    yield await state.maybeWhen(
        ready: (list, version) {
          event.bookmark.incrementProgress();
          return _updateBookmark(event.bookmark).then((dynamic value) {
            return BookmarkBlocState.ready(
                version: ++version, bookmarkList: list);
          });
        },
        orElse: () => BookmarkBlocState.error());
  }

  Stream<BookmarkBlocState> _mapUpdateBookmark(UpdateBookmark event) async* {
    yield await state.maybeWhen(
        ready: (list, version) {
          return _updateBookmark(event.bookmark).then((dynamic value) {
            return BookmarkBlocState.ready(
                version: ++version, bookmarkList: list);
          });
        },
        orElse: () => BookmarkBlocState.error());
  }

  Future _updateBookmark(IPersistentBookmark bookmark) async {
    return await dataStore
        .transaction<dynamic>((dataStore) => dataStore.update(bookmark));
  }
}
