import 'package:json_annotation/json_annotation.dart';
import 'package:markmyprogress/misc/rational.dart';
import 'package:rational/rational.dart';

/// <summary>
///     Progress update interface
/// </summary>
abstract class Progress {
  /// <summary>
  ///     Date of the progress update
  /// </summary>
  @JsonKey(required: true)
  DateTime get date;

  /// <summary>
  ///     Progress value
  /// </summary>
  @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
  Rational get value;
}
