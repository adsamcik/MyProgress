import 'dart:io';

import 'package:MarkMyProgress/data/bookmark/abstract/IPersistentBookmark.dart';

/// <summary>
///     Interface for data importing
/// </summary>
abstract class IDataImporter {
  /// <summary>
  ///     Array of import extensions.
  /// </summary>
  Iterable<String> get importExtensions;

  /// <summary>
  ///     Converts file from given format to new format.
  /// </summary>
  /// <param name="file">File</param>
  /// <returns>List of imported bookmarks</returns>
  Future<Iterable<IPersistentBookmark>> import(File file);
}
