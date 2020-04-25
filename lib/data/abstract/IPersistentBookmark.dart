import 'IBookmark.dart';

abstract class IPersistentBookmark implements IBookmark, IDatabaseItem {
		ObjectId? Id;
}
