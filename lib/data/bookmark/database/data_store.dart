import 'package:myprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:myprogress/data/storage/abstraction/data_source.dart';
import 'package:myprogress/data/storage/abstraction/storage.dart';

class DataStore extends Storage<int, PersistentBookmark> {
  DataStore(DataSource<int, PersistentBookmark> dataSource) : super(dataSource);
}
