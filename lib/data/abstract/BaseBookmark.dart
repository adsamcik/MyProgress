import 'package:json_annotation/json_annotation.dart';
import 'IProgress.dart';
import 'IPersistentBookmark.dart';
import 'dart:math';

/// <summary>
///     Base readable implementation providing utility methods for UI.
/// </summary>
abstract class BaseBookmark implements IPersistentBookmark {
  IProgress get LastProgress => history.isNotEmpty ? history.last : null;

  @override
  @JsonKey(ignore: true)
  int id;

  @override
  @JsonKey(required: false)
  String LocalizedTitle;

  @override
  @JsonKey(required: false)
  String OriginalTitle;

  @override
  String get Title => LocalizedTitle ?? OriginalTitle ?? '';

  @override
  @JsonKey(required: false)
  double MaxProgress;

  @override
  @JsonKey(required: false)
  bool Ongoing;

  @override
  @JsonKey(required: false)
  bool Abandoned;

  @override
  double ProgressIncrement;

  @override
  set progress(double value) => LogProgress(value);

  @override
  double get progress => LastProgress?.value ?? 0.0;

  @override
  void IncrementProgress() {
    LogProgress(progress + ProgressIncrement);
  }

  @override
  void LogProgress(double progress) {
    if (!Ongoing && MaxProgress > 0) {
      progress = min(MaxProgress, progress);
    }

    if (Ongoing) {
      MaxProgress = max(progress, MaxProgress);
    }

    var newProgress = CreateNewProgress(progress);
    if (LastProgress?.date != newProgress.date) {
      history.add(newProgress);
    } else {
      history.last = newProgress;
    }
  }

  IProgress CreateNewProgress(double progress);
}
