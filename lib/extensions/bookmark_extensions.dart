import 'package:MarkMyProgress/data/bookmark/abstract/bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/data/bookmark/instance/no_progress.dart';

/// <summary>
///     Latest progress data.
/// </summary>
extension BookmarkExtensions on Bookmark {
  /// <summary>
  ///     Latest progress data.
  /// </summary>
  set progress(double value) => logProgress(value);

  double get progress => lastProgress?.value ?? 0.0;

  Progress get lastProgress => history.isNotEmpty ? history.last : NoProgress();
}
