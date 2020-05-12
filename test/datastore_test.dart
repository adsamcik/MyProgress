// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:MarkMyProgress/data/bookmark/database/DataStore.dart';
import 'package:MarkMyProgress/data/bookmark/instance/GenericBookmark.dart';
import 'package:MarkMyProgress/di_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupProductionDependencyInjection();

  final gi = GetIt.instance;

  final dataStore = gi.get<DataStore>();
  var testBookmark = GenericBookmark();
  testBookmark.ongoing = true;
  testBookmark.logProgress(15);
  testBookmark.localizedTitle = 'localized title';
  testBookmark.originalTitle = 'original title';
  testBookmark.webAddress = 'web address';

  test('Serialization test', () async {
    var json = testBookmark.toJson();
    expect(json, {
      'localizedTitle': 'localized title',
      'originalTitle': 'original title',
      'maxProgress': 15.0,
      'ongoing': true,
      'abandoned': false,
      'webAddress': 'web address',
      'history': [
        {
          'date': testBookmark.history.first.date.toIso8601String(),
          'value': 15.0
        }
      ],
      'progressIncrement': 1.0
    });
  });

  group('DataStore tests', () {
    test('Save data to store', () async {
      await dataStore.open();
      var key = await dataStore.insertAuto(testBookmark);
      await dataStore.close();

      expect(key != null, true);
      expect(key >= 0, true);
    });

    test('Try insert existing data to store', () async {
      await dataStore.open();
      var success = await dataStore.insert(testBookmark);
      await dataStore.close();

      expect(success, false);
    });

    test('Read data from store', () async {
      await dataStore.open();
      var bookmark = await dataStore.get(testBookmark.key);
      await dataStore.close();

      expect(bookmark.toJson(), testBookmark.toJson());
    });

    test('Read non-existent data from store', () async {
      await dataStore.open();
      var invalid = await dataStore.get(-1);
      await dataStore.close();

      expect(invalid, null);
    });

    test('Update data in store', () async {
      testBookmark.logProgress(20);

      await dataStore.open();
      await dataStore.update(testBookmark);
      await dataStore.close();

      await dataStore.open();
      var bookmark = await dataStore.get(testBookmark.key);
      await dataStore.close();

      expect(bookmark.toJson(), testBookmark.toJson());
    });

    test('Delete data from store', () async {
      await dataStore.open();
      await dataStore.delete(testBookmark.key);
      await dataStore.close();

      await dataStore.open();

      var item = await dataStore.get(testBookmark.key);
      await dataStore.close();

      expect(item, null);
      // todo delete database file
    });
  });
}
