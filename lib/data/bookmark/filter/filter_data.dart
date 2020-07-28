import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_data.freezed.dart';
part 'filter_data.g.dart';

@freezed
abstract class FilterData with _$FilterData {
  factory FilterData({
    @Default(false) bool abandoned,
    @Default(true) bool ongoing,
    @Default(false) bool finished,
    @Default(true) bool ended,
    @Default(true) bool maxProgress,
    @Default(true) bool noProgress,
  }) = _FilterData;

  factory FilterData.fromJson(Map<String, dynamic> json) => _$FilterDataFromJson(json);
}
