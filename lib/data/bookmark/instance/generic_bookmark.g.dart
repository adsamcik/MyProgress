// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericBookmark _$GenericBookmarkFromJson(Map<String, dynamic> json) {
  return GenericBookmark()
    ..localizedTitle = json['localizedTitle'] as String
    ..originalTitle = json['originalTitle'] as String
    ..maxProgress = rationalFromJson(json['maxProgress'] as String)
    ..ongoing = json['ongoing'] as bool
    ..abandoned = json['abandoned'] as bool
    ..webAddress = json['webAddress'] as String
    ..history_generic = (json['history'] as List)
        ?.map((e) => e == null
            ? null
            : GenericProgress.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..progressIncrement = rationalFromJson(json['progressIncrement'] as String);
}

Map<String, dynamic> _$GenericBookmarkToJson(GenericBookmark instance) =>
    <String, dynamic>{
      'localizedTitle': instance.localizedTitle,
      'originalTitle': instance.originalTitle,
      'maxProgress': rationalToJson(instance.maxProgress),
      'ongoing': instance.ongoing,
      'abandoned': instance.abandoned,
      'webAddress': instance.webAddress,
      'history': instance.history_generic?.map((e) => e?.toJson())?.toList(),
      'progressIncrement': rationalToJson(instance.progressIncrement),
    };
