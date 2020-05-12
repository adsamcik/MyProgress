import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/storage.dart';

class DataStore extends Storage<int, PersistentBookmark> {
  DataStore(DataSource<int, PersistentBookmark> dataSource) : super(dataSource);
}
