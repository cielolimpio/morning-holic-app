// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_image_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryImageRequest _$DiaryImageRequestFromJson(Map<String, dynamic> json) =>
    DiaryImageRequest(
      originalS3Path: json['originalS3Path'] as String,
      thumbnailS3Path: json['thumbnailS3Path'] as String,
      diaryImageType:
          $enumDecode(_$DiaryImageTypeEnumEnumMap, json['diaryImageType']),
      datetime: DateTime.parse(json['datetime'] as String),
      timezone: json['timezone'] as String,
      timezoneOffset: json['timezoneOffset'] as int,
      minusScore: json['minusScore'] as int,
    );

Map<String, dynamic> _$DiaryImageRequestToJson(DiaryImageRequest instance) =>
    <String, dynamic>{
      'originalS3Path': instance.originalS3Path,
      'thumbnailS3Path': instance.thumbnailS3Path,
      'diaryImageType': _$DiaryImageTypeEnumEnumMap[instance.diaryImageType]!,
      'datetime': instance.datetime.toIso8601String(),
      'timezone': instance.timezone,
      'timezoneOffset': instance.timezoneOffset,
      'minusScore': instance.minusScore,
    };

const _$DiaryImageTypeEnumEnumMap = {
  DiaryImageTypeEnum.WAKE_UP: 'WAKE_UP',
  DiaryImageTypeEnum.ROUTINE_START: 'ROUTINE_START',
  DiaryImageTypeEnum.ROUTINE_END: 'ROUTINE_END',
  DiaryImageTypeEnum.ROUTINE: 'ROUTINE',
};
