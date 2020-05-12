import 'package:MarkMyProgress/data/bookmark/bloc/bookmark_bloc.dart';
import 'package:MarkMyProgress/data/bookmark/database/bookmark_mapper.dart';
import 'package:MarkMyProgress/data/preference/bloc/bloc.dart';
import 'package:MarkMyProgress/data/preference/database/preference_mapper.dart';
import 'package:MarkMyProgress/data/storage/implementation/sembast_data_source.dart';
import 'package:get_it/get_it.dart';

import 'data/bookmark/database/data_store.dart';
import 'data/preference/database/settings_store.dart';

Future setupProductionDependencyInjection() async {
  final gi = GetIt.instance;

  gi.registerSingleton(
      DataStore(SembastDataSource('progress_data.db', BookmarkMapper())));
  gi.registerSingleton(
      SettingsStore(SembastDataSource('settings.db', PreferenceMapper())));

  gi.registerLazySingleton<BookmarkBloc>(
      () => BookmarkBloc(dataStore: gi.get(), settingsStore: gi.get()));

  gi.registerLazySingleton<PreferenceBloc>(() => PreferenceBloc(gi.get()));
}
