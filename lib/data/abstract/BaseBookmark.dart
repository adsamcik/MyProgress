import 'package:json_annotation/json_annotation.dart';
import 'IProgress.dart';
import 'IPersistentBookmark.dart';
import 'dart:math';

/// <summary>
///     Base readable implementation providing utility methods for UI.
/// </summary>
@JsonSerializable()
abstract class BaseBookmark implements IPersistentBookmark {
  IProgress? LastProgress() => History.last;

  @JsonKey(ignore: true)
  String id;

  @override
  @JsonKey(required: false)
  String? LocalizedTitle;

  @override
  @JsonKey(required: false)
  String? OriginalTitle;

  @override
  @JsonKey(required: false)
  double MaxProgress;

  @override
  @JsonKey(required: false)
  bool Ongoing;

  @override
  @JsonKey(required: false)
  bool Abandoned;

// todo update so that it cannot be change from the outside
  @override
  List<IProgress> History;

  @override
  double ProgressIncrement;

  set progress(double value) => LogProgress(value);

  double get progress => LastProgress()?.value ?? 0.0;

  @override
  void IncrementProgress() {
    LogProgress(Progress + ProgressIncrement);
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
    if (LastProgress()?.date != newProgress.date) {
      History.add(newProgress);
    } else {
      History.last = newProgress;
    }
  }

  IProgress CreateNewProgress(double progress);
}
