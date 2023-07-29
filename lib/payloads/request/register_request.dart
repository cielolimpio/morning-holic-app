import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String refundBankName;
  final String refundAccount;
  final String mode;
  final DateTime targetWakeUpTime;

  RegisterRequest({
    required this.refundBankName,
    required this.refundAccount,
    required this.mode,
    required this.targetWakeUpTime,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
