import 'package:MarkMyProgress/data/bookmark/database/DataStore.dart';
import 'package:MarkMyProgress/data/preference/database/SettingsStore.dart';
import 'package:get_it/get_it.dart';

import 'mock/mock_data_source.dart';

Future setupMockDependencyInjection() async {
  // ignore: omit_local_variable_types
  final GetIt gi = GetIt.instance;

  gi.registerSingleton(DataStore(MockIntDataSource()),
      instanceName: 'MockDataStore');
  gi.registerSingleton(SettingsStore(MockStringDataSource()),
      instanceName: 'MockSettingsStore');
}
