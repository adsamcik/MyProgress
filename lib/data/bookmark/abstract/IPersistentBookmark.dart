import 'package:MarkMyProgress/data/database/data/abstract/IDatabaseItem.dart';

import 'IBookmark.dart';

abstract class IPersistentBookmark implements IBookmark, IDatabaseItem {}
