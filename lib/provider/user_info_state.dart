import 'package:flutter/material.dart';
import 'package:morning_holic_app/dtos/target_wake_up_time_model.dart';
import 'package:morning_holic_app/enums/bank_enum.dart';
import 'package:morning_holic_app/enums/mode_enum.dart';
import 'package:morning_holic_app/enums/user_status_enum.dart';

class UserInfoState extends ChangeNotifier {
  int? userId;
  String? name;
  String? phoneNumber;
  String? profileEmoji;
  String? nickname;
  TargetWakeUpTimeModel? targetWakeUpTime;
  BankEnum? refundBankName;
  String? refundAccount;
  ModeEnum? mode;
  UserStatusEnum? status;
  String? rejectReason;

  void updateUserInfo({
    required int userId,
    required String name,
    required String phoneNumber,
    required String profileEmoji,
    required String nickname,
    required TargetWakeUpTimeModel? targetWakeUpTime,
    required BankEnum? refundBankName,
    required String? refundAccount,
    required ModeEnum? mode,
    required UserStatusEnum? status,
    required String? rejectReason,
  }) {
    this.userId = userId;
    this.name = name;
    this.phoneNumber = phoneNumber;
    this.profileEmoji = profileEmoji;
    this.nickname = nickname;
    this.targetWakeUpTime = targetWakeUpTime;
    this.refundBankName = refundBankName;
    this.refundAccount = refundAccount;
    this.mode = mode;
    this.status = status;
    this.rejectReason = rejectReason;
  }
}
