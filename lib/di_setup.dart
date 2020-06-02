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

Future setupProductionDependencyInjection({bool inPlace = false}) async {
  final gi = GetIt.instance;
  var progressDataPath = 'progress_data.db';
  var settingsDataPath = 'settings.db';

  if (!inPlace) {
    WidgetsFlutterBinding.ensureInitialized();
    var path = await getDirPath();
    progressDataPath = join(path, progressDataPath);
    settingsDataPath = join(path, settingsDataPath);
  }

  gi.registerSingleton(DataStore(SembastDataSource(progressDataPath, BookmarkMapper())));
  gi.registerSingleton(PreferenceStore(SembastDataSource(settingsDataPath, PreferenceMapper())));

  gi.registerLazySingleton<BookmarkBloc>(() => BookmarkBloc(dataStore: gi.get(), settingsStore: gi.get()));

  // BlocSupervisor.delegate = BlocDebugDelegate();

  gi.registerLazySingleton<PreferenceBloc>(() => PreferenceBloc(gi.get()));
}
