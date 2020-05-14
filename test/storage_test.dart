// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock/mock_data_source.dart';
import 'mock/mock_storable.dart';
import 'mock/mock_storage.dart';

MockStorable get _nullKeyStorable => MockStorable(key: null, value: 'X');

void storageTests<Key, Value extends Storable<Key>>(
  String title,
  Storage<Key, Value> storage,
  Value testData,
  Value Function(Value data) updateFunc,
  Key invalidKey,
) {
  group(title, () {
    test('Save data to store', () async {
      await storage.open();
      var key = await storage.insertAuto(testData);
      await storage.close();

      expect(key != null, true);
    });

    test('Try insert existing data to store', () async {
      await storage.open();
      var success = await storage.insert(testData);
      await storage.close();

      expect(success, false);
    });

    test('Read data from store', () async {
      await storage.open();
      var bookmark = await storage.get(testData.key);
      await storage.close();

      expect(bookmark.toJson(), testData.toJson());
    });

    test('Read non-existent data from store', () async {
      await storage.open();
      var invalid = await storage.get(invalidKey);
      await storage.close();

      expect(invalid, null);
    });

    test('Update data in store', () async {
      updateFunc(testData);

      await storage.open();
      await storage.update(testData);
      await storage.close();

      await storage.open();
      var bookmark = await storage.get(testData.key);
      await storage.close();

      expect(bookmark.toJson(), testData.toJson());
    });

    test('Delete data from store', () async {
      await storage.open();
      await storage.delete(testData.key);
      await storage.close();

      await storage.open();

      var item = await storage.get(testData.key);
      await storage.close();

      expect(item, isNull);
    });

    test('Test transaction', () async {
      await storage.open();
      var inserted = await await storage.transaction((s) => s.insert(testData));

      expect(inserted, isTrue);

      var deleted = await storage.delete(testData.key);
      expect(deleted, isTrue);

      var item = await storage.get(testData.key);
      await storage.close();

      expect(item, isNull);
    });

    // todo delete database file if needed
  });
}

Future<void> runCrudTests() async {
  // Mock storage tests
  var mockStorage = MockStorage<String, MockStorable>(MockStringDataSource());

  storageTests<String, MockStorable>(
      'Storage CRUD test', mockStorage, _nullKeyStorable, (data) {
    data.value = 'updated value';
    return data;
  }, 'null');
}

Future<void> main() async {
  await runCrudTests();

  group('Storage event test', () {
    var mockStorage = MockStorage<String, MockStorable>(MockStringDataSource());
    StorageEvent lastEvent;
    Iterable<MockStorable> storables;
    final void Function(StorageEvent, Iterable<MockStorable>) changeListener =
        (event, value) {
      lastEvent = event;
      storables = value;
    };

    final storable1 = _nullKeyStorable;
    storable1.key = 'TestKey1';

    final storable2 = _nullKeyStorable;
    storable2.key = 'TestKey2';

    test('Subscribe and unsubscribe test', () async {
      await mockStorage.open();
      mockStorage.subscribeToDataChanges(changeListener);
      expect(mockStorage.subscriptionCount, 1);
    });

    test('Test insertAuto event', () async {
      var nullStorable = _nullKeyStorable;
      await mockStorage.insertAuto(nullStorable);
      expect(lastEvent, StorageEvent.inserted);
      expect(storables, [nullStorable]);
    });

    test('Test insertAuto event', () async {
      await mockStorage.insert(storable1);
      expect(lastEvent, StorageEvent.inserted);
      expect(storables, [storable1]);
    });

    test('Test upsert event', () async {
      await mockStorage.upsert(storable2);
      expect(lastEvent, StorageEvent.inserted);
      expect(storables, [storable2]);

      await mockStorage.upsert(storable2);
      expect(lastEvent, StorageEvent.updated);
      expect(storables, [storable2]);
    });

    test('Test update event', () async {
      expect(await mockStorage.update(storable2), isTrue);
      expect(lastEvent, StorageEvent.updated);
      expect(storables, [storable2]);
    });

    test('Test remove event', () async {
      expect(await mockStorage.delete(storable1.key), isTrue);
      expect(lastEvent, StorageEvent.removed);
      expect(storables, [storable1]);
    });

    test('Subscribe and unsubscribe test', () async {
      mockStorage.unsubscribeFromDataChanges(changeListener);
      expect(mockStorage.subscriptionCount, 0);
      await mockStorage.close();
    });
  });
}
