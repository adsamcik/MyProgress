import 'package:MarkMyProgress/data/bookmark/instance/generic_bookmark.dart';
import 'package:MarkMyProgress/data/preference/database/preference.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rational/rational.dart';

void _genericBookmarkSerializationTest() {
  final testBookmark = GenericBookmark();
  testBookmark.logProgress(Rational.parse('17.357896'));
  testBookmark.ongoing = true;
  testBookmark.localizedTitle = 'localized title';
  testBookmark.originalTitle = 'original title';
  testBookmark.webAddress = 'web address';

  final testBookmarkJson = {
    'localizedTitle': 'localized title',
    'originalTitle': 'original title',
    'maxProgress': '0',
    'ongoing': true,
    'abandoned': false,
    'webAddress': 'web address',
    'history': [
      {
        'date': testBookmark.history.first.date.toIso8601String(),
        'value': '17.357896'
      }
    ],
    'progressIncrement': '1'
  };

  test('Generic bookmark serialization test', () async {
    expect(testBookmark.toJson(), testBookmarkJson);
  });

  test('Generic bookmark deserialization test', () async {
    expect(testBookmark, GenericBookmark.fromJson(testBookmarkJson));
  });

  test('Rational serialization migration test', () async {
    final oldBookmark = {
      'localizedTitle': 'localized title',
      'originalTitle': 'original title',
      'maxProgress': 0.0,
      'ongoing': true,
      'abandoned': false,
      'webAddress': 'web address',
      'history': [
        {
          'date': testBookmark.history.first.date.toIso8601String(),
          'value': 17.357896
        }
      ],
      'progressIncrement': 1.0
    };

    expect(GenericBookmark.fromJson(oldBookmark), testBookmark);
  });
}

void _preferenceSerializationTest() {
  final stringPreference = Preference('string', 'value');
  final boolPreference = Preference('bool', true);
  final intPreference = Preference('int', 7);

  const stringJson = {'key': 'string', 'value': 'value'};
  const boolJson = {'key': 'bool', 'value': true};
  const intJson = {'key': 'int', 'value': 7};

  test('Preference serialization test', () async {
    expect(stringPreference.toJson(), stringJson);
    expect(boolPreference.toJson(), boolJson);
    expect(intPreference.toJson(), intJson);
  });

  test('Preference deserialization test', () async {
    expect(Preference.fromJson(stringJson), stringPreference);
    expect(Preference.fromJson(boolJson), boolPreference);
    expect(Preference.fromJson(intJson), intPreference);
  });
}

void main() {
  _genericBookmarkSerializationTest();
  _preferenceSerializationTest();
}
