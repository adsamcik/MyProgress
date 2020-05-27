import 'package:MarkMyProgress/data/bookmark/bloc/bloc.dart';
import 'package:MarkMyProgress/data/preference/bloc/bloc.dart';
import 'package:MarkMyProgress/pages/list_bookmark.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'di_setup.dart';
import 'generated/locale_keys.g.dart';

void main() {
  setupProductionDependencyInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                getIt.get<BookmarkBloc>()..add(BookmarkBlocEvent.load()),
          ),
          BlocProvider(
            create: (_) =>
                getIt.get<PreferenceBloc>()..add(PreferenceBlocEvent.load()),
          ),
        ],
        child: EasyLocalization(
            path: 'assets/localization',
            supportedLocales: [Locale('en')],
            child: MaterialApp(
              title: 'MarkMyProgress ',
              theme: ThemeData(
                brightness: Brightness.dark,
                accentColor: Colors.red,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.red,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: BookmarkList(title: LocaleKeys.list),
            )));
  }
}
