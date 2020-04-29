// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenericBookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericBookmark _$GenericBookmarkFromJson(Map<String, dynamic> json) {
  return GenericBookmark()
    ..localizedTitle = json['localizedTitle'] as String
    ..originalTitle = json['originalTitle'] as String
    ..maxProgress = (json['maxProgress'] as num)?.toDouble()
    ..ongoing = json['ongoing'] as bool
    ..abandoned = json['abandoned'] as bool
    ..progressIncrement = (json['progressIncrement'] as num)?.toDouble()
    ..webAddress = json['webAddress'] as String
    ..history_generic = (json['history'] as List)
        ?.map((e) => e == null
            ? null
            : GenericProgress.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GenericBookmarkToJson(GenericBookmark instance) =>
    <String, dynamic>{
      'localizedTitle': instance.localizedTitle,
      'originalTitle': instance.originalTitle,
      'maxProgress': instance.maxProgress,
      'ongoing': instance.ongoing,
      'abandoned': instance.abandoned,
      'progressIncrement': instance.progressIncrement,
      'webAddress': instance.webAddress,
      'history': instance.history_generic,
    };
