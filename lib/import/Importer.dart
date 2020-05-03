import 'dart:io';
import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:path/path.dart';

import 'package:MarkMyProgress/import/abstract/IDataImporter.dart';
import 'package:MarkMyProgress/import/implementation/JSONDataHandler.dart';
import 'package:file_chooser/file_chooser.dart';

class Importer {
  static Future<bool> import() async {
    var _importers = [JSONDataHandler()];
    var fileTypes = _importers
        .expand((e) => e.importExtensions)
        .map((e) => FileTypeFilterGroup(
            label: e.toUpperCase(), fileExtensions: [e.toLowerCase()]))
        .toList();

    var result = await showOpenPanel(
        allowedFileTypes: fileTypes,
        allowsMultipleSelection: false,
        confirmButtonText: 'Import',
        canSelectDirectories: false);

    if (!result.canceled && result.paths.isNotEmpty) {
      var dataStore = DataStore();
      dataStore.open();
      await Future.forEach(result.paths, (String path) async {
        var ext = extension(path);

        if (ext.isEmpty) return;

        ext = ext.substring(1);
        var importer = _importers
            .firstWhere((importer) => importer.importExtensions.contains(ext));
        if (importer != null) {
          var data = await importer.import(File(path));
          await dataStore.insertAll(data);
        } else {
          // todo report error
        }
      });
      dataStore.close();
      return true;
    } else {
      return false;
    }
  }
}
