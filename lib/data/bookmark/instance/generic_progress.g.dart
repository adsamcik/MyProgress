// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenericProgress _$_$_GenericProgressFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['date', 'value']);
  return _$_GenericProgress(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    rationalFromJson(json['value']),
  );
}

Map<String, dynamic> _$_$_GenericProgressToJson(_$_GenericProgress instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'value': rationalToJson(instance.value),
    };
