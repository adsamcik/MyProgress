import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';

import 'abstraction/storable.dart';

class Storage<Key, Value extends Storable<Key>> {
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
    var stream = _dataSource.getAll();
    stream.listen(_onDataListener);
    return stream;
  }

  Stream<Value> getAllWithKeys(Iterable<Key> keys) {}

  Future<Value> get(Key key) async {
    var cached = _cache[key];
    if (cached != null) {
      return cached;
    } else {
      var item = await _dataSource.getWithKey(key);
      if (item != null) {
        item is Value;
        item.key = key;
      }
      return item;
    }
  }

  Future<Key> insert(Value item) async {
    return await _dataSource.insertAuto(item);
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
