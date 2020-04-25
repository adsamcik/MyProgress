import 'IBookmark.dart';
import 'IProgress.dart';

/// <summary>
///     Interface containing methods and properties required by UI.
/// </summary>
abstract class IUserBookmark implements IBookmark {
  /// <summary>
  ///     Title of the reading material either localized or original.
  /// </summary>
  String Title;

  /// <summary>
  ///     Progress in a readable way. Default is Progress/MaxProgress.
  /// </summary>
  String FormattedProgress;

  /// <summary>
  ///     Increment value in more readable way.
  /// </summary>
  String FormattedIncrement;

  /// <summary>
  ///     Returns last progress instance or default value if no progress is logged.
  /// </summary>
  IProgress? LastProgress;

  /// <summary>
  ///     Date of the first progress entry.
  /// </summary>
  DateTime StartedReading;

  /// <summary>
  ///     Date of last progress change.
  /// </summary>
  DateTime LastProgressDate;
}
