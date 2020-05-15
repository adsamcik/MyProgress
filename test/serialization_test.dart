import 'package:MarkMyProgress/data/bookmark/instance/generic_bookmark.dart';
import 'package:flutter_test/flutter_test.dart';

void _genericBookmarkSerializationTest() {
  final testBookmark = GenericBookmark();
  testBookmark.logProgress(15);
  testBookmark.ongoing = true;
  testBookmark.localizedTitle = 'localized title';
  testBookmark.originalTitle = 'original title';
  testBookmark.webAddress = 'web address';

  final testBookmarkJson = {
    'localizedTitle': 'localized title',
    'originalTitle': 'original title',
    'maxProgress': 0.0,
    'ongoing': true,
    'abandoned': false,
    'webAddress': 'web address',
    'history': [
      {'date': testBookmark.history.first.date.toIso8601String(), 'value': 15.0}
    ],
    'progressIncrement': 1.0
  };

  test('Generic bookmark serialization test', () async {
    expect(testBookmark.toJson(), testBookmarkJson);
  });

  test('Generic bookmark deserialization test', () async {
    expect(testBookmark, GenericBookmark.fromJson(testBookmarkJson));
  });
}

void main() {
  _genericBookmarkSerializationTest();
}
