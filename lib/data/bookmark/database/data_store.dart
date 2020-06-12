import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:markmyprogress/data/storage/abstraction/data_source.dart';
import 'package:markmyprogress/data/storage/abstraction/storage.dart';

class DataStore extends Storage<int, PersistentBookmark> {
  DataStore(DataSource<int, PersistentBookmark> dataSource) : super(dataSource);
}
