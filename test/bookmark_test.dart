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

  group('Bookmark function test', () {
    var bookmark = GenericBookmark();

    test('Title test', () {
      expect(bookmark.title, '');

      bookmark.localizedTitle = testBookmark.localizedTitle;

      expect(bookmark.title, testBookmark.localizedTitle);

      bookmark.originalTitle = testBookmark.originalTitle;
      bookmark.localizedTitle = null;

      expect(bookmark.title, testBookmark.originalTitle);

      bookmark.originalTitle = null;

      expect(bookmark.title, '');
    });

    test('Log progress test', () {
      const progress = 123.456;
      expect(bookmark.progress, 0.0);
      bookmark.logProgress(progress);
      expect(bookmark.progress, progress);
    });

    test('Log progress update max progress test', () {
      const progress = 234.567;

      final resetProgress = () {
        bookmark.progress = 0.0;
        bookmark.maxProgress = 0.0;
        expect(bookmark.progress, 0.0);
        expect(bookmark.maxProgress, 0.0);
      };

      resetProgress();
      bookmark.ongoing = false;
      expect(bookmark.ongoing, false);

      bookmark.logProgress(progress);
      expect(bookmark.progress, progress);
      expect(bookmark.maxProgress, 0.0);

      resetProgress();
      bookmark.ongoing = true;
      expect(bookmark.ongoing, true);

      bookmark.logProgress(progress);
      expect(bookmark.progress, progress);
      expect(bookmark.maxProgress, progress);

      bookmark.logProgress(progress - 1.0);
      expect(bookmark.progress, progress - 1.0);
      expect(bookmark.maxProgress, progress);
    });

    test('Increment progress test', () {
      final expectedProgress = bookmark.progress + bookmark.progressIncrement;

      bookmark.incrementProgress();
      expect(bookmark.progress, expectedProgress);
    });

    test('History behaviour test', () {
      final tmpBookmark = GenericBookmark();
      final today = Date.today;
      tmpBookmark.logProgress(10.0);
      tmpBookmark.logProgress(20.0);
      expect(tmpBookmark.history, [GenericProgress(today, 20.0)]);
    });
  });

  var json = testBookmark.toJson();

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
