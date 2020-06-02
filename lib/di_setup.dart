import 'package:MarkMyProgress/data/bookmark/bloc/bookmark_bloc.dart';
import 'package:MarkMyProgress/data/bookmark/database/bookmark_mapper.dart';
import 'package:MarkMyProgress/data/preference/bloc/bloc.dart';
import 'package:MarkMyProgress/data/preference/database/preference_mapper.dart';
import 'package:MarkMyProgress/data/storage/implementation/sembast_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'data/bookmark/database/data_store.dart';
import 'data/preference/database/preference_store.dart';

Future<String> getDirPath() async {
  var dir = await getApplicationDocumentsDirectory();
  await dir.create(recursive: true);
  return dir.path;
}

Future setupProductionDependencyInjection() async {
  final gi = GetIt.instance;
  WidgetsFlutterBinding.ensureInitialized();

  var path = await getDirPath();
  gi.registerSingleton(DataStore(
      SembastDataSource(join(path, 'progress_data.db'), BookmarkMapper())));
  gi.registerSingleton(PreferenceStore(
      SembastDataSource(join(path, 'settings.db'), PreferenceMapper())));

  gi.registerLazySingleton<BookmarkBloc>(
      () => BookmarkBloc(dataStore: gi.get(), settingsStore: gi.get()));

  // BlocSupervisor.delegate = BlocDebugDelegate();

  gi.registerLazySingleton<PreferenceBloc>(() => PreferenceBloc(gi.get()));
}
