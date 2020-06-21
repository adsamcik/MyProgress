import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:myprogress/data/bookmark/filter/filter_runtime_data.dart';
import 'package:myprogress/data/bookmark/filter/searchable_bookmark.dart';
import 'package:myprogress/data/runtime/search_result.dart';

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
