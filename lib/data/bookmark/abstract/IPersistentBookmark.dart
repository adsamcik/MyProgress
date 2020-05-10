import 'package:MarkMyProgress/data/database/abstract/IDatabaseItem.dart';

import 'IBookmark.dart';

abstract class IPersistentBookmark implements IBookmark, IDatabaseItem {}
