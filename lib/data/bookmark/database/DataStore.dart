import 'dart:async';

import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/database/abstract/DatabaseCollection.dart';

class DataStore extends DatabaseCollection<IPersistentBookmark> {
  Future<T> transaction<T>(
      FutureOr<T> Function(DataStore dataStore) action) async {
    await open();
    var result = await action(this);
    await close();
    return result;
  }
}
