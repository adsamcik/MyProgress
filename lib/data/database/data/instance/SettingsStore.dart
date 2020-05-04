import 'package:MarkMyProgress/data/database/data/abstract/DatabaseProxy.dart';
import 'package:MarkMyProgress/data/runtime/FilterData.dart';

class SettingsStore extends DatabaseProxy<String, dynamic> {
  SettingsStore() : super(databasePath: 'settings.db');

  Future<Map<String, dynamic>> getFilterMap() async {
    var filterDataMap = FilterData().toJson();

    var data = await getAllWithKeys(filterDataMap.keys);

    data.forEach((element) {
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
}
