import 'package:MarkMyProgress/constants/Patterns.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/extensions/StringExtensions.dart';
import 'package:MarkMyProgress/extensions/UserBookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/bookmark/abstract/IPersistentBookmark.dart';
import '../input/RegExInputFormatter.dart';

class EditRecord extends StatefulWidget {
  final IPersistentBookmark bookmark;

  EditRecord({@required this.bookmark});

  @override
  State<StatefulWidget> createState() {
    return _EditRecordState(bookmark: bookmark);
  }
}

class _EditRecordState extends State<EditRecord> {
  final IPersistentBookmark bookmark;

  final _formKey = GlobalKey<FormState>();
  final _originalTitleKey = GlobalKey<FormFieldState<String>>();
  final _localizedTitleKey = GlobalKey<FormFieldState<String>>();

  final _progressKey = GlobalKey<FormFieldState<String>>();

  bool maxProgressHasChanged = false;

  _EditRecordState({@required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            bookmark.title.isNullOrEmpty ? 'New bookmark' : bookmark.title),
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
                  decoration: InputDecoration(labelText: 'Original title'),
                  validator: (value) {
                    if (value.isEmpty &&
                        _localizedTitleKey.currentState.value.isEmpty) {
                      return 'Either original or localized title must be entered.';
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
                  decoration: InputDecoration(labelText: 'Localized title'),
                  validator: (value) {
                    if (value.isEmpty &&
                        _originalTitleKey.currentState.value.isEmpty) {
                      return 'Either original or localized title must be entered.';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    bookmark.localizedTitle = value;
                  },
                ),
                if (bookmark is IWebBookmark)
                  TextFormField(
                    initialValue: (bookmark as IWebBookmark).webAddress,
                    decoration: InputDecoration(labelText: 'Web Address'),
                    validator: (value) {
                      if (value.isNullOrEmpty) return null;

                      var hasMatch = RegExp(URL_PATTERN).hasMatch(value);

                      if (!hasMatch) {
                        return 'Invalid web address';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      (bookmark as IWebBookmark).webAddress = value;
                    },
                  ),
                TextFormField(
                  key: _progressKey,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    RegExInputFormatter.decimalNumbers()
                  ],
                  initialValue: bookmark.progress.toString(),
                  decoration: InputDecoration(labelText: 'Current progress'),
                  onSaved: (String value) {
                    bookmark.logProgress(double.parse(value));
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    RegExInputFormatter.decimalNumbers()
                  ],
                  initialValue: bookmark.maxProgress.toString(),
                  decoration: InputDecoration(labelText: 'Max progress'),
                  onChanged: (String value) => maxProgressHasChanged = true,
                  validator: (value) {
                    if (maxProgressHasChanged &&
                        double.parse(_progressKey.currentState.value) >
                            double.parse(value)) {
                      return 'Max progress value is smaller than progress value.';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    var dValue = double.parse(value);
                    if (maxProgressHasChanged) {
                      bookmark.maxProgress = dValue;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    RegExInputFormatter.decimalNumbers()
                  ],
                  initialValue: bookmark.progressIncrement.toString(),
                  decoration:
                      InputDecoration(labelText: 'Quick increment value'),
                  onSaved: (String value) {
                    bookmark.progressIncrement = double.parse(value);
                  },
                ),
                SwitchListTile(
                  title: Text('Ongoing'),
                  value: bookmark.ongoing,
                  onChanged: (value) =>
                      setState(() => bookmark.ongoing = value),
                ),
                SwitchListTile(
                  title: Text('Abandoned'),
                  value: bookmark.abandoned,
                  onChanged: (value) =>
                      setState(() => bookmark.abandoned = value),
                )
              ],
            ),
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            Navigator.pop(context, bookmark);
          }
        },
        tooltip: 'Save',
        child: Icon(Icons.save),
      ),
    );
  }
}
