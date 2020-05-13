// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:MarkMyProgress/data/storage/abstraction/storage_subscribable.dart';
import 'package:MarkMyProgress/di_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'di_setup.dart';
import 'mock/mock_data_source.dart';
import 'mock/mock_storable.dart';
import 'mock/mock_storage.dart';

MockStorable get _nullKeyStorable => MockStorable(key: null, value: 'X');

void main() {
  setupProductionDependencyInjection();
  setupMockDependencyInjection();

  final gi = GetIt.instance;

  var storage = MockStorage<String, MockStorable>(MockStringDataSource());

  group('Storage CRUD test', () {
    test('Auto insert test', () async {
      var storable = _nullKeyStorable;
      await storage.open();
      var key = await storage.insertAuto(storable);
      expect(key, isNotNull);

      expect(await storage.get(key), storable);
      await storage.close();
    });
  });

  group('Storage event test', () {
    final void Function(StorageEvent, Iterable<MockStorable>) changeListener =
        (event, value) {};

    // Tests whether function comparison works, nothing else.
    test('Subscribe and unsubscribe test', () async {
      await storage.open();

      storage.subscribeToDataChanges(changeListener);
      expect(storage.subscriptionCount, 1);

      storage.unsubscribeFromDataChanges(changeListener);
      expect(storage.subscriptionCount, 0);
      await storage.close();
    });
  });
}
