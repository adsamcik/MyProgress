import 'dart:core';

import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_progress.freezed.dart';
part 'generic_progress.g.dart';

/// <summary>
///     Generic implementation of progress.
///     Should represent most use cases.
/// </summary>
@freezed
abstract class GenericProgress with _$GenericProgress implements Progress {
  factory GenericProgress(DateTime date, double value) = _GenericProgress;

  factory GenericProgress.fromJson(Map<String, dynamic> json) =>
      _$GenericProgressFromJson(json);
}
