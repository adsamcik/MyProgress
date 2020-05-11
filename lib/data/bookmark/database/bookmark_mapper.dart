import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/bookmark/instance/GenericBookmark.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_mapper.dart';

class BookmarkMapper
    implements StorageMapper<IPersistentBookmark, Map<String, dynamic>> {
  @override
  IPersistentBookmark fromDatabase(value) {
    return GenericBookmark.fromJson(value);
  }

  @override
  Map<String, dynamic> toDatabase(value) {
    return value.toJson();
  }
}
