import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:MarkMyProgress/data/database/data/instance/SettingsStore.dart';
import 'package:MarkMyProgress/data/runtime/FilterRuntimeData.dart';
import 'package:MarkMyProgress/data/runtime/Pair.dart';
import 'package:MarkMyProgress/data/runtime/SearchResult.dart';
import 'package:MarkMyProgress/data/runtime/SearchableBookmark.dart';
import 'package:MarkMyProgress/data/settings/FilterData.dart';
import 'package:MarkMyProgress/edit_record.dart';
import 'package:MarkMyProgress/extensions/DateExtension.dart';
import 'package:MarkMyProgress/settings.dart';
import 'package:MarkMyProgress/statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/instance/GenericBookmark.dart';
import 'data/runtime/SettingsResult.dart';
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
        brightness: Brightness.dark,
        accentColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
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

  List<ISearchResult<IPersistentBookmark>> _filteredBookmarks = [];
  FilterRuntimeData _filterRuntime = FilterRuntimeData(FilterData());

  List<SearchableBookmark> _searchList = [];

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
      _searchList =
          bookmarks.map((e) => SearchableBookmark(e)).toList(growable: false);
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
    Iterable<SearchableBookmark> filterList = _searchList;

    var filterData = _filterRuntime.filterData;

    if (!filterData.abandoned) {
      filterList = filterList.where((readable) => !readable.bookmark.abandoned);
    }

    if (!filterData.ended) {
      filterList = filterList.where((readable) => readable.bookmark.ongoing);
    }

    if (!filterData.finished) {
      filterList = filterList.where((readable) =>
          readable.bookmark.ongoing ||
          readable.bookmark.progress < readable.bookmark.maxProgress);
    }

    if (!filterData.ongoing) {
      filterList = filterList.where((readable) => !readable.bookmark.ongoing);
    }

    var strippedFilter = StringExtensions.stripString(_filterRuntime.query);

    if (strippedFilter.isNotEmpty) {
      var matchList = filterList
          .map((e) => Pair(e.bestMatch(strippedFilter), e))
          .where((element) => element.item1.match > 0)
          .toList();

      matchList.sort((a, b) {
        var aValue = a.item1.match * a.item1.priority;
        var bValue = b.item1.match * b.item1.priority;
        if (aValue > bValue) {
          return -1;
        } else if (aValue < bValue) {
          return 1;
        } else {
          return 0;
        }
      });

      filterList = matchList.map((e) => e.item2).toList();
      var filterResult = matchList
          .map((e) => SearchResult(e.item2.bookmark, e.item1.match))
          .toList();
      setState(() {
        _filteredBookmarks = filterResult;
      });
    } else {
      setState(() {
        _filteredBookmarks =
            filterList.map((e) => SearchResult(e.bookmark, 1.0)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Scrollbar(
            controller: ScrollController(initialScrollOffset: 0),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(0, 72, 0, 96),
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).dividerColor,
                height: 0,
              ),
              itemBuilder: (context, index) {
                var item = _filteredBookmarks[index];
                var bookmark = item.value;

                String title;
                if (kDebugMode && item.match != 1) {
                  title =
                      '${bookmark.title} - (${item.match.toStringAsFixed(2)})';
                } else {
                  title = bookmark.title;
                }

                var lastProgressDate =
                    bookmark.lastProgress.date == Date.invalid()
                        ? ''
                        : bookmark.lastProgress.date.toDateString();
                return InkWell(
                    onTap: () => _viewDetail(bookmark),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Opacity(
                          opacity: item.match,
                          child: Row(children: [
                            ConstrainedBox(
                                constraints:
                                    BoxConstraints.tightForFinite(width: 90),
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
                                          title,
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
                                    launch(
                                        (bookmark as IWebBookmark).webAddress);
                                    //}
                                    //});
                                  }),
                            OutlineButton(
                                child: Text('+ ${bookmark.progressIncrement}'),
                                onPressed: () => _incrementProgress(bookmark)),
                          ]),
                        )));
              },
              itemCount: _filteredBookmarks.length,
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: Material(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                elevation: 2,
                child: PreferredSize(
                    preferredSize: Size.fromHeight(64),
                    child: Row(children: [
                      Expanded(
                          child: TextField(
                        controller: _searchQueryController,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                        onChanged: (query) => _updateFilterQuery(query),
                      )),
                      IconButton(
                          onPressed: () {
                            navigate<dynamic>((context) => Statistics());
                          },
                          icon: Icon(
                            Icons.insert_chart,
                          )),
                      IconButton(
                          onPressed: () async {
                            var result = await navigate<SettingsResult>(
                                    (context) => Settings()) ??
                                SettingsResult(true, true);
                            if (result.filterChanged) {
                              _refreshSettings();
                            }

                            if (result.dataImported) {
                              _refreshBookmarks();
                            }
                          },
                          icon: Icon(
                            Icons.settings,
                          )),
                    ]))),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        tooltip: 'Add new bookmark',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
