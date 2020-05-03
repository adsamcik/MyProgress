import 'package:flutter/cupertino.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:MarkMyProgress/extensions/ListExtensions.dart';

/// <summary>
///     Generic implementation of database collection providing basic methods to work with collection.
/// </summary>
/// <typeparam name="T"></typeparam>
class DatabaseProxy<Key, Value> {
  Database _database;
  final String databasePath;

  DatabaseProxy({@required this.databasePath});

  void open() async {
    _database = await databaseFactoryIo.openDatabase(databasePath);
  }

  void close() async {
    await _database.close();
  }

  StoreRef _store() => StoreRef<Key, Value>.main();

  /// <summary>
  ///     Updates single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> update(Key key, Value item) async {
    return await _store().record(key).update(_database, item);
  }

  /// <summary>
  ///     Updates all items in a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<List<dynamic>> updateAll(Iterable<Key> keys, Iterable<Value> values) async {
    return await _store().records(keys).update(_database, values.toList(growable: false));
  }

  /// <summary>
  ///     Inserts single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<Key> insert(Value item) async {
    return await _store().add(_database, item) as Key;
  }

  /// <summary>
  ///     Inserts item collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<Iterable<Key>> insertAll(Iterable<Value> values) async {
    var keyList = await _store().addAll(_database, values.toList(growable: false));
    return keyList.cast();
  }

  /// <summary>
  ///     Removes single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> delete(Key key) async {
    return await _store().record(key).delete(_database);
  }

  /// <summary>
  ///     Removes all items from a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<dynamic> deleteAll(Iterable<Key> keys) async {
    return await _store().records(keys).delete(_database);
  }

  /// <summary>
  ///     Returns all items in a database.
  /// </summary>
  /// <returns>Item collection (Enumerable).</returns>
  Future<Iterable<Value>> getAll(Value Function(RecordSnapshot<dynamic, dynamic>) mapToValue, {Finder finder}) async {
    var records = await _store().find(_database, finder: finder);
    return records.map(mapToValue);
  }

  /// <summary>
  ///     Returns all items in a database.
  /// </summary>
  /// <returns>Item collection (Enumerable).</returns>
  Future<Iterable<MapEntry<Key, Value>>> getAllWithKeys(Iterable<Key> keys) async {
    var records = await _store().records(keys).getSnapshots(_database);
    return records.map((e) => e != null ? MapEntry(e.key as Key, e.value as Value) : null);
  }

  Future<Value> get(Value Function(RecordSnapshot<dynamic, dynamic>) mapToValue, {Finder finder}) async {
    return mapToValue(await _store().findFirst(_database, finder: finder));
  }

  /// <summary>
  ///     Upserts an item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> upsert(Key key, Value value) async {
    return await _store().record(key).put(_database, value);
  }
}
