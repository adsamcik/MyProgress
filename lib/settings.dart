import 'package:MarkMyProgress/data/database/data/instance/SettingsStore.dart';
import 'package:MarkMyProgress/data/runtime/SettingsResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'import/Importer.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class BookmarkFilterEntry {
  final String key;
  final String name;

  const BookmarkFilterEntry(this.key, this.name);
}

class _SettingsState extends State<Settings> {
  final SettingsStore _store = SettingsStore();

  MutableSettingsResult result = MutableSettingsResult();

  final List<BookmarkFilterEntry> _filterDataList = <BookmarkFilterEntry>[
    const BookmarkFilterEntry('reading', 'Reading'),
    const BookmarkFilterEntry('abandoned', 'Abandoned'),
    const BookmarkFilterEntry('ongoing', 'Ongoing'),
    const BookmarkFilterEntry('ended', 'Ended'),
    const BookmarkFilterEntry('finished', 'finished'),
  ];
  final List<String> _filters = <String>[];

  Future _setFilter(String name, bool value) async {
    await _store.open();
    await _store.upsert(name, value);
    await _store.close();

    result.filterChanged = true;

    setState(() {
      if (value) {
        _filters.add(name);
      } else {
        _filters.removeWhere((String itemName) {
          return itemName == name;
        });
      }
    });
  }

  Iterable<Widget> get filterWidgets sync* {
    for (var filter in _filterDataList) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          label: Text(filter.name),
          selected: _filters.contains(filter.key),
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

    _filters.clear();
    setState(() {
      var index = 0;
      filterMap.forEach((key, dynamic value) {
        if (value != null && value is bool && value) {
          _filters.add(_filterDataList[index].key);
        }
        index++;
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
                Navigator.pop(context, result);
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
                      showAboutDialog(context: context, applicationName: 'Mark My Progress');
                    }),
                Wrap(spacing: 16, children: [
                  OutlineButton(
                      child: Text('Import'),
                      onPressed: () async {
                        if (await Importer.import()) {
                          result.dataImported = true;
                        }
                      }),
                  OutlineButton(
                      child: Text('Export'),
                      onPressed: () async {
                        // Windows not yet supported
                        //var packageInfo = await PackageInfo.fromPlatform();
                        //showAboutDialog(context: context, applicationName: packageInfo.appName, applicationVersion: packageInfo.version);
                        showAboutDialog(context: context, applicationName: 'Mark My Progress');
                      })
                ]),
              ],
            ))));
  }
}
