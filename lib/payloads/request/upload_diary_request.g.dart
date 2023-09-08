// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_diary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDiaryRequest _$UploadDiaryRequestFromJson(Map<String, dynamic> json) =>
    UploadDiaryRequest(
      diaryType: $enumDecode(_$DiaryTypeEnumEnumMap, json['diaryType']),
      diaryImages: (json['diaryImages'] as List<dynamic>)
          .map((e) => DiaryImageRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      diaryContent: json['diaryContent'] as String,
    );

Map<String, dynamic> _$UploadDiaryRequestToJson(UploadDiaryRequest instance) =>
    <String, dynamic>{
      'diaryType': _$DiaryTypeEnumEnumMap[instance.diaryType]!,
      'diaryImages': instance.diaryImages,
      'diaryContent': instance.diaryContent,
    };

const _$DiaryTypeEnumEnumMap = {
  DiaryTypeEnum.INDOOR: 'INDOOR',
  DiaryTypeEnum.OUTDOOR: 'OUTDOOR',
};
