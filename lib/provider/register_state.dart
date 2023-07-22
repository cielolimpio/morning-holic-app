import 'package:flutter/material.dart';
import 'package:morning_holic_app/enums/ModeEnum.dart';

import '../enums/BankEnum.dart';

class RegisterState extends ChangeNotifier{
  String? targetWakeUpTime;
  BankEnum? refundBankName;
  ModeEnum? mode;

  void updateWakeupTime(String newValue) {
    targetWakeUpTime = newValue;
    notifyListeners(); // 구독자들에게 변경사항 알림
  }

  void updateRefundBankName(BankEnum bankName){
    refundBankName = bankName;
    notifyListeners();
  }

  void updateMode(ModeEnum newValue){
    mode = newValue;
    notifyListeners();
  }
}