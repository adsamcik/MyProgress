import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:MarkMyProgress/data/database/data/instance/SettingsStore.dart';
import 'package:MarkMyProgress/data/runtime/FilterRuntimeData.dart';
import 'package:MarkMyProgress/data/runtime/SettingsResult.dart';
import 'package:MarkMyProgress/data/settings/FilterData.dart';
import 'package:MarkMyProgress/edit_record.dart';
import 'package:MarkMyProgress/extensions/DateExtension.dart';
import 'package:MarkMyProgress/settings.dart';
import 'package:MarkMyProgress/statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/instance/GenericBookmark.dart';
import 'extensions/StringExtensions.dart';
import 'extensions/UserBookmark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarkMyProgress ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataStore _dataStore = DataStore();
  final SettingsStore _settingsStore = SettingsStore();

  List<IPersistentBookmark> _bookmarks = [];
  List<IPersistentBookmark> _filteredBookmarks = [];
  FilterRuntimeData _filterRuntime = FilterRuntimeData(FilterData());

  Future<T> navigate<T>(WidgetBuilder builder) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: builder),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshBookmarks();
    _refreshSettings();
  }

  void _addNewItem() async {
    var newItem = GenericBookmark();
    var item = await navigate<IPersistentBookmark>(
        (context) => EditRecord(bookmark: newItem));

    if (item == null) {
      return;
    }

    await _dataStore.open();
    await _dataStore.insert(item);
    await _dataStore.close();
    _refreshBookmarks();
  }

  void _viewDetail(IPersistentBookmark bookmark) async {
    var item = await navigate<IPersistentBookmark>(
        (context) => EditRecord(bookmark: bookmark));

    if (item == null) {
      return;
    }

    _saveBookmark(item);
  }

  void _refreshBookmarks() async {
    await _dataStore.open();
    var bookmarks = (await _dataStore.getAll()).toList();
    bookmarks
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    await _dataStore.close();
    setState(() {
      _bookmarks = bookmarks;
    });
    _updateFilter();
  }

  void _incrementProgress(IPersistentBookmark bookmark) async {
    bookmark.incrementProgress();
    _saveBookmark(bookmark);
  }

  void _saveBookmark(IPersistentBookmark bookmark) async {
    await _dataStore.open();
    await _dataStore.update(bookmark);
    await _dataStore.close();
    _refreshBookmarks();
  }

  void _refreshSettings() async {
    await _settingsStore.open();
    var filterData = await _settingsStore.getFilterData();
    await _settingsStore.close();
    setState(() {
      _filterRuntime =
          FilterRuntimeData(filterData, query: _filterRuntime.query);
    });
    _updateFilter();
  }

  final TextEditingController _searchQueryController = TextEditingController();

  void _updateFilterQuery(String query) {
    _filterRuntime.query = query.toLowerCase();
    _updateFilter();
  }

  void _updateFilter() {
    Iterable<IPersistentBookmark> filterList = _bookmarks.toList();

    var strippedFilter = StringExtensions.stripString(_filterRuntime.query);

    if (strippedFilter.isNotEmpty) {
      filterList =
          filterList.where((readable) => readable.contains(strippedFilter));
    }

    var filterData = _filterRuntime.filterData;

    if (!filterData.abandoned) {
      filterList = filterList.where((readable) => !readable.abandoned);
    }

    if (!filterData.ended) {
      filterList = filterList.where((readable) => readable.ongoing);
    }

    if (!filterData.finished) {
      filterList = filterList.where((readable) =>
          readable.ongoing || readable.progress < readable.maxProgress);
    }

    if (!filterData.ongoing) {
      filterList = filterList.where((readable) => !readable.ongoing);
    }

    setState(() {
      _filteredBookmarks = filterList.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
            padding: EdgeInsets.all(32),
            child: Ink(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.elliptical(8, 16))),
                child: TextField(
                  controller: _searchQueryController,
                  autofocus: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  onChanged: (query) => _updateFilterQuery(query),
                ))),
        actions: [
          FlatButton(
              onPressed: () {
                navigate<dynamic>((context) => Statistics());
              },
              child: Icon(
                Icons.insert_chart,
                color: Color.fromARGB(229, 255, 255, 255),
              )),
          FlatButton(
              onPressed: () async {
                var result =
                    await navigate<SettingsResult>((context) => Settings()) ??
                        SettingsResult(true, true);
                if (result.filterChanged) {
                  _refreshSettings();
                }

                if (result.dataImported) {
                  _refreshBookmarks();
                }
              },
              child: Icon(
                Icons.settings,
                color: Color.fromARGB(229, 255, 255, 255),
              )),
        ],
      ),
      body: SafeArea(
          child: Scrollbar(
        controller: ScrollController(initialScrollOffset: 0),
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 96),
          separatorBuilder: (context, index) => Divider(
            color: Theme.of(context).backgroundColor,
            height: 0,
          ),
          itemBuilder: (context, index) {
            var bookmark = _filteredBookmarks[index];
            var lastProgressDate = bookmark.lastProgress.date == Date.invalid()
                ? ''
                : bookmark.lastProgress.date.toDateString();
            return InkWell(
                onTap: () => _viewDetail(bookmark),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(children: [
                      ConstrainedBox(
                          constraints: BoxConstraints.tightForFinite(width: 90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${bookmark.progress} / ${bookmark.maxProgress}',
                                maxLines: 1,
                              ),
                              Text(
                                lastProgressDate,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          )),
                      SizedBox(width: 16),
                      Expanded(
                          child: Container(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    bookmark.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )))),
                      SizedBox(width: 16),
                      if (bookmark is IWebBookmark &&
                          ((bookmark as IWebBookmark).webAddress ?? '')
                              .isNotEmpty)
                        OutlineButton(
                            child: Text('Web'),
                            onPressed: () {
                              // can launch is not implemented on Windows
                              //canLaunch(webBookmark.webAddress).then((value) {
                              //if (value) {
                              launch((bookmark as IWebBookmark).webAddress);
                              //}
                              //});
                            }),
                      OutlineButton(
                          child: Text('+ ${bookmark.progressIncrement}'),
                          onPressed: () => _incrementProgress(bookmark)),
                    ])));
          },
          itemCount: _filteredBookmarks.length,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        tooltip: 'Add new bookmark',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
