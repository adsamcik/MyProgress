import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:MarkMyProgress/data/extension/DateExtension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/abstract/IBookmark.dart';
import 'data/instance/GenericBookmark.dart';
import 'data/extension/UserBookmark.dart';

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
  List<IPersistentBookmark> _bookmarks = [];
  final List<DataRow> _rowList = [];

  _MyHomePageState() {
    _refreshBookmarks();
  }

  void _addNewItem() async {
    await _dataStore.open();
    var bookmark = GenericBookmark();
    bookmark.originalTitle = 'Test';
    bookmark.webAddress = 'http://example.com/';
    await _dataStore.insert(bookmark);
    await _dataStore.close();
    _refreshBookmarks();
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        DataTable(
          columns: [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Progress'), numeric: true),
            DataColumn(label: Text('Last progress')),
            DataColumn(label: Text('Actions'))
          ],
          rows: _rowList,
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateRows() {
    _rowList.clear();
    _bookmarks.forEach((element) {
      _rowList.add(_buildRow(element));
    });
  }

  DataRow _buildRow(IPersistentBookmark bookmark) {
    var actions = <MaterialButton>[];

    actions.add(
        OutlineButton(child: Text('+ ${bookmark.progressIncrement}'), onPressed: () => _incrementProgress(bookmark)));

    if (bookmark is IWebBookmark) {
      var webBookmark = (bookmark as IWebBookmark);
      if ((webBookmark.webAddress ?? '').isNotEmpty) {
        var result = (webBookmark.webAddress ?? '').isNotEmpty;
        actions.add(OutlineButton(
            child: Text('Web'),
            onPressed: () {
              canLaunch(webBookmark.webAddress).then((value) {
                if (value) {
                  launch(webBookmark.webAddress);
                }
              });
            }));
      }
    }

    return DataRow(
      cells: [
        DataCell(Text(bookmark.title)),
        DataCell(Text(bookmark.progress.toString())),
        DataCell(Text(bookmark.lastProgress.date.toDateString())),
        DataCell(Row(
          children: actions,
        )),
      ],
    );
  }
}
