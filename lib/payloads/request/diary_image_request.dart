import 'package:json_annotation/json_annotation.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';

part 'diary_image_request.g.dart';

@JsonSerializable()
class DiaryImageRequest {
  final String originalS3Path;
  final String thumbnailS3Path;
  final DiaryImageTypeEnum diaryImageType;
  final DateTime datetime;
  final String timezone;
  final int timezoneOffset;
  final int minusScore;

  DiaryImageRequest({
    required this.originalS3Path,
    required this.thumbnailS3Path,
    required this.diaryImageType,
    required this.datetime,
    required this.timezone,
    required this.timezoneOffset,
    required this.minusScore,
  });

  factory DiaryImageRequest.fromJson(Map<String, dynamic> json) =>
      _$DiaryImageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryImageRequestToJson(this);
}
