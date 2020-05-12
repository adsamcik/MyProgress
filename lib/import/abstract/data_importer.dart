import 'dart:io';

import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';

/// <summary>
///     Interface for data importing
/// </summary>
abstract class DataImporter {
  /// <summary>
  ///     Array of import extensions.
  /// </summary>
  Iterable<String> get importExtensions;

  /// <summary>
  ///     Converts file from given format to new format.
  /// </summary>
  /// <param name="file">File</param>
  /// <returns>List of imported bookmarks</returns>
  Future<Iterable<PersistentBookmark>> import(File file);
}
