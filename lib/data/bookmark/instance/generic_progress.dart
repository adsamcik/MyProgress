import 'dart:core';

import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/misc/rational.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rational/rational.dart';

part 'generic_progress.freezed.dart';
part 'generic_progress.g.dart';

/// <summary>
///     Generic implementation of progress.
///     Should represent most use cases.
/// </summary>
@freezed
abstract class GenericProgress with _$GenericProgress implements Progress {
  factory GenericProgress(
    @JsonKey(required: true) DateTime date,
    @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
        Rational value,
  ) = _GenericProgress;

  factory GenericProgress.fromJson(Map<String, dynamic> json) =>
      _$GenericProgressFromJson(json);
}
