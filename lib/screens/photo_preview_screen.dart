import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/dtos/camera_image_model.dart';
import 'package:morning_holic_app/dtos/diary_image_model.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';
import 'package:morning_holic_app/provider/user_info_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/diary_home_state.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final CameraImageModel cameraImageModel;

  const PhotoPreviewScreen({
    required this.cameraImageModel,
    super.key,
  });

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  var globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _getAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              _getPreview(),
              const SizedBox(height: 20.0),
              _getButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _getAppBar(BuildContext context) {
    return CustomAppBar(
      context: context,
      horizontalPadding: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.black,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: 'preview',
      centerTitle: true,
    );
  }

  RepaintBoundary _getPreview() {
    return RepaintBoundary(
      key: globalKey,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            ClipRect(
              child: Transform(
                alignment: Alignment.center,
                transform: widget.cameraImageModel.isFromBackCamera
                    ? Matrix4.rotationY(0)
                    : Matrix4.rotationY(pi),
                child: Image.file(
                  File(widget.cameraImageModel.imagePath),
                ),
              ),
            ),
            Positioned(
              bottom: 45.0,
              left: 25.0,
              child: Text(
                widget.cameraImageModel.formattedDatetime,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoMono',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _getButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _getTextButton(
            text: '다시 찍기',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          child: Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
            return _getTextButton(
              text: '사진 사용',
              onPressed: () async {
                var renderObject = globalKey.currentContext?.findRenderObject();
                if (renderObject is RenderRepaintBoundary) {
                  var boundary = renderObject;
                  ui.Image image = await boundary.toImage(pixelRatio: 5.5);
                  final directory = (await getApplicationDocumentsDirectory()).path;
                  ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
                  Uint8List pngBytes = byteData.buffer.asUint8List();
                  DateTime now = DateTime.now();
                  File imgFile = File('$directory/${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}.png');
                  imgFile.writeAsBytes(pngBytes);
                  String processedImgPath = imgFile.path;

                  CachedNetworkImageProvider(processedImgPath);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString(diaryHomeState.currentDiaryImageType.value, processedImgPath);

                  final diaryImageModel = DiaryImageModel(
                    imagePath: processedImgPath,
                    minusScore: _getMinusScore(), // TODO
                    dateTime: widget.cameraImageModel.datetime,
                  );

                  switch (diaryHomeState.currentDiaryImageType) {
                    case DiaryImageTypeEnum.WAKE_UP:
                      diaryHomeState.updateWakeupImage(diaryImageModel);
                    case DiaryImageTypeEnum.ROUTINE_START:
                      diaryHomeState.updateRoutineStartImage(diaryImageModel);
                    case DiaryImageTypeEnum.ROUTINE_END:
                      diaryHomeState.updateRoutineEndImage(diaryImageModel);
                    case DiaryImageTypeEnum.ROUTINE:
                      diaryHomeState.updateRoutineImage(diaryImageModel);
                  }
                }
                Navigator.popUntil(context, ModalRoute.withName('/diary/home'));
              },
            );
          }),
        ),
      ],
    );
  }

  TextButton _getTextButton(
      {required String text, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: BACKGROUND_COLOR,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }

  int _getMinusScore() {
    final userInfoState = Provider.of<UserInfoState>(context, listen: false);
    final diaryHomeState = Provider.of<DiaryHomeState>(context, listen: false);

    List<Duration> durationsToAdd = diaryHomeState.getDurationToAddToTargetTime();
    DateTime datetime = widget.cameraImageModel.datetime;

    var targetTime = DateTime(datetime.year, datetime.month, datetime.day,
        userInfoState.targetWakeUpTime!.hour, userInfoState.targetWakeUpTime!.minute)
        .toUtc()
        .add(const Duration(hours: 9))
        .add(durationsToAdd[0]);

    if (targetTime.isBefore(datetime)) {
      targetTime = targetTime
          .subtract(durationsToAdd[0])
          .add(durationsToAdd[1]);

      if (targetTime.isBefore(datetime)) {
        return 2;
      } else {
        return 1;
      }
    } else {
      return 0;
    }
  }
}
