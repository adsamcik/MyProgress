import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/filter/filter_runtime_data.dart';
import 'package:MarkMyProgress/data/bookmark/filter/searchable_bookmark.dart';
import 'package:MarkMyProgress/data/runtime/SearchResult.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_bloc_state.freezed.dart';

@freezed
abstract class BookmarkBlocState with _$BookmarkBlocState {
  const factory BookmarkBlocState.notReady() = NotReady;

  const factory BookmarkBlocState.ready({
    @required int version,
    @required List<SearchableBookmark> bookmarkList,
    @required List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
    @required FilterRuntimeData filterData,
  }) = Ready;
}
