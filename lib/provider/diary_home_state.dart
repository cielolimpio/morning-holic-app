import 'package:flutter/material.dart';
import 'package:morning_holic_app/enums/DiaryTypeEnum.dart';

class DiaryHomeState extends ChangeNotifier{
  DiaryTypeEnum diaryType = DiaryTypeEnum.INDOOR;
  String? wakeupImage = "c://jpg";
  String? routineStartImage;
  String? routineEndImage;
  String? routineImage;

  void updateDiaryType(DiaryTypeEnum diaryType){
    this.diaryType = diaryType;
    notifyListeners();
  }

  void updateWakeupImage(String? wakeupImage){
    this.wakeupImage = wakeupImage;
    notifyListeners();
  }

  void updateRoutineStartImage(String? routineStartImage){
    this.routineStartImage = routineStartImage;
    notifyListeners();
  }

  void updateRoutineEndImage(String? routineEndImage){
    this.routineEndImage = routineEndImage;
    notifyListeners();
  }

  void updateRoutineImage(String? routineImage){
    this.routineImage = routineImage;
  }


}