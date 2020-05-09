import 'package:freezed_annotation/freezed_annotation.dart';

part 'FilterData.freezed.dart';
part 'FilterData.g.dart';

@freezed
abstract class FilterData with _$FilterData {
  factory FilterData({
    @Default(false) bool abandoned,
    @Default(true) bool ongoing,
    @Default(false) bool finished,
    @Default(true) bool ended,
  }) = _FilterData;

  factory FilterData.fromJson(Map<String, dynamic> json) =>
      _$FilterDataFromJson(json);
}
