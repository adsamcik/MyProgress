import 'package:MarkMyProgress/data/database/data/abstract/IDatabaseItem.dart';
import 'package:MarkMyProgress/data/instance/GenericBookmark.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// <summary>
///     Generic implementation of database collection providing basic methods to work with collection.
/// </summary>
/// <typeparam name="T"></typeparam>
abstract class DatabaseCollection<T extends IDatabaseItem> {
  Database _database;

  void open() async {
    /*var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, 'progress_data.db');*/
    _database = await databaseFactoryIo.openDatabase('progress_data.db');
  }

  void close() async {
    await _database.close();
  }

  StoreRef _store() => StoreRef<int, dynamic>.main();

  Iterable<int> _mapKeys(Iterable<T> items) => items.map((e) => e.id);

  /// <summary>
  ///     Updates single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> update(T item) async {
    return await _store().record(item.id).put(_database, item.toJson());
  }

  /// <summary>
  ///     Updates all items in a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<List<dynamic>> updateAll(Iterable<T> iterable) async {
    var keys = _mapKeys(iterable);
    var data = iterable.map((e) => e.toJson()).toList(growable: false);
    return await _store().records(keys).put(_database, data);
  }

  /// <summary>
  ///     Inserts single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> insert(T item) async {
    return await _store().add(_database, item.toJson());
  }

  /// <summary>
  ///     Inserts item collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<List<dynamic>> insertAll(Iterable<T> iterable) async {
    var data = iterable.map((e) => e.toJson()).toList(growable: false);
    return await _store().addAll(_database, data);
  }

  /// <summary>
  ///     Removes single item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> delete(T item) async {
    return await _store().record(item.id).delete(_database);
  }

  /// <summary>
  ///     Removes all items from a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  Future<dynamic> deleteAll(Iterable<T> iterable) async {
    var keys = _mapKeys(iterable);
    return await _store().records(keys).delete(_database);
  }

  /// <summary>
  ///     Returns all items in a database.
  /// </summary>
  /// <returns>Item collection (Enumerable).</returns>
  Future<Iterable<T>> GetAll() async {
    var records = await _store().find(_database);
    return records.map(
        (e) => GenericBookmark.fromJson(e.value as Map<String, dynamic>) as T);
  }

  /// <summary>
  ///     Upserts an item.
  /// </summary>
  /// <param name="item">Item.</param>
  Future<dynamic> upsert(T item) async {
    return await update(item);
  }
}
