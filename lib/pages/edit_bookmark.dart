import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:markmyprogress/constants/patterns.dart';
import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:markmyprogress/data/bookmark/abstract/web_bookmark.dart';
import 'package:markmyprogress/data/bookmark/bloc/bloc.dart';
import 'package:markmyprogress/extensions/bookmark.dart';
import 'package:markmyprogress/extensions/string.dart';
import 'package:markmyprogress/generated/locale_keys.g.dart';
import 'package:markmyprogress/input/reg_ex_input_formatter.dart';
import 'package:rational/rational.dart';

class EditBookmark extends StatefulWidget {
  final PersistentBookmark bookmark;

  EditBookmark({@required this.bookmark});

  @override
  State<StatefulWidget> createState() {
    return _EditBookmarkState(bookmark: bookmark);
  }
}

class _EditBookmarkState extends State<EditBookmark> {
  final PersistentBookmark bookmark;

  final _formKey = GlobalKey<FormState>();
  final _originalTitleKey = GlobalKey<FormFieldState<String>>();
  final _localizedTitleKey = GlobalKey<FormFieldState<String>>();

  final _progressKey = GlobalKey<FormFieldState<String>>();

  bool maxProgressHasChanged = false;

  _EditBookmarkState({@required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmark.title.isNullOrEmpty ? LocaleKeys.new_bookmark.tr() : bookmark.title),
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(16.0),
          maintainBottomViewPadding: true,
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: _originalTitleKey,
                  initialValue: bookmark.originalTitle,
                  decoration: InputDecoration(labelText: LocaleKeys.original_title.tr()),
                  validator: (value) {
                    if (value.isEmpty && _localizedTitleKey.currentState.value.isEmpty) {
                      return LocaleKeys.edit_error_all_titles_empty.tr();
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    bookmark.originalTitle = value;
                  },
                ),
                TextFormField(
                  key: _localizedTitleKey,
                  initialValue: bookmark.localizedTitle,
                  decoration: InputDecoration(labelText: LocaleKeys.localized_title.tr()),
                  validator: (value) {
                    if (value.isEmpty && _originalTitleKey.currentState.value.isEmpty) {
                      return LocaleKeys.edit_error_all_titles_empty.tr();
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    bookmark.localizedTitle = value;
                  },
                ),
                if (bookmark is WebBookmark)
                  TextFormField(
                    initialValue: (bookmark as WebBookmark).webAddress,
                    decoration: InputDecoration(labelText: LocaleKeys.web.tr()),
                    validator: (value) {
                      if (value.isNullOrEmpty) return null;

                      var hasMatch = RegExp(URL_PATTERN).hasMatch(value);

                      if (!hasMatch) {
                        return LocaleKeys.edit_error_invalid_web.tr();
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      (bookmark as WebBookmark).webAddress = value;
                    },
                  ),
                TextFormField(
                  key: _progressKey,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
                  initialValue: bookmark.progress.toDecimalString(),
                  decoration: InputDecoration(labelText: LocaleKeys.current_progress.tr()),
                  onSaved: (String value) {
                    bookmark.logProgress(Rational.parse(value));
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
                  initialValue: bookmark.maxProgress.toDecimalString(),
                  decoration: InputDecoration(labelText: LocaleKeys.max_progress.tr()),
                  onChanged: (String value) => maxProgressHasChanged = true,
                  validator: (value) {
                    if (maxProgressHasChanged && double.parse(_progressKey.currentState.value) > double.parse(value)) {
                      return LocaleKeys.edit_error_max_progress_less_than_actual.tr();
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    if (maxProgressHasChanged) {
                      bookmark.maxProgress = Rational.parse(value);
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
                  initialValue: bookmark.progressIncrement.toDecimalString(),
                  decoration: InputDecoration(labelText: LocaleKeys.increment_value.tr()),
                  onSaved: (String value) {
                    bookmark.progressIncrement = Rational.parse(value);
                  },
                ),
                SwitchListTile(
                  title: Text(LocaleKeys.filter_ongoing.tr()),
                  value: bookmark.ongoing,
                  onChanged: (value) => setState(() => bookmark.ongoing = value),
                ),
                SwitchListTile(
                  title: Text(LocaleKeys.filter_abandoned.tr()),
                  value: bookmark.abandoned,
                  onChanged: (value) => setState(() => bookmark.abandoned = value),
                )
              ],
            ),
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            GetIt.instance.get<BookmarkBloc>().add(BookmarkBlocEvent.saveBookmark(bookmark: bookmark));
            Navigator.pop(context, bookmark);
          }
        },
        tooltip: LocaleKeys.save.tr(),
        child: Icon(Icons.save),
      ),
    );
  }
}
