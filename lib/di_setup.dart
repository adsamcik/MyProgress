import 'package:MarkMyProgress/data/bloc/BookmarkBloc.dart';
import 'package:get_it/get_it.dart';

import 'data/database/data/instance/DataStore.dart';

Future setupDependencyInjection() async {
  // ignore: omit_local_variable_types
  final GetIt gi = GetIt.instance;

  gi.registerLazySingleton<BookmarkBloc>(
      () => BookmarkBloc(dataStore: DataStore()));
}
