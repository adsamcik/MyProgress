import 'dart:async';

import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';

import 'storable.dart';

abstract class Storage<Key, Value extends Storable<Key>> {
  final DataSource<Key, Value> _dataSource;
  final Map<Key, Value> _cache = <Key, Value>{};

  bool get isOpen => _dataSource.isOpen;

  int _openCounter = 0;

  Storage(this._dataSource);

  void _onDataListener(Value item) {
    _cache[item.key] = item;
  }

  /// Opens storage
  Future open() async {
    if (_openCounter++ == 0) {
      await _dataSource.open();
    }
  }

  /// Closes storage
  Future close() async {
    assert(_openCounter > 0);
    if (--_openCounter <= 0) {
      await _dataSource.close();
      assert(_openCounter == 0);
    }
  }

  void purgeCache() {
    _cache.clear();
  }

  Stream<Value> getAll() {
    _checkIfOpen();
    return _dataSource.getAll().map((item) {
      _onDataListener(item);
      return item;
    });
  }

  Stream<Value> getAllWithKeys(Iterable<Key> keys) {
    _checkIfOpen();
    return _dataSource.getAllWithKeys(keys);
  }

  Future<Value> get(Key key) async {
    _checkIfOpen();
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

  Future<Key> insertAuto(Value item) async {
    _checkIfOpen();
    assert(item.key == null, 'Key must be null for auto insertion');
    var key = await _dataSource.insertAuto(item);
    _cache[key] = item;
    return key;
  }

  Future<bool> insert(Value item) async {
    _checkIfOpen();
    assert(item.key != null, 'Key must not be null for insertion at key');
    var success = await _dataSource.insert(item);
    if (success) {
      _cache[item.key] = item;
    }

    return success;
  }

  Future<Iterable<bool>> insertAll(Iterable<Value> value) async {
    _checkIfOpen();
    var result = await Future.wait(value.map((e) => _dataSource.insert(e)));
    var resultIt = result.iterator;
    value.forEach((element) {
      if (resultIt.moveNext()) {
        _cache[element.key] = element;
      }
    });
    return result;
  }

  Future<bool> delete(Key key) async {
    _checkIfOpen();
    _cache.remove(key);
    return await _dataSource.delete(key);
  }

  Future<StorageEvent> upsert(Value item) async {
    _checkIfOpen();
    _cache[item.key] = item;
    return await _dataSource.upsert(item);
  }

  Future<bool> update(Value item) async {
    _checkIfOpen();
    _cache[item.key] = item;
    return await _dataSource.update(item);
  }

  Future<Result> transactionClosed<Result>(
      FutureOr<Result> Function(Storage<Key, Value> storage)
          transactionFunc) async {
    try {
      await open();
      return await transaction(transactionFunc);
    } catch (error, trace) {
      print(error);
      print(trace);
      return null;
    } finally {
      await close();
    }
  }

  Future<Result> transaction<Result>(
      FutureOr<Result> Function(Storage<Key, Value> storage)
          transactionFunc) async {
    // todo implement transactions properly
    return await transactionFunc(this);
    /*await open();

    await close();
    var result =
        await _dataSource.transaction((storage -- this needs to be used) => transactionFunc(this));*/
  }

  void _checkIfOpen() {
    assert(
        isOpen,
        'storage is not open. '
        'It needs to be opened before doing any operations on it.');
  }
}
