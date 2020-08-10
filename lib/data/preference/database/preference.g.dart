// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return Preference(
    json['key'] as String,
    json['value'],
  );
}

Map<String, dynamic> _$PreferenceToJson(Preference instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
