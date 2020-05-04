// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FilterData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterData _$FilterDataFromJson(Map<String, dynamic> json) {
  return FilterData()
    ..abandoned = json['abandoned'] as bool
    ..ongoing = json['ongoing'] as bool
    ..finished = json['finished'] as bool
    ..ended = json['ended'] as bool;
}

Map<String, dynamic> _$FilterDataToJson(FilterData instance) =>
    <String, dynamic>{
      'abandoned': instance.abandoned,
      'ongoing': instance.ongoing,
      'finished': instance.finished,
      'ended': instance.ended,
    };
