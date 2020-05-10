import 'package:MarkMyProgress/data/bookmark/bloc/BookmarkBloc.dart';
import 'package:get_it/get_it.dart';

import 'data/bookmark/database/DataStore.dart';
import 'data/preference/database/SettingsStore.dart';

Future setupDependencyInjection() async {
  // ignore: omit_local_variable_types
  final GetIt gi = GetIt.instance;

  gi.registerLazySingleton<BookmarkBloc>(() =>
      BookmarkBloc(dataStore: DataStore(), settingsStore: SettingsStore()));
}
