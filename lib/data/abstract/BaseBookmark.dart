import 'package:json_annotation/json_annotation.dart';
import 'IProgress.dart';
import 'IPersistentBookmark.dart';
import 'dart:math';
import '../extension/UserBookmark.dart';

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
  String get title => localizedTitle ?? originalTitle ?? '';

  @override
  @JsonKey(required: false)
  double maxProgress;

  @override
  @JsonKey(required: false)
  bool ongoing;

  @override
  @JsonKey(required: false)
  bool abandoned;

  @override
  double progressIncrement;

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
