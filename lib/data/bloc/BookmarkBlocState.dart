import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BookmarkBlocState.freezed.dart';

@freezed
abstract class BookmarkBlocState with _$BookmarkBlocState {
  const factory BookmarkBlocState.notReady() = NotReady;

  const factory BookmarkBlocState.ready({
    @required int version,
    @required List<IPersistentBookmark> bookmarkList,
  }) = Ready;

  const factory BookmarkBlocState.error() = Error;
}
