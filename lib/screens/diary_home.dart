import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/toggle_button.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';
import 'package:morning_holic_app/enums/diary_type_enum.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/diary_home_state.dart';

class DiaryHomeScreen extends StatefulWidget {
  const DiaryHomeScreen({Key? key}) : super(key: key);

  @override
  State<DiaryHomeScreen> createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(
              "[루틴] 성공까지 남은 시간 : 00 : 21 : 49",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
            // TODO : 실내, 야외 선택 버튼
            _customToggleButton,
            const SizedBox(height: 15),

            Column(
              children: [
                // 기상 인증
                _getWakeUpRow(),
                // 루틴 인증
                Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
                  if (diaryHomeState.diaryType == DiaryTypeEnum.INDOOR) {
                    return _getIndoorRoutineColumn();
                  } else {
                    return _getOutdoorRoutineColumn();
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _getAppBar(BuildContext context) {
    return CustomAppBar(
      context: context,
      leading: const Icon(
        Icons.camera_alt,
        size: 30.0,
        color: Colors.black87,
      ),
      title: '인증',
      hasBottomLine: true,
    );
  }

  final Widget _customToggleButton = CustomToggleButton(
    contents: const <Widget>[
      Text(
        "실내",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      ),
      Text(
        "야외",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      )
    ],
    selectedContents: <bool>[true, false],
  );

  Widget _getDiaryRow({
    required DiaryImageTypeEnum diaryImageType,
    required bool isChecked,
    required String text,
    required bool isAlreadyTaken,
    required bool isBlack,
  }) {
    return Column(
      children: [
        Row(
          children: [
            _getCheckButton(isChecked: isChecked),
            _getDiaryText(text),
            const Spacer(),
            _getCameraIconButton(
              diaryImageType: diaryImageType,
              isAlreadyTaken: isAlreadyTaken,
              isBlack: isBlack,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(thickness: 1, color: GREY_COLOR, height: 0),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _getWakeUpRow() {
    return Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
      return _getDiaryRow(
        diaryImageType: DiaryImageTypeEnum.WAKE_UP,
        isChecked: diaryHomeState.wakeupImage != null,
        text: "기상 인증",
        isAlreadyTaken: diaryHomeState.wakeupImage != null,
        isBlack: true,
      );
    });
  }

  Column _getIndoorRoutineColumn() {
    return Column(
      children: [
        Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
          return _getDiaryRow(
            diaryImageType: DiaryImageTypeEnum.ROUTINE_START,
            isChecked: diaryHomeState.routineStartImage != null,
            text: "루틴 시작 인증",
            isAlreadyTaken: diaryHomeState.routineStartImage != null,
            isBlack: diaryHomeState.wakeupImage != null,
          );
        }),

        // 루틴 끝 인증 ROW
        Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
          return _getDiaryRow(
            diaryImageType: DiaryImageTypeEnum.ROUTINE_END,
            isChecked: diaryHomeState.routineEndImage != null,
            text: "루틴 끝 인증",
            isAlreadyTaken: diaryHomeState.routineEndImage != null,
            isBlack: diaryHomeState.routineStartImage != null,
          );
        }),
      ],
    );
  }

  Column _getOutdoorRoutineColumn() {
    return Column(
      children: [
        Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
          return _getDiaryRow(
            diaryImageType: DiaryImageTypeEnum.ROUTINE,
            isChecked: diaryHomeState.routineImage != null,
            text: "루틴 인증",
            isAlreadyTaken: diaryHomeState.routineImage != null,
            isBlack: diaryHomeState.wakeupImage != null,
          );
        }),
      ],
    );
  }

  IconButton _getCheckButton({required bool isChecked}) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.check_circle),
      color: isChecked ? PRIMARY_COLOR : GREY_COLOR,
      iconSize: 30.0,
    );
  }

  Text _getDiaryText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
      ),
    );
  }

  Widget _getCameraIconButton({
    required DiaryImageTypeEnum diaryImageType,
    required bool isAlreadyTaken,
    required bool isBlack,
  }) {
    return Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
      return IconButton(
        onPressed: () async {
          if (!isAlreadyTaken && isBlack) {
            diaryHomeState.updateDiaryImageType(diaryImageType);
            Navigator.pushNamed(
              context,
              '/camera',
            );
          } else if (isAlreadyTaken) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String imagePath = prefs.getString(diaryImageType.value)!;
            diaryHomeState.updateDiaryImageType(diaryImageType);
            Navigator.pushNamed(
              context,
              '/photo/view',
              arguments: imagePath,
            );
          }
        },
        icon: isAlreadyTaken
            ? const Icon(Icons.image)
            : const Icon(Icons.camera_alt),
        color: isBlack ? Colors.black : GREY_COLOR,
      );
    });
  }
}
