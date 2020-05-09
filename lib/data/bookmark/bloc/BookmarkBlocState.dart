import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/bookmark/runtime/SearchableBookmark.dart';
import 'package:MarkMyProgress/data/runtime/FilterRuntimeData.dart';
import 'package:MarkMyProgress/data/runtime/SearchResult.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BookmarkBlocState.freezed.dart';

@freezed
abstract class BookmarkBlocState with _$BookmarkBlocState {
  const factory BookmarkBlocState.notReady() = NotReady;

  const factory BookmarkBlocState.ready({
    @required int version,
    @required List<SearchableBookmark> bookmarkList,
    @required List<ISearchResult<IPersistentBookmark>> filteredBookmarkList,
    @required FilterRuntimeData filterData,
  }) = Ready;
}
