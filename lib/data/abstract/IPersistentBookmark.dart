import 'IBookmark.dart';
import '../database/data/abstract/IDatabaseItem.dart';

abstract class IPersistentBookmark implements IBookmark, IDatabaseItem {
  @override
  String? Id;
}
