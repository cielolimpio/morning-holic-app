import 'package:json_annotation/json_annotation.dart';

part 'target_wake_up_time_model.g.dart';

@JsonSerializable()
class TargetWakeUpTimeModel {
  final int hour;
  final int minute;

  TargetWakeUpTimeModel({
    required this.hour,
    required this.minute,
  });

  factory TargetWakeUpTimeModel.fromJson(Map<String, dynamic> json) =>
      _$TargetWakeUpTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TargetWakeUpTimeModelToJson(this);
}
