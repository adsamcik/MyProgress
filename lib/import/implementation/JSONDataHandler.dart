import 'dart:convert';
import 'dart:io';

import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/instance/GenericBookmark.dart';
import 'package:MarkMyProgress/import/abstract/IDataExporter.dart';
import 'package:MarkMyProgress/import/abstract/IDataImporter.dart';

/// <summary>
///     JSON data handler providing JSON import and export for IBookmark.
/// </summary>
class JSONDataHandler implements IDataExporter, IDataImporter {
  @override
  Iterable<String> get exportExtensions => ['json'];

  @override
  Iterable<String> get importExtensions => ['json'];

  @override
  Future export(Iterable<IPersistentBookmark> bookmarks, File file) async {
    var json = jsonEncode(bookmarks);
    await file.writeAsString(json);
  }

  @override
  Future<Iterable<IPersistentBookmark>> import(File file) async {
    var json = await file.readAsString();
    try {
      return (jsonDecode(json) as List).cast<Map<String, dynamic>>().map((e) => GenericBookmark.fromJson(e));
    } catch (exception) {
      print(exception);
      return Iterable.empty();
    }
  }
}
