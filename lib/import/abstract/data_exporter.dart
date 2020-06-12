import 'dart:io';

import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';

/// <summary>
///     Interface for data exporting.
/// </summary>
abstract class DataExporter {
  /// <summary>
  ///     Array of all supported extensions
  /// </summary>
  Iterable<String> get exportExtensions;

  /// <summary>
  ///     Exports data from bookmarks to a file.
  /// </summary>
  /// <param name="bookmarks"></param>
  /// <param name="file"></param>
  Future export(Iterable<PersistentBookmark> bookmarks, File file);
}
