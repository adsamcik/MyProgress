import 'dart:async';

import 'package:MarkMyProgress/data/bookmark/filter/filter_data.dart';
import 'package:MarkMyProgress/data/preference/database/preference.dart';
import 'package:MarkMyProgress/data/storage/abstraction/data_source.dart';
import 'package:MarkMyProgress/data/storage/abstraction/subscribable_storage.dart';

class PreferenceStore extends SubscribableStorage<String, Preference> {
  PreferenceStore(DataSource<String, Preference> dataSource)
      : super(dataSource);

  Future<Map<String, dynamic>> getFilterMap() async {
    var filterDataMap = FilterData().toJson();

    var data = await getAllWithKeys(filterDataMap.keys);

    await data.forEach((element) {
      if (element != null) {
        filterDataMap[element.key] = element.value;
      }
    });

    return filterDataMap;
  }

  /// Loads filter data from database
  Future<FilterData> getFilterData() async {
    var filterDataMap = await getFilterMap();
    return FilterData.fromJson(filterDataMap);
  }

  @override
  Future<T> transactionClosed<T>(
      FutureOr<T> Function(PreferenceStore settingsStore) action) async {
    await open();
    var result = await action(this);
    await close();
    return result;
  }

  @override
  Future<String> insertAuto(Preference item) async {
    throw UnsupportedError('Preference values cannot have autogenerated keys');
  }
}