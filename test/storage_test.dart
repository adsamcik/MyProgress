// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock/mock_data_source.dart';
import 'mock/mock_storable.dart';
import 'mock/mock_storage.dart';

MockStorable get _nullKeyStorable => MockStorable(key: null, value: 'X');

Future<void> main() async {
  var storage = MockStorage<String, MockStorable>(MockStringDataSource());

  await storage.open();

  group('Storage CRUD test', () {
    test('Auto insert test', () async {
      var storable = _nullKeyStorable;
      var key = await storage.insertAuto(storable);
      expect(key, isNotNull);

      expect(await storage.get(key), storable);
    });
  });

  group('Storage event test', () {
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
      storage.subscribeToDataChanges(changeListener);
      expect(storage.subscriptionCount, 1);
    });

    test('Test insertAuto event', () async {
      var nullStorable = _nullKeyStorable;
      await storage.insertAuto(nullStorable);
      expect(lastEvent, StorageEvent.inserted);
      expect(storables, [nullStorable]);
    });

    test('Test insertAuto event', () async {
      await storage.insert(storable1);
      expect(lastEvent, StorageEvent.inserted);
      expect(storables, [storable1]);
    });

    test('Test upsert event', () async {
      await storage.upsert(storable2);
      expect(lastEvent, StorageEvent.inserted);
      expect(storables, [storable2]);

      await storage.upsert(storable2);
      expect(lastEvent, StorageEvent.updated);
      expect(storables, [storable2]);
    });

    test('Test update event', () async {
      expect(await storage.update(storable2), isTrue);
      expect(lastEvent, StorageEvent.updated);
      expect(storables, [storable2]);
    });

    test('Test remove event', () async {
      expect(await storage.delete(storable1.key), isTrue);
      expect(lastEvent, StorageEvent.removed);
      expect(storables, [storable1]);
    });

    test('Subscribe and unsubscribe test', () async {
      storage.unsubscribeFromDataChanges(changeListener);
      expect(storage.subscriptionCount, 0);
    });
  });
}
