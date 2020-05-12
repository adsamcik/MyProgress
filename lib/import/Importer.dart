import 'dart:io';

import 'package:MarkMyProgress/data/bookmark/database/DataStore.dart';
import 'package:MarkMyProgress/import/implementation/JSONDataHandler.dart';
import 'package:file_chooser/file_chooser.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

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
      var dataStore = GetIt.instance.get<DataStore>();
      await dataStore.open();
      await Future.forEach(result.paths, (String path) async {
        var ext = extension(path);

        if (ext.isEmpty) return;

        ext = ext.substring(1);
        var importer = _importers
            .firstWhere((importer) => importer.importExtensions.contains(ext));
        if (importer != null) {
          var data = await importer.import(File(path));
          await await dataStore.transaction((storage) async => await data
              .map((element) async => await storage.insertAuto(element)));
        } else {
          // todo report error
        }
      });
      await dataStore.close();
      return true;
    } else {
      return false;
    }
  }
}
