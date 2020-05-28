import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/web_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/bloc/bloc.dart';
import 'package:MarkMyProgress/data/bookmark/instance/generic_bookmark.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:MarkMyProgress/extensions/numbers.dart';
import 'package:MarkMyProgress/extensions/state_extensions.dart';
import 'package:MarkMyProgress/generated/locale_keys.g.dart';
import 'package:MarkMyProgress/misc/app_icons.dart';
import 'package:MarkMyProgress/misc/get.dart';
import 'package:MarkMyProgress/pages/settings.dart';
import 'package:MarkMyProgress/pages/statistics.dart';
import 'package:MarkMyProgress/pages/view_bookmark.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_bookmark.dart';

class BookmarkList extends StatefulWidget {
  BookmarkList({Key key}) : super(key: key);

  @override
  _BookmarkListState createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  void _addNewItem(BuildContext context) async {
    var newItem = GenericBookmark();
    await navigate<void>((context) => EditBookmark(bookmark: newItem));
  }

  void _viewDetail(PersistentBookmark bookmark) async {
    await navigate<void>((context) => ViewBookmark(bookmarkKey: bookmark.key));
  }

  final TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          BlocBuilder<BookmarkBloc, BookmarkBlocState>(
            builder: (context, state) {
              return state.maybeWhen(
                ready:
                    (version, bookmarkList, filteredBookmarkList, filterData) {
                  return Scrollbar(
                      controller: ScrollController(initialScrollOffset: 0),
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(0, 72, 0, 96),
                        separatorBuilder: (context, index) => Divider(
                          color: Get.theme(context).dividerColor,
                          height: 0,
                        ),
                        itemBuilder: (context, index) {
                          var item = filteredBookmarkList[index];
                          var bookmark = item.value;

                          String title;
                          if (kDebugMode && item.match != 1) {
                            title =
                                '${bookmark.title} - (${item.match.toPrecision(2).toString()})';
                          } else {
                            title = bookmark.title;
                          }

                          var lastProgressDate =
                              bookmark.lastProgress.date == Date.invalid
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
                                              BoxConstraints.tightForFinite(
                                                  width: 90),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${bookmark.progress.toDecimalString()} / ${bookmark.maxProgress.toDecimalString()}',
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )))),
                                      SizedBox(width: 16),
                                      if (bookmark is WebBookmark &&
                                          ((bookmark as WebBookmark)
                                                      .webAddress ??
                                                  '')
                                              .isNotEmpty)
                                        OutlineButton(
                                            child: Text(LocaleKeys.web).tr(),
                                            onPressed: () {
                                              // can launch is not implemented on Windows
                                              //canLaunch(webBookmark.webAddress).then((value) {
                                              //if (value) {
                                              launch((bookmark as WebBookmark)
                                                  .webAddress);
                                              //}
                                              //});
                                            }),
                                      OutlineButton(
                                          child: Text(
                                              '+ ${bookmark.progressIncrement.toDecimalString()}'),
                                          onPressed: () => context
                                              .bloc<BookmarkBloc>()
                                              .add(BookmarkBlocEvent
                                                  .incrementProgress(
                                                      bookmark: bookmark))),
                                    ]),
                                  )));
                        },
                        itemCount: filteredBookmarkList.length,
                      ));
                },
                orElse: () => Container(),
              );
            },
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: Material(
                color: Get.theme(context).cardColor,
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
                          hintText: LocaleKeys.search.tr(),
                          border: InputBorder.none,
                        ),
                        onChanged: (query) => context.bloc<BookmarkBloc>().add(
                            BookmarkBlocEvent.updateFilterQuery(query: query)),
                      )),
                      IconButton(
                          onPressed: () {
                            navigate<dynamic>((context) => Statistics());
                          },
                          icon: Icon(AppIcons.insert_chart)),
                      IconButton(
                          onPressed: () async {
                            await navigate<dynamic>((context) => Settings());
                          },
                          icon: Icon(AppIcons.settings_applications)),
                      SizedBox(
                        width: 8,
                      )
                    ]))),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItem(context),
        tooltip: LocaleKeys.add_bookmark.tr(),
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
