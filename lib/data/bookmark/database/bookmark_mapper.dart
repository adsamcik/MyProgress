import 'package:myprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:myprogress/data/bookmark/instance/generic_bookmark.dart';
import 'package:myprogress/data/storage/abstraction/storage_mapper.dart';

class BookmarkMapper implements StorageMapper<PersistentBookmark, Map<String, dynamic>> {
  @override
  PersistentBookmark fromDatabase(value) {
    return GenericBookmark.fromJson(value);
  }

  @override
  Map<String, dynamic> toDatabase(value) {
    return value.toJson();
  }
}
