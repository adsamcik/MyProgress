import 'dart:io';

import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/import/abstract/data_exporter.dart';
import 'package:MarkMyProgress/import/abstract/data_importer.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart';

/// <summary>
///     JSON data handler providing JSON import and export for IBookmark.
/// </summary>
class JSONDataHandler implements DataExporter, DataImporter {
  @override
  Iterable<String> get exportExtensions => ['csv', 'tsv'];

  @override
  Iterable<String> get importExtensions => ['csv', 'tsv'];

  String _getDelimiter(File file) {
    var ext = extension(file.path).substring(1);

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
    var csv = const ListToCsvConverter()
        .convert(csvData, fieldDelimiter: _getDelimiter(file));
    await file.writeAsString(csv);
  }

  @override
  Future<Iterable<IPersistentBookmark>> import(File file) async {
    //var csv = await file.readAsString();
    try {
      throw UnimplementedError('CSV import is not yet implemented');
    } catch (exception) {
      print(exception);
      return Iterable.empty();
    }
  }
}
