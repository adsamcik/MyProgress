import 'package:MarkMyProgress/data/instance/GenericBookmark.dart';
import 'package:flutter/material.dart';

class EditRecord extends StatelessWidget {
  final GenericBookmark bookmark;

  final _formKey = GlobalKey<FormState>();
  final _originalTitleKey = GlobalKey<FormFieldState<String>>();
  final _localizedTitleKey = GlobalKey<FormFieldState<String>>();

  EditRecord({@required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmark.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: _originalTitleKey,
                initialValue: bookmark.originalTitle,
                decoration: InputDecoration(labelText: 'Original title'),
                validator: (value) {
                  if(value.isEmpty && _localizedTitleKey.currentState.value.isEmpty) {
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
                  if(value.isEmpty && _originalTitleKey.currentState.value.isEmpty) {
                    return 'Either original or localized title must be entered.';
                  }

                  return null;
                },
                onSaved: (String value) {
                  bookmark.localizedTitle = value;
                },
              ),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_formKey.currentState.validate()) {
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
