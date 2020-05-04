import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

import '../../extensions/StringExtensions.dart';
import '../../extensions/UserBookmark.dart';
import 'IPersistentBookmark.dart';
import 'IProgress.dart';

/// <summary>
///     Base readable implementation providing utility methods for UI.
/// </summary>
abstract class BaseBookmark implements IPersistentBookmark {
  @override
  @JsonKey(ignore: true)
  int id;

  @override
  @JsonKey(required: false)
  String localizedTitle;

  @override
  @JsonKey(required: false)
  String originalTitle;

  @override
  String get title {
    if (localizedTitle.isNotNullOrEmpty) {
      return localizedTitle;
    } else if (originalTitle.isNotNullOrEmpty) {
      return originalTitle;
    } else {
      return '';
    }
  }

  @override
  @JsonKey(required: false)
  double maxProgress = 0.0;

  @override
  @JsonKey(required: false)
  bool ongoing = false;

  @override
  @JsonKey(required: false)
  bool abandoned = false;

  @override
  @JsonKey(required: false)
  double progressIncrement = 1.0;

  @override
  void incrementProgress() {
    logProgress(progress + progressIncrement);
  }

  @override
  void logProgress(double progress) {
    if (!ongoing && maxProgress > 0) {
      progress = min(maxProgress, progress);
    }

    if (ongoing) {
      maxProgress = max(progress, maxProgress);
    }

    var newProgress = createNewProgress(progress);
    if (lastProgress?.date != newProgress.date) {
      history.add(newProgress);
    } else {
      history.last = newProgress;
    }
  }

  IProgress createNewProgress(double progress);
}
