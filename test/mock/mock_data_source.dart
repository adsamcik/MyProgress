import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';

class MockIntDataSource<Value extends Storable<int>>
    extends MockDataSource<int, Value> {
  int _lastKey = -1;

  @override
  int nextKey() => ++_lastKey;
}

class MockStringDataSource<Value extends Storable<String>>
    extends MockDataSource<String, Value> {
  int _lastKey = -1;

  @override
  String nextKey() => '${DateTime.now().toString()}_${(++_lastKey).toString()}';
}

abstract class MockDataSource<Key, Value extends Storable<Key>>
    extends DataSource<Key, Value> {
  bool _isOpen = false;

  @override
  bool get isOpen => _isOpen;

  final Map<Key, Value> _data = <Key, Value>{};

  /// Increment current key value and return it
  Key nextKey();

  @override
  Future close() async {
    assert(_isOpen);
    _isOpen = false;
  }

  @override
  Future<bool> delete(Key key) async {
    assert(_isOpen);
    if (_data.containsKey(key)) {
      // Returned null doesn't mean key was absent
      _data.remove(key);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteWithValue(Value value) async {
    assert(_isOpen);
    if (_data.containsValue(value)) {
      _data.removeWhere((key, itemValue) => value == itemValue);
      return true;
    } else {
      return false;
    }
  }

  @override
  Stream<Value> getAll() {
    assert(_isOpen);
    return Stream.fromIterable(_data.values);
  }

  @override
  Stream<Value> getAllWithKeys(Iterable<Key> keys) {
    assert(_isOpen);
    return Stream.fromIterable(keys.map((key) => _data[key]));
  }

  @override
  Future<Value> getWithKey(Key key) async {
    assert(_isOpen);
    return _data[key];
  }

  @override
  Future<bool> insert(Value value) async {
    assert(_isOpen);
    assert(value.key != null);
    if (_data.containsKey(value.key)) {
      return false;
    } else {
      _data[value.key] = value;
      return true;
    }
  }

  @override
  Future<Key> insertAuto(Value value) async {
    assert(_isOpen);
    var key = nextKey();
    _data[key] = value;
    value.key = key;
    return key;
  }

  @override
  Future open() async {
    assert(!_isOpen);
    _isOpen = true;
  }

  @override
  Future<Result> transaction<Result>(
          Result Function(DataSource<Key, Value> storage)
              transactionFunc) async =>
      transactionFunc(this);

  @override
  Future<bool> update(Value value) async {
    assert(_isOpen);

    if (_data.containsKey(value.key)) {
      _data[value.key] = value;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<StorageEvent> upsert(Value value) async {
    assert(_isOpen);
    assert(value.key != null);

    var exists = _data.containsKey(value.key);
    _data[value.key] = value;
    return exists ? StorageEvent.updated : StorageEvent.inserted;
  }
}
