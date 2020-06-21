import 'package:myprogress/data/bookmark/abstract/bookmark.dart';
import 'package:myprogress/data/bookmark/abstract/progress.dart';
import 'package:myprogress/data/bookmark/instance/no_progress.dart';
import 'package:rational/rational.dart';

/// <summary>
///     Latest progress data.
/// </summary>
extension BookmarkExtensions on Bookmark {
  /// <summary>
  ///     Latest progress data.
  /// </summary>
  set progress(Rational value) => logProgress(value);

  Rational get progress => lastProgress?.value ?? Rational.fromInt(0);

  Progress get lastProgress => history.isNotEmpty ? history.last : NoProgress();
}
