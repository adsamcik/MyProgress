import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';

import 'abstraction/storable.dart';

abstract class Storage<Key, Value extends Storable<Key>> {
  final DataSource<Key, Value> _dataSource;
  final Map<Key, Value> _cache = <Key, Value>{};

  Storage(this._dataSource);

  void _onDataListener(Value item) {
    _cache[item.key] = item;
  }

  /// Opens storage
  Future open() async {
    await _dataSource.open();
  }

  /// Closes storage
  Future close() async {
    await _dataSource.close();
  }

  void purgeCache() {
    _cache.clear();
  }

  Stream<Value> getAll() {
    return _dataSource.getAll().map((item) {
      _onDataListener(item);
      return item;
    });
  }

  Stream<Value> getAllWithKeys(Iterable<Key> keys) {
    return _dataSource.getAllWithKeys(keys);
  }

  Future<Value> get(Key key) async {
    var cached = _cache[key];
    if (cached != null) {
      return cached;
    } else {
      var item = await _dataSource.getWithKey(key);
      if (item != null) {
        item is Value;
        item.key = key;
        _onDataListener(item);
      }
      return item;
    }
  }

  Future<Key> insert(Value item) async {
    var key = await _dataSource.insertAuto(item);
    _cache[key] = item;
    return key;
  }

  Future<bool> delete(Key key) async {
    _cache.remove(key);
    return await _dataSource.delete(key);
  }

  Future upsert(Value item) async {
    _cache[item.key] = item;
    await _dataSource.upsert(item);
  }

  Future<bool> update(Value item) async {
    _cache[item.key] = item;
    return await _dataSource.update(item);
  }

  Future<Result> transaction<Result>(
      Result Function(Storage<Key, Value> storage) transactionFunc) async {
    await open();
    var result =
        await _dataSource.transaction((storage) => transactionFunc(this));
    await close();
    return result;
  }
}
