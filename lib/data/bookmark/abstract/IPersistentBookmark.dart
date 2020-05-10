import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';

import 'IBookmark.dart';

abstract class IPersistentBookmark implements IBookmark, Storable<int> {}
