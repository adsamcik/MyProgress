import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BookmarkBlocEvent.freezed.dart';

@freezed
abstract class BookmarkBlocEvent with _$BookmarkBlocEvent {
  const factory BookmarkBlocEvent.load() = Load;

  const factory BookmarkBlocEvent.addBookmark(
      {@required IPersistentBookmark bookmark}) = AddBookmark;

  const factory BookmarkBlocEvent.removeBookmark(
      {@required IPersistentBookmark bookmark}) = RemoveBookmark;

  const factory BookmarkBlocEvent.updateBookmark(
      {@required IPersistentBookmark bookmark}) = UpdateBookmark;

  const factory BookmarkBlocEvent.incrementProgress(
      {@required IPersistentBookmark bookmark}) = IncrementProgress;

  const factory BookmarkBlocEvent.updateFilterQuery({@required String query}) =
      UpdateFilterQuery;
}
