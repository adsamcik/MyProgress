// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenericProgress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericProgress _$GenericProgressFromJson(Map<String, dynamic> json) {
  return GenericProgress(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['value'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GenericProgressToJson(GenericProgress instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'value': instance.value,
    };

// **************************************************************************
// ToStringGenerator
// **************************************************************************

String _$GenericProgressToString(GenericProgress o) {
  return """GenericProgress{date: ${o.date}, value: ${o.value}}""";
}
