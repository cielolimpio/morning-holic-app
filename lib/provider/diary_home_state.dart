import 'package:flutter/material.dart';
import 'package:morning_holic_app/dtos/diary_image_model.dart';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';
import 'package:morning_holic_app/enums/diary_type_enum.dart';

class DiaryHomeState extends ChangeNotifier {
  DiaryTypeEnum diaryType = DiaryTypeEnum.INDOOR;
  DiaryImageTypeEnum currentDiaryImageType = DiaryImageTypeEnum.WAKE_UP;
  Picture? wakeUpImage;
  Picture? routineStartImage;
  Picture? routineEndImage;
  Picture? routineImage;

  void updateDiaryType(DiaryTypeEnum diaryType) {
    this.diaryType = diaryType;
    notifyListeners();
  }

  void updateDiaryImageType(DiaryImageTypeEnum diaryImageType) {
    currentDiaryImageType = diaryImageType;
    notifyListeners();
  }

  void updateWakeupImage(Picture? wakeupImage) {
    wakeUpImage = wakeupImage;
    notifyListeners();
  }

  void updateRoutineStartImage(Picture? routineStartImage) {
    this.routineStartImage = routineStartImage;
    notifyListeners();
  }

  void updateRoutineEndImage(Picture? routineEndImage) {
    this.routineEndImage = routineEndImage;
    notifyListeners();
  }

  void updateRoutineImage(Picture? routineImage) {
    this.routineImage = routineImage;
  }

  List<Duration> getDurationToAddToTargetTime() {
    if (wakeUpImage == null) {
      return [const Duration(minutes: 10), const Duration(minutes: 30)];
    } else if (diaryType == DiaryTypeEnum.INDOOR) {
      return [const Duration(hours: 1), const Duration(hours: 2)];
    } else {
      return [
        const Duration(minutes: 40),
        const Duration(hours: 1, minutes: 30)
      ];
    }
  }
}
