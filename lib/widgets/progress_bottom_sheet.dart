import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:markmyprogress/extensions/bookmark_extensions.dart';
import 'package:markmyprogress/extensions/context_extensions.dart';
import 'package:markmyprogress/generated/locale_keys.g.dart';
import 'package:markmyprogress/input/reg_ex_input_formatter.dart';
import 'package:markmyprogress/misc/app_icons.dart';
import 'package:markmyprogress/pages/view_bookmark.dart';
import 'package:rational/rational.dart';

Future<Rational> showProgressBottomSheet(BuildContext context, PersistentBookmark bookmark) {
  return showModalBottomSheet<Rational>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      builder: (context) {
        var result = bookmark.progress;

        var theme = Theme.of(context);
        var createButton = ({IconData icon, void Function() onPressed, Widget child}) => ListTile(
              onTap: onPressed,
              title: child,
              leading: Icon(icon),
            );

        var streamInput = StreamController<Rational>();
        var textEditingController = TextEditingController(text: result.toDecimalString());

        streamInput.stream.listen((event) {
          textEditingController.value = TextEditingValue(text: event.toDecimalString());
          result = event;
        });

        var numberFieldStream = TextFormField(
          controller: textEditingController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
          onChanged: (String value) => result = Rational.parse(value),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.highlightColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.chipTheme.backgroundColor, width: 1.0),
            ),
            hintText: LocaleKeys.progress.tr(),
          ),
        );
        ;

        var childrenValues = {
          bookmark.progressIncrement,
          Rational.fromInt(1),
          bookmark.progress.floor() + Rational.one - bookmark.progress,
        }.toList();
        childrenValues.sort();

        var tileArray = childrenValues
            .map<ListTile>((e) => createButton(
                icon: AppIcons.plus_squared,
                child: Text(e.toDecimalString()),
                onPressed: () {
                  streamInput.add(result + e);
                }))
            .toList();

        return Column(
          children: [
            Column(children: tileArray),
            Padding(
              padding: EdgeInsets.all(16),
              child: numberFieldStream,
            ),
            Column(
              children: [
                createButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text(LocaleKeys.cancel.tr()),
                  icon: AppIcons.cancel_squared,
                ),
                createButton(
                  onPressed: () => Navigator.pop(context, result),
                  child: Text(LocaleKeys.save.tr()),
                  icon: AppIcons.save,
                ),
              ],
            ),
            Divider(),
            createButton(
              icon: AppIcons.book,
              child: Text(LocaleKeys.show_details.tr()),
              onPressed: () async => await context.navigate<void>((context) => ViewBookmark(bookmarkKey: bookmark.key)),
            )
          ],
        );
      });
}
