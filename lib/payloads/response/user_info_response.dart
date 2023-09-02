import 'package:json_annotation/json_annotation.dart';
import 'package:morning_holic_app/dtos/target_wake_up_time_model.dart';
import 'package:morning_holic_app/enums/BankEnum.dart';
import 'package:morning_holic_app/enums/ModeEnum.dart';
import 'package:morning_holic_app/enums/UserStatusEnum.dart';

part 'user_info_response.g.dart';

@JsonSerializable()
class UserInfoResponse {
  final int userId;
  final String name;
  final String phoneNumber;
  final String nickname;
  final TargetWakeUpTimeModel? targetWakeUpTime;
  final BankEnum? refundBankName;
  final String? refundAccount;
  final ModeEnum? mode;
  final UserStatusEnum status;

  UserInfoResponse({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.nickname,
    required this.targetWakeUpTime,
    required this.refundBankName,
    required this.refundAccount,
    required this.mode,
    required this.status,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
