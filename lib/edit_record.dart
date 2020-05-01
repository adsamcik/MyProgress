import 'package:MarkMyProgress/data/instance/GenericBookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MarkMyProgress/data/extension/UserBookmark.dart';
import 'package:MarkMyProgress/data/extension/StringExtensions.dart';

import 'data/input/RegExInputFormatter.dart';

class EditRecord extends StatefulWidget {
  final GenericBookmark bookmark;

  EditRecord({@required this.bookmark});

  @override
  State<StatefulWidget> createState() {
    return _EditRecordState(bookmark: bookmark);
  }
}

class _EditRecordState extends State<EditRecord> {
  final GenericBookmark bookmark;

  final _formKey = GlobalKey<FormState>();
  final _originalTitleKey = GlobalKey<FormFieldState<String>>();
  final _localizedTitleKey = GlobalKey<FormFieldState<String>>();

  _EditRecordState({@required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmark.title.isNullOrEmpty ? 'New bookmark' : bookmark.title),
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
                    if (value.isEmpty && _localizedTitleKey.currentState.value.isEmpty) {
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
                    if (value.isEmpty && _originalTitleKey.currentState.value.isEmpty) {
                      return 'Either original or localized title must be entered.';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    bookmark.localizedTitle = value;
                  },
                ),
                TextFormField(
                  initialValue: bookmark.webAddress,
                  decoration: InputDecoration(labelText: 'Web Address'),
                  onSaved: (String value) {
                    bookmark.webAddress = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
                  initialValue: bookmark.progress.toString(),
                  decoration: InputDecoration(labelText: 'Current progress'),
                  onSaved: (String value) {
                    bookmark.logProgress(double.parse(value));
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
                  initialValue: bookmark.maxProgress.toString(),
                  decoration: InputDecoration(labelText: 'Max progress'),
                  onSaved: (String value) {
                    bookmark.maxProgress = double.parse(value);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[RegExInputFormatter.decimalNumbers()],
                  initialValue: bookmark.progressIncrement.toString(),
                  decoration: InputDecoration(labelText: 'Quick increment value'),
                  onSaved: (String value) {
                    bookmark.progressIncrement = double.parse(value);
                  },
                ),
                SwitchListTile(
                  title: Text('Ongoing'),
                  value: bookmark.ongoing,
                  onChanged: (value) => setState(() => bookmark.ongoing = value),
                ),
                SwitchListTile(
                  title: Text('Abandoned'),
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
            Navigator.pop(context, bookmark);
          }
        },
        tooltip: 'Save',
        child: Icon(Icons.save),
      ),
    );
  }
}
