// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FilterData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterData _$FilterDataFromJson(Map<String, dynamic> json) {
  return FilterData()
    ..reading = json['reading'] as bool
    ..abandoned = json['abandoned'] as bool
    ..ongoing = json['ongoing'] as bool
    ..ended = json['ended'] as bool
    ..finished = json['finished'] as bool;
}

Map<String, dynamic> _$FilterDataToJson(FilterData instance) =>
    <String, dynamic>{
      'reading': instance.reading,
      'abandoned': instance.abandoned,
      'ongoing': instance.ongoing,
      'ended': instance.ended,
      'finished': instance.finished,
    };
