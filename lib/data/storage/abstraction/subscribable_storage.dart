import 'package:markmyprogress/data/storage/abstraction/data_source.dart';
import 'package:markmyprogress/data/storage/abstraction/storable.dart';
import 'package:markmyprogress/data/storage/abstraction/storage.dart';
import 'package:markmyprogress/data/storage/abstraction/storage_subscribable.dart';
import 'package:meta/meta.dart';

abstract class SubscribableStorage<Key, Value extends Storable<Key>> extends Storage<Key, Value>
    implements SubscriptionStorage<Value> {
  SubscribableStorage(DataSource<Key, Value> dataSource) : super(dataSource);

  @protected
  final List<void Function(StorageEvent event, Iterable<Value> value)> subscriptions = [];

  @protected
  void onDataChanged(StorageEvent event, Iterable<Value> values) {
    subscriptions.forEach((element) => element(event, values));
  }

  @override
  void subscribeToDataChanges(void Function(StorageEvent event, Iterable<Value> value) callback) {
    subscriptions.add(callback);
  }

  @override
  void unsubscribeFromDataChanges(void Function(StorageEvent event, Iterable<Value> value) callback) {
    subscriptions.remove(callback);
  }

  @override
  Future<bool> insert(Value item) async {
    var result = await super.insert(item);
    if (result) {
      onDataChanged(StorageEvent.inserted, [item]);
    }
    return result;
  }

  @override
  Future<Key> insertAuto(Value item) async {
    var result = await super.insertAuto(item);
    if (result != null) {
      onDataChanged(StorageEvent.inserted, [item]);
    }
    return result;
  }

  @override
  Future<bool> delete(Key key) async {
    var item = await super.get(key);
    if (item != null) {
      var result = await super.delete(key);
      if (result) {
        onDataChanged(StorageEvent.removed, [item]);
      }

      return result;
    } else {
      return false;
    }
  }

  @override
  Future<StorageEvent> upsert(Value item) async {
    var result = await super.upsert(item);
    onDataChanged(result, [item]);
    return result;
  }

  @override
  Future<bool> update(Value item) async {
    var result = await super.update(item);
    if (result) {
      onDataChanged(StorageEvent.updated, [item]);
    }
    return result;
  }
}
