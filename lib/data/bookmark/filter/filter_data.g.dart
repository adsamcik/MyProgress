// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FilterData _$_$_FilterDataFromJson(Map<String, dynamic> json) {
  return _$_FilterData(
    abandoned: json['abandoned'] as bool ?? false,
    ongoing: json['ongoing'] as bool ?? true,
    finished: json['finished'] as bool ?? false,
    ended: json['ended'] as bool ?? true,
    maxProgress: json['maxProgress'] as bool ?? true,
    noProgress: json['noProgress'] as bool ?? true,
  );
}

Map<String, dynamic> _$_$_FilterDataToJson(_$_FilterData instance) => <String, dynamic>{
      'abandoned': instance.abandoned,
      'ongoing': instance.ongoing,
      'finished': instance.finished,
      'ended': instance.ended,
      'maxProgress': instance.maxProgress,
      'noProgress': instance.noProgress,
    };
