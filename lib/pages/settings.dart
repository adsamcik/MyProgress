import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprogress/data/preference/bloc/bloc.dart';
import 'package:myprogress/generated/locale_keys.g.dart';
import 'package:myprogress/import/exporter.dart';
import 'package:myprogress/import/importer.dart';
import 'package:myprogress/misc/get.dart';

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
    const BookmarkFilterEntry('abandoned', LocaleKeys.filter_abandoned, tooltip: LocaleKeys.filter_abandoned_desc),
    const BookmarkFilterEntry('ongoing', LocaleKeys.filter_ongoing, tooltip: LocaleKeys.filter_ongoing_desc),
    const BookmarkFilterEntry('ended', LocaleKeys.filter_ended, tooltip: LocaleKeys.filter_ended_desc),
    const BookmarkFilterEntry('finished', LocaleKeys.filter_finished, tooltip: LocaleKeys.filter_finished_desc),
    const BookmarkFilterEntry('noProgress', LocaleKeys.filter_no_progress, tooltip: LocaleKeys.filter_no_progress_desc),
    const BookmarkFilterEntry('maxProgress', LocaleKeys.filter_max_progress,
        tooltip: LocaleKeys.filter_max_progress_desc),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
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
              ready: (ready) => Wrap(
                direction: Axis.vertical,
                spacing: 16.0,
                children: [
                  Text(
                    LocaleKeys.filter.tr(),
                    style: Get.theme(context).textTheme.headline5,
                  ),
                  Wrap(
                    children: _filterDataList
                        .map((filter) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FilterChip(
                                  label: Text(filter.name.tr()),
                                  tooltip: filter.tooltip,
                                  selected: ready.preferences[filter.key] as bool,
                                  onSelected: (bool value) => context
                                      .watch<PreferenceBloc>()
                                      .add(PreferenceBlocEvent.setPreference(key: filter.key, value: value))),
                            ))
                        .toList(),
                  ),
                  OutlinedButton(
                      child: Text(LocaleKeys.about.tr()),
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(16.0))),
                      onPressed: () async {
                        // Windows not yet supported
                        //var packageInfo = await PackageInfo.fromPlatform();
                        //showAboutDialog(context: context, applicationName: packageInfo.appName, applicationVersion: packageInfo.version);
                        showAboutDialog(context: context, applicationName: LocaleKeys.app_name.tr());
                      }),
                  Wrap(spacing: 16, children: [
                    OutlinedButton(
                        child: Text(LocaleKeys.import.tr()),
                        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(16.0))),
                        onPressed: () async {
                          await Importer.import();
                        }),
                    OutlinedButton(
                        child: Text(LocaleKeys.export.tr()),
                        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(16.0))),
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
