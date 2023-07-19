import 'package:flutter/material.dart';

class RegisterState extends ChangeNotifier{
  String? targetWakeupTime;
  String? refundBankName;
  String? mode;

  void updateWakeupTime(String newValue){
    targetWakeupTime = newValue;
    notifyListeners(); // 구독자들에게 변경사항 알림
  }

  void updateRefundBankName(String bankName){
    refundBankName = bankName;
    notifyListeners();
  }

  void updateMode(String newValue){
    mode = newValue;
    notifyListeners();
  }
}