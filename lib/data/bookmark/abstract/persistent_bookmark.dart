import 'package:myprogress/data/storage/abstraction/storable.dart';

import 'bookmark.dart';

abstract class PersistentBookmark implements Bookmark, Storable<int> {}
