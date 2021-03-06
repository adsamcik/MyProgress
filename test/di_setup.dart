import 'package:myprogress/data/bookmark/database/data_store.dart';
import 'package:myprogress/data/preference/database/preference_store.dart';
import 'package:get_it/get_it.dart';

import 'mock/mock_data_source.dart';

const String mockSettingsStoreName = 'MockSettingsStore';
const String mockDataStoreName = 'MockDataStore';

Future setupMockDependencyInjection() async {
  final gi = GetIt.instance;

  gi.registerSingleton(DataStore(MockIntDataSource()), instanceName: mockDataStoreName);
  gi.registerSingleton(PreferenceStore(MockStringDataSource()), instanceName: mockSettingsStoreName);
}
