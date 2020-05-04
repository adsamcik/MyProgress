import 'package:MarkMyProgress/data/database/data/abstract/IDatabaseItem.dart';
import 'package:MarkMyProgress/data/instance/GenericBookmark.dart';
import 'package:sembast/sembast.dart';

import 'DatabaseProxy.dart';

/// <summary>
///     Generic implementation of database collection providing basic methods to work with collection.
/// </summary>
/// <typeparam name="T"></typeparam>
abstract class DatabaseCollection<T extends IDatabaseItem> {
  final DatabaseProxy<int, Map<String, dynamic>> _proxy = DatabaseProxy(databasePath: 'progress_data.db');

  Iterable<int> _mapKeys(Iterable<T> items) => items.map((e) => e.id);

  void open() async {
    await _proxy.open();
  }

  void close() async {
    await _proxy.close();
  }

  /// <summary>
  ///     Updates single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> update(T item) async {
    return await _proxy.update(item.id, item.toJson());
  }

  /// <summary>
  ///     Updates all items in a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<List<dynamic>> updateAll(Iterable<T> iterable) async {
    var keys = _mapKeys(iterable);
    var data = iterable.map((e) => e.toJson()).toList(growable: false);
    return await _proxy.updateAll(keys, data);
  }

  /// <summary>
  ///     Inserts single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future insert(T item) async {
    item.id = await _proxy.insert(item.toJson());
  }

  /// <summary>
  ///     Inserts item collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future insertAll(Iterable<T> iterable) async {
    var data = iterable.map((e) => e.toJson()).toList(growable: false);
    var keyList = (await _proxy.insertAll(data));
    var keyIterator = keyList.iterator;
    iterable.forEach((element) {
      keyIterator.moveNext();
      element.id = keyIterator.current;
    });
  }

  /// <summary>
  ///     Removes single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> delete(T item) async {
    return await _proxy.delete(item.id);
  }

  /// <summary>
  ///     Removes all items from a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<dynamic> deleteAll(Iterable<T> iterable) async {
    var keys = _mapKeys(iterable);
    return _proxy.deleteAll(keys);
  }

  /// <summary>
  ///     Returns all items in a database.
  /// </summary>
  /// <returns>Item collection (Enumerable).</returns>
  Future<Iterable<T>> getAll({Finder finder}) async {
    var records = await _proxy.getAll((e) {
      var value = Map<String, dynamic>.from(e.value as Map<String, dynamic>);
      value['id'] = e.key;
      return value;
    }, finder: finder);
    return records.map((e) {
      var bookmark = GenericBookmark.fromJson(e) as T;
      // ID is not serialized
      bookmark.id = e['id'] as int;
      return bookmark;
    });
  }

  /// <summary>
  ///     Upserts an item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> upsert(T item) async {
    return await _proxy.upsert(item.id, item.toJson());
  }
}
