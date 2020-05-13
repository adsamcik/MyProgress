import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';

class MockStorage<Key, Value extends Storable<Key>> extends Storage<Key, Value>
    implements StorageSubscribable<Value> {
  MockStorage(DataSource<Key, Value> dataSource) : super(dataSource);

  final List<void Function(StorageEvent event, Iterable<Value> value)>
      _subscriptions = [];

  int get subscriptionCount => _subscriptions.length;

  @override
  void subscribeToDataChanges(
      void Function(StorageEvent event, Iterable<Value> value) callback) {
    _subscriptions.add(callback);
  }

  @override
  void unsubscribeFromDataChanges(
      void Function(StorageEvent event, Iterable<Value> value) callback) {
    _subscriptions.remove(callback);
  }
}
