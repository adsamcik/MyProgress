import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/database/data_store.dart';
import 'package:MarkMyProgress/data/bookmark/instance/generic_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/instance/generic_progress.dart';
import 'package:MarkMyProgress/di_setup.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:rational/rational.dart';

import 'di_setup.dart';
import 'storage_test.dart';

Future<void> main() async {
  await setupProductionDependencyInjection(inPlace: true);
  await setupMockDependencyInjection();

  final gi = GetIt.instance;

  final testBookmark = GenericBookmark();
  testBookmark.ongoing = true;
  testBookmark.logProgress(Rational.fromInt(15));
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
      final progress = Rational.parse('123.456');
      expect(bookmark.progress, Rational.zero);
      bookmark.logProgress(progress);
      expect(bookmark.progress, progress);
    });

    test('Log progress update max progress test', () {
      final progress = Rational.parse('234.567');

      final resetProgress = () {
        bookmark.progress = Rational.zero;
        bookmark.maxProgress = Rational.zero;
        expect(bookmark.progress, Rational.zero);
        expect(bookmark.maxProgress, Rational.zero);
      };

      resetProgress();
      bookmark.ongoing = false;
      expect(bookmark.ongoing, false);

      bookmark.logProgress(progress);
      expect(bookmark.progress, progress);
      expect(bookmark.maxProgress, Rational.zero);

      resetProgress();
      bookmark.ongoing = true;
      expect(bookmark.ongoing, true);

      bookmark.logProgress(progress);
      expect(bookmark.progress, progress);
      expect(bookmark.maxProgress, progress);

      bookmark.logProgress(progress - Rational.one);
      expect(bookmark.progress, progress - Rational.one);
      expect(bookmark.maxProgress, progress);
    });

    test('Increment progress test', () {
      final expectedProgress = bookmark.progress + bookmark.progressIncrement;

      bookmark.incrementProgress();
      expect(bookmark.progress, expectedProgress);
    });

    test('Repeated increment progress test', () {
      bookmark.progress = Rational.zero;
      bookmark.progressIncrement = Rational.parse('0.001');

      for (var i = 0; i < 1000; i++) {
        bookmark.incrementProgress();
      }
      expect(bookmark.progress, Rational.one);
    });

    test('History behaviour test', () {
      final tmpBookmark = GenericBookmark();
      final today = Date.today;
      tmpBookmark.logProgress(Rational.parse('10.0'));
      tmpBookmark.logProgress(Rational.parse('20.0'));
      expect(tmpBookmark.history, [GenericProgress(today, Rational.parse('20.0'))]);
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
