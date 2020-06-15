import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:markmyprogress/data/bookmark/bloc/bloc.dart';
import 'package:markmyprogress/data/preference/bloc/bloc.dart';
import 'package:markmyprogress/misc/platform.dart';
import 'package:markmyprogress/pages/list_bookmark.dart';

import 'di_setup.dart';

Future<void> main() async {
  await setupProductionDependencyInjection(inPlace: AppPlatform.isDesktop);
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
            create: (_) => getIt.get<BookmarkBloc>()..add(BookmarkBlocEvent.load()),
          ),
          BlocProvider(
            create: (_) => getIt.get<PreferenceBloc>()..add(PreferenceBlocEvent.load()),
          ),
        ],
        child: EasyLocalization(
          path: 'assets/localization',
          supportedLocales: [Locale('en')],
          assetLoader: RootBundleAssetLoader(),
          fallbackLocale: Locale('en'),
          child: MyMaterialApp(),
        ));
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: const Color.fromARGB(255, 191, 63, 63),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: const Color.fromARGB(255, 191, 63, 63),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BookmarkList(),
      );
}
