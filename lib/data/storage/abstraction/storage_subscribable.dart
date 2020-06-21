import 'package:myprogress/data/storage/abstraction/storable.dart';

abstract class SubscriptionStorage<Value extends Storable<dynamic>> {
  // todo replace function with typedef once implemented in dart

  /// Subscribe to changes in storage
  void subscribeToDataChanges(Function(StorageEvent event, Iterable<Value> value) callback);

  /// Unsubscribe from changes in storage
  void unsubscribeFromDataChanges(Function(StorageEvent event, Iterable<Value> value) callback);
}

enum StorageEvent {
  inserted,
  updated,
  removed,
}
