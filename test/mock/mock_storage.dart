import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:MarkMyProgress/data/storage/abstraction/subscribable_storage.dart';

class MockStorage<Key, Value extends Storable<Key>>
    extends SubscribableStorage<Key, Value> {
  MockStorage(DataSource<Key, Value> dataSource) : super(dataSource);

  int get subscriptionCount => subscriptions.length;
}
