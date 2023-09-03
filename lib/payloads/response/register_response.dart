import 'package:json_annotation/json_annotation.dart';
import 'package:morning_holic_app/dtos/target_wake_up_time_model.dart';
import 'package:morning_holic_app/enums/mode_enum.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final TargetWakeUpTimeModel targetWakeUpTime;
  final String refundBankNameAndAccount;
  final ModeEnum mode;

  RegisterResponse({
    required this.targetWakeUpTime,
    required this.refundBankNameAndAccount,
    required this.mode,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
