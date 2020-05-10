import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/storage.dart';

class DataStore extends Storage<int, IPersistentBookmark> {
  DataStore(DataSource<int, IPersistentBookmark> dataSource)
      : super(dataSource);
}
