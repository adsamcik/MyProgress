import 'dart:io';

import 'package:MarkMyProgress/data/database/data/instance/DataStore.dart';
import 'package:MarkMyProgress/import/implementation/JSONDataHandler.dart';
import 'package:file_chooser/file_chooser.dart';
import 'package:path/path.dart';

class Exporter {
  static Future<bool> export() async {
    var _exporters = [JSONDataHandler()];
    var fileTypes = _exporters
        .expand((e) => e.exportExtensions)
        .map((e) => FileTypeFilterGroup(
            label: e.toUpperCase(), fileExtensions: [e.toLowerCase()]))
        .toList();

    var result = await showSavePanel(
        allowedFileTypes: fileTypes,
        confirmButtonText: 'Export',
        suggestedFileName: 'progress_data.${fileTypes.first.fileExtensions.first}');

    if (!result.canceled && result.paths.isNotEmpty) {
      var dataStore = DataStore();
      await dataStore.open();
      var data = await dataStore.getAll();
      await dataStore.close();

      await Future.forEach(result.paths, (String path) async {
        var ext = extension(path);

        // todo add actual selected extension when support for it is added.
        if (ext.isEmpty) return;

        ext = ext.substring(1);
        var exporter = _exporters
            .firstWhere((e) => e.exportExtensions.contains(ext));
        if (exporter != null) {
          await exporter.export(data, File(path));
        } else {
          // todo report error
        }
      });
      return true;
    } else {
      return false;
    }
  }
}
