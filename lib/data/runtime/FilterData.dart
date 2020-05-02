import 'package:json_annotation/json_annotation.dart';
import 'package:sembast/sembast.dart';

part 'FilterData.g.dart';

@JsonSerializable()
class FilterData {
  String query = '';
  bool reading = true;
  bool abandoned = false;
  bool ongoing = false;
  bool ended = false;
  bool finished = false;

  FilterData();

  factory FilterData.fromJson(Map<String, dynamic> json) => _$FilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataToJson(this);
}
