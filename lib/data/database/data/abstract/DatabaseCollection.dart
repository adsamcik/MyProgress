import 'package:MarkMyProgress/data/database/data/abstract/IDatabaseItem.dart';
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
  void update(T item) {
    _store().record(item.id).put(_database, item);
  }

  /// <summary>
  ///     Updates all items in a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  void updateAll(Iterable<T> iterable) {
    var keys = _mapKeys(iterable);
    _store().records(keys).put(_database, iterable.toList(growable: false));
  }

  /// <summary>
  ///     Inserts single item.
  /// </summary>
  /// <param name="item">Item.</param>
  void insert(T item) {
    _store().record(item.id).add(_database, item);
  }

  /// <summary>
  ///     Inserts item collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  void insertAll(Iterable<T> iterable) {
    var keys = _mapKeys(iterable);
    _store().records(keys).add(_database, iterable.toList());
  }

  /// <summary>
  ///     Removes single item.
  /// </summary>
  /// <param name="item">Item.</param>
  void delete(T item) {
    _store().record(item.id).delete(_database);
  }

  /// <summary>
  ///     Removes all items from a collection.
  /// </summary>
  /// <param name="itemEnumerable">Item collection (Enumerable).</param>
  void deleteAll(Iterable<T> iterable) {
    var keys = _mapKeys(iterable);
    _store().records(keys).delete(_database);
  }

  /// <summary>
  ///     Returns all items in a database.
  /// </summary>
  /// <returns>Item collection (Enumerable).</returns>
  Future<Iterable<T>> GetAll() async {
    var records = await _store().find(_database);
    return records.map((e) => e.value as T);
  }

  /// <summary>
  ///     Upserts an item.
  /// </summary>
  /// <param name="item">Item.</param>
  void upsert(T item) {
    update(item);
  }
}
