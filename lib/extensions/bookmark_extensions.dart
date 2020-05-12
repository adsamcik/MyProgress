import 'package:MarkMyProgress/data/bookmark/abstract/IBookmark.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/IProgress.dart';
import 'package:MarkMyProgress/data/bookmark/instance/NoProgress.dart';

/// <summary>
///     Latest progress data.
/// </summary>
extension BookmarkExtensions on IBookmark {
  /// <summary>
  ///     Latest progress data.
  /// </summary>
  set progress(double value) => logProgress(value);

  double get progress => lastProgress?.value ?? 0.0;

  IProgress get lastProgress =>
      history.isNotEmpty ? history.last : NoProgress();
}
