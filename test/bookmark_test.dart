import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/database/data_store.dart';
import 'package:MarkMyProgress/data/bookmark/instance/generic_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/instance/generic_progress.dart';
import 'package:MarkMyProgress/di_setup.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'di_setup.dart';
import 'storage_test.dart';

void main() {
  setupProductionDependencyInjection();
  setupMockDependencyInjection();

  final gi = GetIt.instance;

  final testBookmark = GenericBookmark();
  testBookmark.ongoing = true;
  testBookmark.logProgress(15);
  testBookmark.localizedTitle = 'localized title';
  testBookmark.originalTitle = 'original title';
  testBookmark.webAddress = 'web address';

  var json = testBookmark.toJson();
  test('Serialization test', () async {
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

  group('Bookmark function test', () {
    var testBookmarkCopy = GenericBookmark();

    test('Title test', () {
      expect(testBookmarkCopy.title, '');

      testBookmarkCopy.localizedTitle = testBookmark.localizedTitle;

      expect(testBookmarkCopy.title, testBookmark.localizedTitle);

      testBookmarkCopy.originalTitle = testBookmark.originalTitle;
      testBookmarkCopy.localizedTitle = null;

      expect(testBookmarkCopy.title, testBookmark.originalTitle);

      testBookmarkCopy.originalTitle = null;

      expect(testBookmarkCopy.title, '');
    });

    test('Log progress test', () {
      const progress = 123.456;
      expect(testBookmarkCopy.progress, 0.0);
      testBookmarkCopy.logProgress(progress);
      expect(testBookmarkCopy.progress, progress);
    });

    test('Log progress update max progress test', () {
      const progress = 234.567;

      final resetProgress = () {
        testBookmarkCopy.progress = 0.0;
        testBookmarkCopy.maxProgress = 0.0;
        expect(testBookmarkCopy.progress, 0.0);
        expect(testBookmarkCopy.maxProgress, 0.0);
      };

      resetProgress();
      testBookmarkCopy.ongoing = false;
      expect(testBookmarkCopy.ongoing, false);

      testBookmarkCopy.logProgress(progress);
      expect(testBookmarkCopy.progress, progress);
      expect(testBookmarkCopy.maxProgress, 0.0);

      resetProgress();
      testBookmarkCopy.ongoing = true;
      expect(testBookmarkCopy.ongoing, true);

      testBookmarkCopy.logProgress(progress);
      expect(testBookmarkCopy.progress, progress);
      expect(testBookmarkCopy.maxProgress, progress);

      testBookmarkCopy.logProgress(progress - 1.0);
      expect(testBookmarkCopy.progress, progress - 1.0);
      expect(testBookmarkCopy.maxProgress, progress);
    });

    test('Increment progress test', () {
      final expectedProgress =
          testBookmarkCopy.progress + testBookmarkCopy.progressIncrement;

      testBookmarkCopy.incrementProgress();
      expect(testBookmarkCopy.progress, expectedProgress);
    });

    test('History behaviour test', () {
      final tmpBookmark = GenericBookmark();
      final today = Date.today;
      tmpBookmark.logProgress(10.0);
      tmpBookmark.logProgress(20.0);
      expect(tmpBookmark.history, [GenericProgress(today, 20.0)]);
    });
  });

  storageTests<int, PersistentBookmark>(
    'Mock DataStore tests',
    gi.get<DataStore>(instanceName: mockDataStoreName),
    GenericBookmark.fromJson(json),
    (data) {
      data.incrementProgress();
      return data;
    },
    -1,
  );

  storageTests<int, PersistentBookmark>(
    'Production DataStore tests',
    gi.get<DataStore>(),
    GenericBookmark.fromJson(json),
    (data) {
      data.incrementProgress();
      return data;
    },
    -1,
  );
}
