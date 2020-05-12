import 'dart:core';

import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_progress.g.dart';

/// <summary>
///     Generic implementation of progress.
///     Should represent most use cases.
/// </summary>
@JsonSerializable()
class GenericProgress implements Progress {
  GenericProgress(DateTime date, double value) {
    this.date = date;
    this.value = value;
  }

  @override
  DateTime date;

  @override
  double value;

  factory GenericProgress.fromJson(Map<String, dynamic> json) =>
      _$GenericProgressFromJson(json);

  Map<String, dynamic> toJson() => _$GenericProgressToJson(this);
}
