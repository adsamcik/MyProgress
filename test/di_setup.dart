import 'package:markmyprogress/data/bookmark/database/data_store.dart';
import 'package:markmyprogress/data/preference/database/preference_store.dart';
import 'package:get_it/get_it.dart';

import 'mock/mock_data_source.dart';

const String mockSettingsStoreName = 'MockSettingsStore';
const String mockDataStoreName = 'MockDataStore';

Future setupMockDependencyInjection() async {
  final gi = GetIt.instance;

  gi.registerSingleton(DataStore(MockIntDataSource()), instanceName: mockDataStoreName);
  gi.registerSingleton(PreferenceStore(MockStringDataSource()), instanceName: mockSettingsStoreName);
}
