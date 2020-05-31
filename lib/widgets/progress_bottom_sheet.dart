import 'dart:async';

import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/context_extensions.dart';
import 'package:MarkMyProgress/generated/locale_keys.g.dart';
import 'package:MarkMyProgress/input/reg_ex_input_formatter.dart';
import 'package:MarkMyProgress/pages/view_bookmark.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rational/rational.dart';

Future<Rational> showProgressBottomSheet(
    BuildContext context, PersistentBookmark bookmark) {
  return showModalBottomSheet<Rational>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      builder: (context) {
        var result = bookmark.progress;

        var theme = Theme.of(context);
        var createButton =
            ({void Function() onPressed, Widget child}) => ListTile(
                  onTap: onPressed,
                  title: child,
                );

        var streamInput = StreamController<Rational>();
        var textEditingController =
            TextEditingController(text: result.toDecimalString());

        streamInput.stream.listen((event) {
          textEditingController.value =
              TextEditingValue(text: event.toDecimalString());
          result = event;
        });

        var numberFieldStream = TextFormField(
          controller: textEditingController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            RegExInputFormatter.decimalNumbers()
          ],
          onChanged: (String value) => result = Rational.parse(value),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.highlightColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: theme.chipTheme.backgroundColor, width: 1.0),
            ),
            hintText: LocaleKeys.progress.tr(),
          ),
        );
        ;

        var childrenValues = {
          bookmark.progressIncrement,
          Rational.fromInt(1),
          Rational.fromInt(1, 2)
        }.map<Widget>((e) => createButton(
            child: Text('+${e.toDecimalString()}'),
            onPressed: () {
              streamInput.add(result + e);
            }));

        return Column(
          children: [
            Column(children: childrenValues.toList()),
            Padding(
              padding: EdgeInsets.all(16),
              child: numberFieldStream,
            ),
            Column(
              children: [
                createButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text('Cancel'),
                ),
                createButton(
                  onPressed: () => Navigator.pop(context, result),
                  child: Text('Save'),
                ),
              ],
            ),
            createButton(
              child: Text('Show details'),
              onPressed: () async => await context.navigate<void>(
                  (context) => ViewBookmark(bookmarkKey: bookmark.key)),
            )
          ],
        );
      });
}
