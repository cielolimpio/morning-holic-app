import 'package:json_annotation/json_annotation.dart';
import 'package:morning_holic_app/enums/ModeEnum.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final DateTime targetWakeUpTime;
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
