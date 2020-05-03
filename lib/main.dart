import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:MarkMyProgress/data/database/data/instance/SettingsStore.dart';
import 'package:MarkMyProgress/data/runtime/SettingsResult.dart';
import 'package:MarkMyProgress/extensions/DateExtension.dart';
import 'package:MarkMyProgress/data/runtime/FilterData.dart';
import 'package:MarkMyProgress/data/runtime/FilterItem.dart';
import 'package:MarkMyProgress/edit_record.dart';
import 'package:MarkMyProgress/settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'extensions/StringExtensions.dart';
import 'data/instance/GenericBookmark.dart';
import 'extensions/UserBookmark.dart';
import 'extensions/ListExtensions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home'),
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
  final List<DataRow> _rowList = [];
  List<DataRow> _filteredRowList = [];
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
    var item = await navigate<IPersistentBookmark>((context) => EditRecord(bookmark: newItem));

    if (item == null) {
      return;
    }

    await _dataStore.open();
    await _dataStore.insert(item);
    await _dataStore.close();
    _refreshBookmarks();
  }

  void _viewDetail(IPersistentBookmark bookmark) async {
    var item = await navigate<IPersistentBookmark>((context) => EditRecord(bookmark: bookmark));

    if (item == null) {
      return;
    }

    _saveBookmark(item);
  }

  void _refreshBookmarks() async {
    await _dataStore.open();
    var bookmarks = (await _dataStore.getAll()).toList();
    await _dataStore.close();
    setState(() {
      _bookmarks = bookmarks;
      _updateRows();
    });
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
      _filterRuntime = FilterRuntimeData(filterData, query: _filterRuntime.query);
    });
    _updateFilter();
  }

  final TextEditingController _searchQueryController = TextEditingController();

  void _updateFilterQuery(String query) {
    _filterRuntime.query = query.toLowerCase();
    _updateFilter();
  }

  void _updateFilter() {
    var filterList = List<FilterItem<IPersistentBookmark>>(_bookmarks.length);
    for (var i = 0; i < filterList.length; i++) {
      filterList[i] = FilterItem(data: _bookmarks[i], index: i);
    }

    Iterable<FilterItem<IPersistentBookmark>> tmp = filterList;

    var strippedFilter = StringExtensions.stripString(_filterRuntime.query);

    if (strippedFilter.isNotEmpty) {
      tmp = tmp.where((readable) => readable.data.contains(strippedFilter));
    }

    var filterData = _filterRuntime.filterData;
    if (filterData.reading) {
      tmp = tmp.where((readable) =>
          !readable.data.abandoned && (readable.data.ongoing || readable.data.progress < readable.data.maxProgress));
    }

    if (filterData.abandoned) {
      tmp = tmp.where((readable) => !readable.data.abandoned);
    }

    if (filterData.ended) {
      tmp = tmp.where((readable) => readable.data.ongoing);
    }

    if (filterData.finished) {
      tmp = tmp.where((readable) => readable.data.ongoing || readable.data.progress < readable.data.maxProgress);
    }

    if (filterData.ongoing) {
      tmp = tmp.where((readable) => !readable.data.ongoing);
    }

    var filterRowIndexes = tmp.map((e) => e.index).toList(growable: false);
    var filteredRowList = _rowList.filterWithIndexList(filterRowIndexes);

    setState(() {
      _filteredRowList = filteredRowList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
            padding: EdgeInsets.all(32),
            child: TextField(
              controller: _searchQueryController,
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              onChanged: (query) => _updateFilterQuery(query),
            )),
        actions: [
          FlatButton(onPressed: () {}, child: Icon(Icons.insert_chart)),
          FlatButton(
              onPressed: () async {
                var result = await navigate<SettingsResult>((context) => Settings()) ?? SettingsResult(true, true);
                if (result.filterChanged) {
                  _refreshSettings();
                }

                if (result.dataImported) {
                  _refreshBookmarks();
                }
              },
              child: Icon(Icons.settings)),
        ],
      ),
      body: Container(
          child: Scrollbar(
              controller: ScrollController(initialScrollOffset: 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  DataTable(
                    sortAscending: true,
                    sortColumnIndex: 0,
                    columns: [
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Progress'), numeric: true),
                      DataColumn(label: Text('Last progress')),
                      DataColumn(label: Text('Actions'))
                    ],
                    rows: _filteredRowList,
                  ),
                ]),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        tooltip: 'Add new bookmark',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateRows() {
    _rowList.clear();
    _bookmarks.forEach((element) {
      _rowList.add(_buildRow(element));
    });
    _updateFilter();
  }

  DataRow _buildRow(IPersistentBookmark bookmark) {
    var actions = <Widget>[];

    actions.add(
        OutlineButton(child: Text('+ ${bookmark.progressIncrement}'), onPressed: () => _incrementProgress(bookmark)));

    if (bookmark is IWebBookmark) {
      var webBookmark = (bookmark as IWebBookmark);
      if ((webBookmark.webAddress ?? '').isNotEmpty) {
        actions.add(SizedBox(
            width: 10,
            child: OutlineButton(
                child: Text('Web'),
                onPressed: () {
                  // can launch is not implemented on Windows
                  //canLaunch(webBookmark.webAddress).then((value) {
                  //if (value) {
                  launch(webBookmark.webAddress);
                  //}
                  //});
                })));
      }
    }

    var lastProgressDate =
        bookmark.lastProgress.date == Date.invalid() ? '' : bookmark.lastProgress.date.toDateString();

    var tapFunction = () => _viewDetail(bookmark);

    return DataRow(
      cells: [
        DataCell(
            Text(
              bookmark.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: tapFunction),
        DataCell(ConstrainedBox(constraints: BoxConstraints(maxWidth: 75), child: Text(bookmark.progress.toString())),
            onTap: tapFunction),
        DataCell(
            ConstrainedBox(constraints: BoxConstraints(minWidth: 100, maxWidth: 150), child: Text(lastProgressDate)),
            onTap: tapFunction),
        DataCell(Row(
          children: actions,
        )),
      ],
    );
  }
}
