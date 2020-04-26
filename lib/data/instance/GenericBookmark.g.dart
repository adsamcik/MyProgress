// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenericBookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericBookmark _$GenericBookmarkFromJson(Map<String, dynamic> json) {
  return GenericBookmark()
    ..LocalizedTitle = json['LocalizedTitle'] as String
    ..OriginalTitle = json['OriginalTitle'] as String
    ..MaxProgress = (json['MaxProgress'] as num)?.toDouble()
    ..Ongoing = json['Ongoing'] as bool
    ..Abandoned = json['Abandoned'] as bool
    ..ProgressIncrement = (json['ProgressIncrement'] as num)?.toDouble()
    ..progress = (json['progress'] as num)?.toDouble()
    ..WebAddress = json['WebAddress'] as String
    ..history = (json['history'] as List)
        ?.map((e) => e == null
            ? null
            : GenericProgress.fromJson(e as Map<String, dynamic>))?.cast<GenericProgress>()
        ?.toList();
}

Map<String, dynamic> _$GenericBookmarkToJson(GenericBookmark instance) =>
    <String, dynamic>{
      'LocalizedTitle': instance.LocalizedTitle,
      'OriginalTitle': instance.OriginalTitle,
      'MaxProgress': instance.MaxProgress,
      'Ongoing': instance.Ongoing,
      'Abandoned': instance.Abandoned,
      'ProgressIncrement': instance.ProgressIncrement,
      'progress': instance.progress,
      'WebAddress': instance.WebAddress,
      'history': instance.history,
    };
