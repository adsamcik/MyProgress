import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/web_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/bloc/bloc.dart';
import 'package:MarkMyProgress/data/bookmark/instance/no_progress.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/context_extensions.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:MarkMyProgress/extensions/string_extensions.dart';
import 'package:MarkMyProgress/generated/locale_keys.g.dart';
import 'package:MarkMyProgress/misc/app_icons.dart';
import 'package:MarkMyProgress/pages/edit_bookmark.dart';
import 'package:MarkMyProgress/widgets/label_progress_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rational/rational.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewBookmark extends StatefulWidget {
  final int bookmarkKey;

  ViewBookmark({@required this.bookmarkKey});

  @override
  State<StatefulWidget> createState() {
    return _ViewBookmarkState();
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
  final Rational value;
  final Rational deltaValue;

  _HistoryData(this.date, this.value, this.deltaValue);
}

class _ViewBookmarkState extends State<ViewBookmark> {
  final List<_ItemData> _generalDataList = [];
  final List<_HistoryData> _historyDataList = [];
  bool _isCompleteHistory = false;

  void _updateState(PersistentBookmark bookmark) {
    _generalDataList.clear();

    if (bookmark.originalTitle.isNotNullOrEmpty) {
      _generalDataList.add(
          _ItemData(AppIcons.title, 'Original title', bookmark.originalTitle));
    }

    if (bookmark.localizedTitle.isNotNullOrEmpty) {
      _generalDataList.add(_ItemData(
          AppIcons.language, 'Localized title', bookmark.localizedTitle));
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

    var zero = Rational.zero;
    var lastProgress = zero;
    _historyDataList.clear();
    historyList.forEach((element) {
      var progress = lastProgress == zero ? zero : element.value - lastProgress;
      _historyDataList.add(_HistoryData(element.date, element.value, progress));
      lastProgress = element.value;
    });

    _isCompleteHistory = _historyDataList.length == bookmark.history.length;
  }

  Widget _buildRowWrapper(Iterable<Widget> children, [void Function() onTap]) =>
      InkWell(
          onTap: onTap,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: children.toList(),
              )));

  IconData _selectIcon(double value) {
    if (value < 0.2) {
      return AppIcons.progress_0;
    } else if (value < 0.4) {
      return AppIcons.progress_1;
    } else if (value < 0.9) {
      return AppIcons.progress_2;
    } else {
      return AppIcons.progress_3;
    }
  }

  List<Widget> _buildProgressData(PersistentBookmark bookmark) {
    var lastProgress = bookmark.lastProgress;
    var progress = bookmark.maxProgress < bookmark.progress
        ? 1.0
        : (bookmark.progress / bookmark.maxProgress).toDouble();

    return [
      _buildRowWrapper(
        _buildIconValueRow(_selectIcon(progress), LocaleKeys.progress.tr(),
            bookmark.progress.toDecimalString()),
        null,
      ),
      _buildRowWrapper(
        _buildIconValueRow(AppIcons.progress_3, LocaleKeys.max_progress.tr(),
            bookmark.maxProgress.toDecimalString()),
        null,
      ),
      if (!(lastProgress is NoProgress))
        _buildRowWrapper(
          _buildIconValueRow(AppIcons.calendar, LocaleKeys.last_progress.tr(),
              lastProgress.date.toDateString()),
          null,
        ),
      _buildRowWrapper([
        Expanded(
            child: LinearLabelProgressIndicator(
          value: progress,
          textValue: bookmark.progress.toDecimalString(),
        ))
      ]),
    ];
  }

  List<Widget> _buildIconValueRow(IconData icon, String title, String value) {
    return [
      Expanded(
          child: Row(children: [
        Icon(icon),
        SizedBox(width: 16),
        Text(title),
      ])),
      Expanded(child: Text(value)),
    ];
  }

  List<Widget> _buildGeneralData() {
    var widgetList = List<Widget>(_generalDataList.length);

    for (var i = 0; i < _generalDataList.length; i++) {
      var item = _generalDataList[i];
      widgetList[i] = _buildRowWrapper(
          _buildIconValueRow(
            item.icon,
            item.title,
            item.value,
          ),
          item.onTap);
    }
    return widgetList;
  }

  Widget _buildHistoryItem(int index) {
    if (index == 0) {
      return _buildRowWrapper([
        Expanded(child: Text(LocaleKeys.date.tr())),
        Expanded(child: Text(LocaleKeys.progress.tr())),
      ], null);
    } else {
      var dataIndex = _historyDataList.length - index;
      var item = _historyDataList[dataIndex];
      var symbol = item.deltaValue >= Rational.zero ? '+' : '';

      String diff;

      if (dataIndex == 0 && item.deltaValue == Rational.zero) {
        if (_isCompleteHistory) {
          diff = '+${item.value.toStringAsPrecision(2)}';
        } else {
          diff = '…';
        }
      } else {
        diff = '$symbol${item.deltaValue.toStringAsPrecision(2)}';
      }

      return _buildRowWrapper([
        Expanded(child: Text(item.date.toDateString())),
        Expanded(child: Text('${item.value.toDecimalString()} ($diff)')),
      ], null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkBlocState>(
        builder: (BuildContext context, state) => state.maybeMap(
            ready: (ready) {
              var bookmark = ready.bookmarkList
                  .firstWhere(
                      (element) => element.bookmark.key == widget.bookmarkKey)
                  .bookmark;

              _updateState(bookmark);

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
                            children: _buildProgressData(bookmark),
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
                      ])),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    context.navigate<void>(
                        (context) => EditBookmark(bookmark: bookmark));
                  },
                  tooltip: LocaleKeys.edit.tr(),
                  child: Icon(Icons.edit),
                ),
              );
            },
            orElse: () => Container()));
  }
}
