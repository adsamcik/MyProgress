import 'package:MarkMyProgress/data/bookmark/bloc/bloc.dart';
import 'package:MarkMyProgress/pages/bookmark_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'di_setup.dart';

void main() {
  setupDependencyInjection();

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
        ],
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
          home: BookmarkList(title: 'List'),
        ));
  }
}
