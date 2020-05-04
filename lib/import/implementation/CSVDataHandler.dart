import 'dart:convert';
import 'dart:io';

import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/instance/GenericBookmark.dart';
import 'package:MarkMyProgress/import/abstract/IDataExporter.dart';
import 'package:MarkMyProgress/import/abstract/IDataImporter.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:path/path.dart';

/// <summary>
///     JSON data handler providing JSON import and export for IBookmark.
/// </summary>
class JSONDataHandler implements IDataExporter, IDataImporter {
  @override
  Iterable<String> get exportExtensions => ['csv', 'tsv'];

  @override
  Iterable<String> get importExtensions => ['csv', 'tsv'];

  String _getDelimiter(File file) {
    var ext = extension(file.path).substring(1);

    String delimiter;
    switch (ext) {
      case 'csv':
        return ',';
      case 'tsv':
        return '\t';
    }

    throw StateError('extension $ext not supported.');
  }

  @override
  Future export(Iterable<IPersistentBookmark> bookmarks, File file) async {
    var csvData = bookmarks.map((e) => e.toJson().values.toList()).toList();
    var csv =
        const ListToCsvConverter().convert(csvData, fieldDelimiter: _getDelimiter(file));
    await file.writeAsString(csv);
  }

  @override
  Future<Iterable<IPersistentBookmark>> import(File file) async {
    var csv = await file.readAsString();
    try {
      throw UnimplementedError('CSV import is not yet implemented');
    } catch (exception) {
      print(exception);
      return Iterable.empty();
    }
  }
}
