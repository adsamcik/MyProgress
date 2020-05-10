import 'package:MarkMyProgress/data/preference/database/SettingsStore.dart';
import 'package:MarkMyProgress/import/Exporter.dart';
import 'package:MarkMyProgress/import/Importer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final SettingsStore _store = SettingsStore();

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
  final Map<String, bool> _filterMap = <String, bool>{};

  Future _setFilter(String name, bool value) async {
    await _store.open();
    await _store.upsert(name, value);
    await _store.close();

    setState(() {
      _filterMap[name] = value;
    });
  }

  Iterable<Widget> get filterWidgets sync* {
    for (var filter in _filterDataList) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          label: Text(filter.name),
          tooltip: filter.tooltip,
          selected: _filterMap[filter.key],
          onSelected: (bool value) => _setFilter(filter.key, value),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFilter();
  }

  Future _loadFilter() async {
    await _store.open();
    var filterMap = await _store.getFilterMap();
    await _store.close();

    setState(() {
      filterMap.forEach((key, dynamic value) {
        if (value != null && value is bool) {
          _filterMap[key] = value;
        }
      });
    });
  }

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
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Wrap(children: filterWidgets.toList()),
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
            ))));
  }
}
