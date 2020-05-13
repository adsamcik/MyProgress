import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_mapper.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDataSource<Key, Value extends Storable<Key>>
    extends DataSource<Key, Value> {
  final String _connectionString;
  final StorageMapper<Value, Map<String, dynamic>> _mapper;

  @override
  bool get isOpen => _databaseClient != null;

  DatabaseClient _databaseClient;

  StoreRef get _store => StoreRef<Key, Map<String, dynamic>>.main();

  SembastDataSource(this._connectionString, this._mapper);

  @override
  Future close() async {
    var database = _databaseClient;
    if (database is Database) {
      await database.close();
    } else {
      throw StateError('Close can only be called for database');
    }
    _databaseClient = null;
  }

  Value _mapDatabaseToInstance(dynamic value) =>
      _mapper.fromDatabase(value as Map<String, dynamic>);

  Map<String, dynamic> _mapInstanceToDatabase(Value value) =>
      _mapper.toDatabase(value);

  @override
  Stream<Value> getAll() {
    return _store.stream(_databaseClient).map((event) {
      var value = _mapDatabaseToInstance(event.value);
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
          (list) =>
          list.map(
                (dynamic element) =>
            element != null ? _mapDatabaseToInstance(element) : null,
          ),
    )
        .expand((element) => element.cast());
  }

  @override
  Future<Value> getWithKey(Key key) async {
    dynamic databaseValue = await _store.record(key).get(_databaseClient);
    if (databaseValue == null) {
      return null;
    } else {
      var value = _mapDatabaseToInstance(databaseValue);
      value.key = key;
      return value;
    }
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
  Future<Key> insertAuto(Value value) async {
    var key =
    await _store.add(_databaseClient, _mapInstanceToDatabase(value)) as Key;
    value.key = key;
    return key;
  }

  @override
  Future<bool> insert(Value value) async {
    assert(value.key != null, 'Key cannot be null');
    try {
      dynamic resultKey = await _store
          .record(value.key)
          .add(_databaseClient, _mapInstanceToDatabase(value));
      return resultKey != null;
    } on Error catch (_, trace) {
      print(trace);
      return false;
    }
  }

  @override
  Future<bool> update(Value value) async {
    try {
      await _store
          .record(value.key)
          .update(_databaseClient, _mapInstanceToDatabase(value));
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
    var databaseValue = _mapInstanceToDatabase(value);
    dynamic key = await _store.findKey(_databaseClient,
        finder: Finder(
            filter: Filter.custom((record) => record.value == databaseValue)));
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
        SembastDataSource<Key, Value>(_connectionString, _mapper);
        transactionDataSource._openWithClient(transaction);
        return transactionFunc(transactionDataSource);
      });
    } else {
      throw StateError('Transaction can only be created from database.');
    }
  }

  @override
  Future<StorageEvent> upsert(Value value) async {
    var record = _store.record(value.key);

    var exists = await record.exists(_databaseClient)
    await
    record.put(_databaseClient, _mapInstanceToDatabase(value), merge: true);
    return exists ? StorageEvent.updated : StorageEvent.inserted;
  }
}
