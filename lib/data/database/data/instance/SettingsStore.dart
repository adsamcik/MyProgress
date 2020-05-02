import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/database/data/abstract/DatabaseCollection.dart';
import 'package:MarkMyProgress/data/database/data/abstract/DatabaseProxy.dart';
import 'package:flutter/cupertino.dart';

class SettingsStore extends DatabaseProxy<String, dynamic> {
  SettingsStore() : super(databasePath: 'settings.db');
}
