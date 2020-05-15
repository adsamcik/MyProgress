import 'package:MarkMyProgress/data/preference/bloc/bloc.dart';
import 'package:MarkMyProgress/get.dart';
import 'package:MarkMyProgress/import/exporter.dart';
import 'package:MarkMyProgress/import/importer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class BookmarkFilterEntry {
  final String key;
  final String name;
  final String tooltip;

  const BookmarkFilterEntry(this.key, this.name, {this.tooltip});
}

class _SettingsState extends State<Settings> {
  final List<BookmarkFilterEntry> _filterDataList = <BookmarkFilterEntry>[
    const BookmarkFilterEntry('abandoned', 'Abandoned',
        tooltip: 'Things you are no longer interested in and haven`t finished'),
    const BookmarkFilterEntry('ongoing', 'Ongoing',
        tooltip: 'Things that are expected to have new max progress in time.'),
    const BookmarkFilterEntry('ended', 'Ended',
        tooltip: 'Things that have have max progress that won`t change.'),
    const BookmarkFilterEntry('finished', 'Finished',
        tooltip: 'Things you have finished and won`t be extended.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(16.0),
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: BlocBuilder<PreferenceBloc, PreferenceBlocState>(
            builder: (context, state) => state.map(
              notReady: (state) => Container(),
              ready: (ready) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter',
                    style: Get.theme(context).textTheme.headline5,
                  ),
                  Wrap(
                    children: _filterDataList
                        .map((filter) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FilterChip(
                                  label: Text(filter.name),
                                  tooltip: filter.tooltip,
                                  selected:
                                      ready.preferences[filter.key] as bool,
                                  onSelected: (bool value) => context
                                      .bloc<PreferenceBloc>()
                                      .add(PreferenceBlocEvent.setPreference(
                                          key: filter.key, value: value))),
                            ))
                        .toList(),
                  ),
                  OutlineButton(
                      child: Text('About'),
                      onPressed: () async {
                        // Windows not yet supported
                        //var packageInfo = await PackageInfo.fromPlatform();
                        //showAboutDialog(context: context, applicationName: packageInfo.appName, applicationVersion: packageInfo.version);
                        showAboutDialog(
                            context: context,
                            applicationName: 'Mark My Progress');
                      }),
                  Wrap(spacing: 16, children: [
                    OutlineButton(
                        child: Text('Import'),
                        onPressed: () async {
                          if (await Importer.import()) {
                            //context.bloc<BookmarkBloc>();
                          }
                        }),
                    OutlineButton(
                        child: Text('Export'),
                        onPressed: () async {
                          await Exporter.export();
                        })
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
