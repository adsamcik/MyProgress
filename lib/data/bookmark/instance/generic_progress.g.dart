// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenericProgress _$_$_GenericProgressFromJson(Map<String, dynamic> json) {
  return _$_GenericProgress(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['value'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_GenericProgressToJson(_$_GenericProgress instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'value': instance.value,
    };
