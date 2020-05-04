import 'package:json_annotation/json_annotation.dart';

part 'FilterData.g.dart';

@JsonSerializable()
class FilterData {
  bool abandoned = false;
  bool ongoing = true;
  bool finished = false;
  bool ended = true;

  FilterData();

  factory FilterData.fromJson(Map<String, dynamic> json) =>
      _$FilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataToJson(this);
}

