import 'dart:async';

import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/toggle_button.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';
import 'package:morning_holic_app/enums/diary_type_enum.dart';
import 'package:morning_holic_app/provider/user_info_state.dart';
import 'package:provider/provider.dart';

import '../provider/diary_home_state.dart';

class DiaryHomeScreen extends StatefulWidget {
  const DiaryHomeScreen({Key? key}) : super(key: key);

  @override
  State<DiaryHomeScreen> createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHomeScreen> {
  late String _formattedTime;
  int minusScore = 0;

  @override
  void initState() {
    super.initState();

    _updateTime();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      _updateTime();
    });
  }

  _updateTime() {
    final now = DateTime.now();

    final userInfoState = Provider.of<UserInfoState>(context, listen: false);
    final diaryHomeState = Provider.of<DiaryHomeState>(context, listen: false);

    List<Duration> durationsToAdd = diaryHomeState.getDurationToAddToTargetTime();

    var targetTime = DateTime(
            now.year,
            now.month,
            now.day,
            userInfoState.targetWakeUpTime!.hour,
            userInfoState.targetWakeUpTime!.minute)
        .add(durationsToAdd[0]);

    if (targetTime.isBefore(now)) {
      targetTime =
          targetTime.subtract(durationsToAdd[0]).add(durationsToAdd[1]);
      minusScore = 1;
      if (targetTime.isBefore(now)) {
        if (diaryHomeState.wakeUpImage == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            diaryHomeState.updateWakeupImage(
              Picture(
                picture: null,
                minusScore: 2,
                datetime: null,
              )
            );
            minusScore = 0;
          });
        } else {
          minusScore = 2;
        }
      }
    }

    Duration difference = targetTime.difference(now);

    final hours = difference.inHours;
    final minutes = difference.inMinutes - (hours * 60);
    final seconds = difference.inSeconds - (difference.inMinutes * 60);

    setState(() {
      _formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            _getTimer(),
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

  Widget _getTimer() {
    return Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
      String type;
      if (diaryHomeState.wakeUpImage == null) {
        type = '기상';
      } else {
        type = '루틴';
      }
      switch (minusScore) {
        case 0:
          return getTimerString(target: "[$type] 성공", time: _formattedTime);
        case 1:
          return getTimerString(target: "[$type] -1", time: _formattedTime);
        case 2:
          return getTimerString(target: "[$type] -1", time: "00:00:00");
        default:
          return Text("실패");
      }
    });
  }

  Row getTimerString({
    required String target,
    required String time,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          target,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'RobotoMono',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "까지 남은 시간 : ",
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'RobotoMono',
            fontSize: 18,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  final Widget _customToggleButton = CustomToggleButton(
    contents: const <Widget>[
      Text(
        "실내",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      ),
      Text(
        "야외",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      )
    ],
    selectedContents: <bool>[true, false],
  );

  Widget _getDiaryRow({
    required DiaryImageTypeEnum diaryImageType,
    required String text,
  }) {
    return Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
      Picture? picture;
      switch (diaryImageType) {
        case DiaryImageTypeEnum.WAKE_UP:
          picture = diaryHomeState.wakeUpImage;
        case DiaryImageTypeEnum.ROUTINE_START:
          picture = diaryHomeState.routineStartImage;
        case DiaryImageTypeEnum.ROUTINE_END:
          picture = diaryHomeState.routineEndImage;
        case DiaryImageTypeEnum.ROUTINE:
          picture = diaryHomeState.routineImage;
      }

      bool? isChecked;
      if (picture == null) {
        isChecked = null;
      } else if (picture.picture == null) {
        isChecked = false;
      } else {
        isChecked = true;
      }

      return Column(
        children: [
          Row(
            children: [
              _getCheckButton(isChecked: isChecked),
              _getDiaryText(text),
              const Spacer(),
              _getCameraIconButton(
                diaryImageType: diaryImageType,
                isAlreadyTaken: isChecked != null,
                isBlack: isChecked != false,
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
    });
  }

  Widget _getWakeUpRow() {
    return _getDiaryRow(
      diaryImageType: DiaryImageTypeEnum.WAKE_UP,
      text: "기상 인증",
    );
  }

  Column _getIndoorRoutineColumn() {
    return Column(
      children: [
        _getDiaryRow(
          diaryImageType: DiaryImageTypeEnum.ROUTINE_START,
          text: "루틴 시작 인증",
        ),
        _getDiaryRow(
          diaryImageType: DiaryImageTypeEnum.ROUTINE_END,
          text: "루틴 끝 인증",
        ),
      ],
    );
  }

  Widget _getOutdoorRoutineColumn() {
    return _getDiaryRow(
      diaryImageType: DiaryImageTypeEnum.ROUTINE,
      text: "루틴 인증",
    );
  }

  IconButton _getCheckButton({required bool? isChecked}) {
    IconData icon;
    Color color;

    if (isChecked == null) {
      icon = Icons.check_circle;
      color = GREY_COLOR;
    } else if (isChecked) {
      icon = Icons.check_circle;
      color = PRIMARY_COLOR;
    } else {
      icon = Icons.highlight_remove_outlined;
      color = Colors.red;
    }

    return IconButton(
      onPressed: () {},
      icon: Icon(icon),
      color: color,
      iconSize: 30.0,
    );
  }

  Text _getDiaryText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black87,
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
          if (isAlreadyTaken && !isBlack) {
            return;
          } else if (!isAlreadyTaken && isBlack) {
            diaryHomeState.updateDiaryImageType(diaryImageType);
            Navigator.pushNamed(
              context,
              '/camera',
            );
          } else if (isAlreadyTaken) {
            Picture picture;
            switch (diaryImageType) {
              case DiaryImageTypeEnum.WAKE_UP:
                picture = diaryHomeState.wakeUpImage!;
              case DiaryImageTypeEnum.ROUTINE_START:
                picture = diaryHomeState.routineStartImage!;
              case DiaryImageTypeEnum.ROUTINE_END:
                picture = diaryHomeState.routineEndImage!;
              case DiaryImageTypeEnum.ROUTINE:
                picture = diaryHomeState.routineImage!;
            }

            Navigator.pushNamed(
              context,
              '/photo/view',
              arguments: picture,
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
