import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:markmyprogress/data/bookmark/filter/filter_data.dart';

part 'bookmark_bloc_event.freezed.dart';

@freezed
abstract class BookmarkBlocEvent with _$BookmarkBlocEvent {
  const factory BookmarkBlocEvent.load() = Load;

  const factory BookmarkBlocEvent.saveBookmark({@required PersistentBookmark bookmark}) = AddBookmark;

  const factory BookmarkBlocEvent.removeBookmark({@required PersistentBookmark bookmark}) = RemoveBookmark;

  const factory BookmarkBlocEvent.incrementProgress({@required PersistentBookmark bookmark}) = IncrementProgress;

  const factory BookmarkBlocEvent.updateFilterQuery({@required String query}) = UpdateFilterQuery;

  const factory BookmarkBlocEvent.updateFilterData({@required FilterData data}) = UpdateFilterData;
}
