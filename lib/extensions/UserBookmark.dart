import 'package:MarkMyProgress/data/abstract/IBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IProgress.dart';
import 'package:MarkMyProgress/data/instance/GenericProgress.dart';

import 'DateExtension.dart';

/// <summary>
///     Latest progress data.
/// </summary>
extension BookmarkUi on IBookmark {
  /// <summary>
  ///     Latest progress data.
  /// </summary>
  set progress(double value) => logProgress(value);

  double get progress => lastProgress?.value ?? 0.0;

  IProgress get lastProgress =>
      history.isNotEmpty ? history.last : GenericProgress(Date.invalid(), 0.0);
}
