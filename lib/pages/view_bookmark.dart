import 'dart:math';

import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/web_bookmark.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:MarkMyProgress/extensions/numbers.dart';
import 'package:MarkMyProgress/extensions/state_extensions.dart';
import 'package:MarkMyProgress/extensions/string_extensions.dart';
import 'package:MarkMyProgress/pages/edit_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/bookmark/abstract/persistent_bookmark.dart';

class ViewBookmark extends StatefulWidget {
  final PersistentBookmark bookmark;

  ViewBookmark({@required this.bookmark});

  @override
  State<StatefulWidget> createState() {
    return _ViewBookmarkState(bookmark: bookmark);
  }
}

class _ItemData {
  final IconData icon;
  final String title;
  final String value;
  final void Function() onTap;

  _ItemData(this.icon, this.title, this.value, {this.onTap});
}

class _HistoryData {
  final DateTime date;
  final double value;
  final double deltaValue;

  _HistoryData(this.date, this.value, this.deltaValue);
}

class _ViewBookmarkState extends State<ViewBookmark> {
  final PersistentBookmark bookmark;

  final List<_ItemData> _generalDataList = [];
  final List<_HistoryData> _historyDataList = [];

  _ViewBookmarkState({@required this.bookmark});

  @override
  void initState() {
    super.initState();

    if (bookmark.originalTitle.isNotNullOrEmpty) {
      _generalDataList.add(
          _ItemData(Icons.title, 'Original title', bookmark.originalTitle));
    }

    if (bookmark.localizedTitle.isNotNullOrEmpty) {
      _generalDataList.add(
          _ItemData(Icons.title, 'Localized title', bookmark.localizedTitle));
    }

    if (bookmark is WebBookmark) {
      var webBookmark = bookmark as WebBookmark;
      if (webBookmark.webAddress.isNotNullOrEmpty) {
        _generalDataList.add(_ItemData(
          Icons.web,
          'Web address',
          webBookmark.webAddress,
          onTap: () => launch(webBookmark.webAddress),
        ));
      }
    }

    var historyList =
        (bookmark.history ?? <Progress>[]).reversed.take(10).toList().reversed;

    var lastProgress = 0.0;
    historyList.forEach((element) {
      var progress = lastProgress == 0 ? 0.0 : element.value - lastProgress;
      _historyDataList.add(_HistoryData(element.date, element.value, progress));
      lastProgress = element.value;
    });
  }

  Widget _buildRowWrapper(Iterable<Widget> children, [void Function() onTap]) =>
      InkWell(
          onTap: onTap,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: children.toList(),
              )));

  List<Widget> _buildProgressData() {
    return [
      _buildRowWrapper([
        Expanded(
            child: Stack(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: LinearProgressIndicator(
                    value: (bookmark.progress / bookmark.maxProgress),
                    semanticsValue: bookmark.progress.toString(),
                    semanticsLabel: 'Progress',
                  )),
            ),
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  var progress = bookmark.progress.toString();
                  var textStyle = Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold);
                  var renderParagraph = RenderParagraph(
                    TextSpan(text: progress, style: textStyle),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  );
                  renderParagraph.layout(constraints);
                  var theme = Theme.of(context);
                  const padding = 16.0;
                  const textProgressPadding = 4.0;
                  var textWidth = renderParagraph
                      .getMinIntrinsicWidth(textStyle.fontSize)
                      .ceilToDouble();

                  var textHeight = renderParagraph
                      .getMinIntrinsicHeight(textStyle.fontSize)
                      .ceilToDouble();

                  var textOffsetHorizontal = max(
                      min(
                          constraints.biggest.width *
                                  (bookmark.progress / bookmark.maxProgress) +
                              textProgressPadding,
                          constraints.biggest.width - textWidth - padding),
                      padding);

                  return Padding(
                    padding: EdgeInsets.only(
                      left: textOffsetHorizontal,
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          progress,
                          textAlign: TextAlign.left,
                          style: textStyle,
                        )),
                  );
                },
              ),
            )
          ],
        ))
      ])
    ];
  }

  List<Widget> _buildGeneralData() {
    var widgetList = List<Widget>(_generalDataList.length);

    for (var i = 0; i < _generalDataList.length; i++) {
      var item = _generalDataList[i];
      widgetList[i] = _buildRowWrapper([
        Expanded(
            child: Row(children: [
          Icon(item.icon),
          SizedBox(width: 16),
          Text(item.title)
        ])),
        Expanded(child: Text(item.value)),
      ], item.onTap);
    }
    return widgetList;
  }

  Widget _buildHistoryItem(int index) {
    if (index == 0) {
      return _buildRowWrapper([
        Expanded(child: Text('Date')),
        Expanded(child: Text('Progress')),
      ], null);
    } else {
      var item = _historyDataList[_historyDataList.length - index];
      var symbol = item.deltaValue >= 0 ? '+' : '';

      String diff;

      if (item.deltaValue == 0) {
        if (_historyDataList.length == bookmark.history.length) {
          diff = '+${item.value.toPrecision(2).toString()}';
        } else {
          diff = '...';
        }
      } else {
        diff = '$symbol${item.deltaValue.toPrecision(2).toString()}';
      }

      return _buildRowWrapper([
        Expanded(child: Text(item.date.toDateString())),
        Expanded(child: Text('${item.value} ($diff)')),
      ], null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmark.title),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              minimum: EdgeInsets.all(16.0),
              maintainBottomViewPadding: true,
              child: Column(children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildGeneralData(),
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildProgressData(),
                  ),
                ),
                Card(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _historyDataList.length + 1,
                    itemBuilder: (context, index) {
                      return _buildHistoryItem(index);
                    },
                  ),
                ),
              ]))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate<void>((context) => EditRecord(bookmark: bookmark));
        },
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    );
  }
}
