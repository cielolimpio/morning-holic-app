import 'package:json_annotation/json_annotation.dart';
import 'package:morning_holic_app/enums/diary_type_enum.dart';
import 'package:morning_holic_app/payloads/request/diary_image_request.dart';

part 'upload_diary_request.g.dart';

@JsonSerializable()
class UploadDiaryRequest {
  final DiaryTypeEnum diaryType;
  final List<DiaryImageRequest> diaryImages;
  final String diaryContent;

  UploadDiaryRequest({
    required this.diaryType,
    required this.diaryImages,
    required this.diaryContent,
  });

  factory UploadDiaryRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadDiaryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UploadDiaryRequestToJson(this);
}