import 'dart:convert';
import 'dart:io';

import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/bookmark/instance/GenericBookmark.dart';
import 'package:MarkMyProgress/import/abstract/data_exporter.dart';
import 'package:MarkMyProgress/import/abstract/data_importer.dart';

/// <summary>
///     JSON data handler providing JSON import and export for IBookmark.
/// </summary>
class JSONDataHandler implements DataExporter, DataImporter {
  @override
  Iterable<String> get exportExtensions => ['json'];

  @override
  Iterable<String> get importExtensions => ['json'];

  @override
  Future export(Iterable<IPersistentBookmark> bookmarks, File file) async {
    var json = jsonEncode(bookmarks.map((e) => e.toJson()).toList());
    await file.writeAsString(json);
  }

  @override
  Future<Iterable<IPersistentBookmark>> import(File file) async {
    var json = await file.readAsString();
    try {
      return (jsonDecode(json) as List)
          .cast<Map<String, dynamic>>()
          .map((e) => GenericBookmark.fromJson(e));
    } catch (exception) {
      print(exception);
      return Iterable.empty();
    }
  }
}
