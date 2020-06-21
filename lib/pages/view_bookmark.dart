import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:myprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:myprogress/data/bookmark/abstract/progress.dart';
import 'package:myprogress/data/bookmark/abstract/web_bookmark.dart';
import 'package:myprogress/data/bookmark/bloc/bloc.dart';
import 'package:myprogress/data/bookmark/instance/no_progress.dart';
import 'package:myprogress/extensions/bookmark.dart';
import 'package:myprogress/extensions/context.dart';
import 'package:myprogress/extensions/date.dart';
import 'package:myprogress/extensions/string.dart';
import 'package:myprogress/generated/locale_keys.g.dart';
import 'package:myprogress/misc/app_icons.dart';
import 'package:myprogress/pages/edit_bookmark.dart';
import 'package:myprogress/widgets/label_progress_bar.dart';
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
  bool _isDeleted = false;

  void _updateState(PersistentBookmark bookmark) {
    _generalDataList.clear();

    if (bookmark.originalTitle.isNotNullOrEmpty) {
      _generalDataList.add(_ItemData(AppIcons.title, 'Original title', bookmark.originalTitle));
    }

    if (bookmark.localizedTitle.isNotNullOrEmpty) {
      _generalDataList.add(_ItemData(AppIcons.language, 'Localized title', bookmark.localizedTitle));
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

    var historyList = (bookmark.history ?? <Progress>[]).reversed.take(10).toList().reversed;

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

  void _delete(PersistentBookmark bookmark) {
    _isDeleted = true;
    GetIt.instance.get<BookmarkBloc>().add(BookmarkBlocEvent.removeBookmark(bookmark: bookmark));
  }

  Widget _buildRowWrapper(Iterable<Widget> children, [void Function() onTap]) => InkWell(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: children.toList(),
          )));

  IconData _selectIcon(double value) {
    if (value < 0.2) {
      return AppIcons.progress_none;
    } else if (value < 0.4) {
      return AppIcons.progress_third;
    } else if (value < 0.9) {
      return AppIcons.progress_two_thirds;
    } else {
      return AppIcons.progress_done;
    }
  }

  List<Widget> _buildProgressData(PersistentBookmark bookmark) {
    var lastProgress = bookmark.lastProgress;
    var progress =
        bookmark.maxProgress <= bookmark.progress.abs() ? 1.0 : (bookmark.progress / bookmark.maxProgress).toDouble();

    return [
      _buildRowWrapper(
        _buildIconValueRow(_selectIcon(progress), LocaleKeys.progress.tr(), bookmark.progress.toDecimalString()),
        null,
      ),
      _buildRowWrapper(
        _buildIconValueRow(
            AppIcons.progress_done, LocaleKeys.max_progress.tr(), bookmark.maxProgress.toDecimalString()),
        null,
      ),
      if (!(lastProgress is NoProgress))
        _buildRowWrapper(
          _buildIconValueRow(AppIcons.calendar, LocaleKeys.last_progress.tr(), lastProgress.date.toDateString()),
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
              if (_isDeleted) {
                return Container();
              }

              var bookmark =
                  ready.bookmarkList.firstWhere((element) => element.bookmark.key == widget.bookmarkKey).bookmark;

              _updateState(bookmark);

              return Scaffold(
                appBar: AppBar(
                  title: Text(bookmark.title),
                  actions: [
                    IconButton(
                      icon: Icon(AppIcons.trash),
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(LocaleKeys.dialog_delete_title.tr(args: [bookmark.title])),
                                  content: Text(LocaleKeys.dialog_delete_description.tr(args: [bookmark.title])),
                                  actions: [
                                    FlatButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text(LocaleKeys.dialog_cancel.tr()),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        _delete(bookmark);
                                        Navigator.popUntil(context, ModalRoute.withName('/'));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text(LocaleKeys.dialog_delete_confirm.tr()),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                    ),
                    SizedBox.fromSize(
                      size: Size.fromWidth(16),
                    ),
                  ],
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
                    context.navigate<void>((context) => EditBookmark(bookmark: bookmark));
                  },
                  tooltip: LocaleKeys.edit.tr(),
                  child: Icon(Icons.edit),
                ),
              );
            },
            orElse: () => Container()));
  }
}
