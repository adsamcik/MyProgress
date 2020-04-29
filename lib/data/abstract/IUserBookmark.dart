import 'IBookmark.dart';
import 'IProgress.dart';

/// <summary>
///     Interface containing methods and properties required by UI.
/// </summary>
abstract class IUserBookmark implements IBookmark {
  /// <summary>
  ///     Progress in a readable way. Default is Progress/MaxProgress.
  /// </summary>
  String formattedProgress;

  /// <summary>
  ///     Increment value in more readable way.
  /// </summary>
  String formattedIncrement;

  /// <summary>
  ///     Returns last progress instance or default value if no progress is logged.
  /// </summary>
  IProgress lastProgress;

  /// <summary>
  ///     Date of the first progress entry.
  /// </summary>
  DateTime startedReading;

  /// <summary>
  ///     Date of last progress change.
  /// </summary>
  DateTime lastProgressDate;
}
