import 'package:MarkMyProgress/data/bookmark/bloc/BookmarkBloc.dart';
import 'package:MarkMyProgress/data/preference/bloc/bloc.dart';
import 'package:MarkMyProgress/data/storage/implementation/sembast_data_source.dart';
import 'package:get_it/get_it.dart';

import 'data/bookmark/database/DataStore.dart';
import 'data/bookmark/instance/GenericBookmark.dart';
import 'data/preference/database/SettingsStore.dart';
import 'data/preference/database/preference.dart';

Future setupDependencyInjection() async {
  // ignore: omit_local_variable_types
  final GetIt gi = GetIt.instance;

  gi.registerSingleton(DataStore(SembastDataSource(
      'progress_data.db', (value) => GenericBookmark.fromJson(value))));
  gi.registerSingleton(SettingsStore(
      SembastDataSource('settings.db', (value) => Preference.fromJson(value))));

  gi.registerLazySingleton<BookmarkBloc>(
      () => BookmarkBloc(dataStore: gi.get(), settingsStore: gi.get()));

  gi.registerLazySingleton<PreferenceBloc>(() => PreferenceBloc(gi.get()));
}
