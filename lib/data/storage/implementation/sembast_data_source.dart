import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDataSource<Key, Value extends Storable<Key>>
    extends DataSource<Key, Value> {
  final String _connectionString;
  final Value Function(Map<String, dynamic> map) _mappingFunction;

  DatabaseClient _databaseClient;

  StoreRef get _store => StoreRef<Key, Value>.main();

  SembastDataSource(this._connectionString, this._mappingFunction);

  @override
  Future close() async {
    var database = _databaseClient;
    if (database is Database) {
      await database.close();
    } else {
      throw StateError('Close can only be called for database');
    }
  }

  Value _mapDatabaseItemToValue(dynamic value) =>
      _mappingFunction(value as Map<String, dynamic>);

  @override
  Stream<Value> getAll() {
    return _store.stream(_databaseClient).map((event) {
      var value = _mapDatabaseItemToValue(event.value);
      value.key = event.key as Key;
      return value;
    });
  }

  @override
  Stream<Value> getAllWithKeys(Iterable<Key> keys) {
    return _store
        .records(keys)
        .get(_databaseClient)
        .asStream()
        .map(
          (list) => list.map(
            (dynamic element) =>
                element != null ? _mapDatabaseItemToValue(element) : null,
          ),
        )
        .expand((element) => element.cast());
  }

  @override
  Future<Value> getWithKey(Key key) async {
    var item = _mapDatabaseItemToValue(_store.record(key).get(_databaseClient));
    item.key = key;
    return item;
  }

  @override
  Future open() async {
    assert(_databaseClient == null);
    _databaseClient = await databaseFactoryIo.openDatabase(_connectionString);
  }

  Future _openWithClient(DatabaseClient database) async {
    _databaseClient = database;
  }

  @override
  Future<Key> insertAuto(Value item) async {
    var key = await _store.add(_databaseClient, item) as Key;
    item.key = key;
    return key;
  }

  @override
  Future<bool> insert(Value item) async {
    assert(item.key != null, 'Key cannot be null');
    try {
      dynamic resultKey =
          await _store.record(item.key).add(_databaseClient, item);
      return resultKey != null;
    } on Error catch (_, trace) {
      print(trace);
      return false;
    }
  }

  @override
  Future<bool> update(Value item) async {
    try {
      await _store.record(item.key).update(_databaseClient, item);
      return true;
    } on Error catch (_, trace) {
      print(trace);
      return false;
    }
  }

  @override
  Future<bool> delete(Key key) async {
    var deletedCount = await _store.delete(_databaseClient,
        finder: Finder(filter: Filter.byKey(key)));
    assert(deletedCount <= 1);
    return deletedCount == 1;
  }

  @override
  Future<bool> deleteWithValue(Value value) async {
    dynamic key = await _store.findKey(_databaseClient,
        finder:
            Finder(filter: Filter.custom((record) => record.value == value)));
    if (key != null) {
      return await delete(key as Key);
    } else {
      return false;
    }
  }

  @override
  Future<Result> transaction<Result>(
      Result Function(DataSource<Key, Value> storage) transactionFunc) async {
    var database = _databaseClient;
    if (database is Database) {
      return await database.transaction((transaction) {
        var transactionDataSource =
            SembastDataSource<Key, Value>(_connectionString, _mappingFunction);
        transactionDataSource._openWithClient(transaction);
        return transactionFunc(transactionDataSource);
      });
    } else {
      throw StateError('Transaction can only be created from database.');
    }
  }

  @override
  Future upsert(Value value) async {
    await _store.record(value).put(_databaseClient, value);
  }
}
