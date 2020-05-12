import 'dart:math';

import 'package:MarkMyProgress/data/bookmark/filter/filter_data.dart';
import 'package:MarkMyProgress/data/preference/database/preference.dart';
import 'package:MarkMyProgress/data/preference/database/settings_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'di_setup.dart';

void main() {
  setupMockDependencyInjection();

  final gi = GetIt.instance;

  final stringPreference = Preference('string', 'value');
  final boolPreference = Preference('bool', true);
  final intPreference = Preference('int', 7);

  var stringJson = stringPreference.toJson();
  var boolJson = boolPreference.toJson();
  var intJson = intPreference.toJson();

  test('Serialization test', () async {
    expect(stringJson, {'key': 'string', 'value': 'value'});
    expect(boolJson, {'key': 'bool', 'value': true});
    expect(intJson, {'key': 'int', 'value': 7});
  });

  test('Deserialization test', () async {
    expect(Preference.fromJson(stringJson), stringPreference);
    expect(Preference.fromJson(boolJson), boolPreference);
    expect(Preference.fromJson(intJson), intPreference);
  });

  group('Test settings store', () {
    final settingsStore =
        gi.get<SettingsStore>(instanceName: mockSettingsStoreName);
    test('Set preferences', () async {
      await settingsStore.open();
      expect(await settingsStore.insert(stringPreference), isTrue);
      expect(await settingsStore.insert(boolPreference), isTrue);
      expect(await settingsStore.insert(intPreference), isTrue);
      await settingsStore.close();
    });

    test('Get preferences', () async {
      await settingsStore.open();
      expect(await settingsStore.get(stringPreference.key), stringPreference);
      expect(await settingsStore.get(boolPreference.key), boolPreference);
      expect(await settingsStore.get(intPreference.key), intPreference);
      await settingsStore.close();
    });

    test('Update preferences', () async {
      var newPreference = Preference(stringPreference.key, 'totallyNewValue');
      await settingsStore.open();
      expect(await settingsStore.update(newPreference), isTrue);

      expect(await settingsStore.get(stringPreference.key), newPreference);
      await settingsStore.close();
    });

    test('Test default filter data', () async {
      await settingsStore.open();
      expect(await settingsStore.getFilterData(), FilterData());
      expect(await settingsStore.getFilterMap(), FilterData().toJson());
      await settingsStore.close();
    });

    test('Test updated filter data', () async {
      var map = FilterData().toJson();
      var random = Random();
      var newMap = map.map<String, dynamic>((key, dynamic _) =>
          MapEntry<String, dynamic>(key, random.nextBool()));

      await settingsStore.open();

      newMap.entries.forEach((prefMap) =>
          settingsStore.upsert(Preference(prefMap.key, prefMap.value)));

      // After settings preloading change to this.
      /*var updateResult = newMap.entries.map((prefMap) =>
          settingsStore.upsert(Preference(prefMap.key, prefMap.value)));

      await Future.wait(updateResult).then(
          (list) => expect(list.every((resultValue) => resultValue), true));*/

      expect(await settingsStore.getFilterData(), FilterData.fromJson(newMap));
      await settingsStore.close();
    });

    test('Invalid operations', () {
      expect(
          settingsStore.insertAuto(stringPreference), throwsUnsupportedError);
    });
  });
}
