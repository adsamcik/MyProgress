// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:MarkMyProgress/data/bookmark/database/DataStore.dart';
import 'package:MarkMyProgress/data/bookmark/instance/GenericBookmark.dart';
import 'package:MarkMyProgress/data/database/data/abstract/DatabaseCollection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast.dart' as sembast;

void main() {
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
    final dataStore = DataStore();
    test('Save data to store', () async {
      await dataStore.open();
      await dataStore.insert(testBookmark);
      await dataStore.close();
    });

    test('Read data from store', () async {
      await dataStore.open();
      var bookmark = await dataStore.get(testBookmark.id);
      await dataStore.close();

      expect(bookmark.toJson(), testBookmark.toJson());
    });

    test('Update data in store', () async {
      testBookmark.logProgress(20);

      await dataStore.open();
      await dataStore.update(testBookmark);
      await dataStore.close();

      await dataStore.open();
      var bookmark = await dataStore.get(testBookmark.id);
      await dataStore.close();

      expect(bookmark.toJson(), testBookmark.toJson());
    });

    test('Delete data from store', () async {
      await dataStore.open();
      await dataStore.delete(testBookmark);
      await dataStore.close();

      await dataStore.open();

      var list = await dataStore.getAll(
          finder:
              sembast.Finder(filter: sembast.Filter.byKey(testBookmark.id)));
      await dataStore.close();

      expect(list.isEmpty, true);
      await File(DatabaseCollection.databaseFileName).delete();
    });
  });
}
