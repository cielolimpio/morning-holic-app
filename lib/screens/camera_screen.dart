import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/dtos/camera_image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraController?> cameraControllers = [null, null];
  bool _isCameraReady = false;
  int _currentCameraIndex = 0;
  bool _isFlashOn = false;
  String _now = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _persistentlyRequestCameraPermission().then((value) {
      availableCameras().then((cameras) {
        initializeCameras(cameras);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    cameraControllers.forEach((controller) {
      controller?.dispose();
    });
    super.dispose();
  }

  Future<void> _persistentlyRequestCameraPermission() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      await showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("권한 설정을 확인해주세요."),
              content: Text("Morning Holic의 카메라 접근을 \n허용해주십시오. 설정으로 이동합니다."),
              actions: [
                CupertinoButton(
                  onPressed: () {
                    openAppSettings(); // 앱 설정으로 이동
                  },
                  child: Text(
                    '설정하기',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  void initializeCameras(List<CameraDescription> cameras) async {
    if (cameras.isNotEmpty) {
      var backCamera = cameras.firstWhere(
              (element) => element.lensDirection == CameraLensDirection.back);
      var frontCamera = cameras.firstWhere(
              (element) => element.lensDirection == CameraLensDirection.front);

      cameraControllers[0] = CameraController(
        backCamera,
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.bgra8888,
        enableAudio: false,
      );
      cameraControllers[1] = CameraController(
        frontCamera,
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.bgra8888,
        enableAudio: false,
      );

      await cameraControllers[0]!.initialize();

      _isCameraReady = true;
      _updateTime();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _updateTime();
      });
    }
  }

  _updateTime() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 9));

    setState(() {
      _now =
          '${now.year.toString()}년 ${now.month.toString()}월 ${now.day.toString()}일 (${_getWeekdayString(now)})\n'
          '${now.hour >= 12 ? '오후' : '오전'} ${now.hour >= 12 ? (now.hour - 12).toString() : now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  String _getWeekdayString(DateTime now) {
    switch (now.weekday) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _getCamera(),
            _getMessage(),
            _getCameraButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSize _getAppBar(BuildContext context) {
    return CustomAppBar(
      context: context,
      horizontalPadding: 0.0,
      leading: TextButton(
        child: const Text(
          '취소',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: '기상 인증',
      centerTitle: true,
    );
  }

  AspectRatio _getCamera() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          ClipRect(
            child: Transform.scale(
              scale:
                  cameraControllers[_currentCameraIndex]?.value.aspectRatio ?? 1.0,
              child: Center(
                child: cameraControllers[_currentCameraIndex] != null && _isCameraReady
                    ? CameraPreview(
                        cameraControllers[_currentCameraIndex]!,
                      )
                    : Container(
                        color: Colors.grey,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 45.0,
            left: 25.0,
            child: Text(
              _now,
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
    );
  }

  Padding _getMessage() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getText('오늘의 '),
          _getText(
            '기상 인증',
            fontWeight: FontWeight.w600,
          ),
          _getText(' 사진을 찍어주세요!'),
        ],
      ),
    );
  }

  Text _getText(String text, {FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: fontWeight,
      ),
    );
  }

  Expanded _getCameraButtons() {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: cameraControllers[_currentCameraIndex] != null
                  ? () => _onSwitchCamera()
                  : null,
              icon: const Icon(
                CupertinoIcons.arrow_2_circlepath,
                size: 30.0,
                color: GREY_COLOR,
              ),
            ),
            RawMaterialButton(
              onPressed: cameraControllers[_currentCameraIndex] != null
                  ? () => _onTakePicture(context)
                  : null,
              elevation: 2.0,
              fillColor: PRIMARY_COLOR,
              padding: const EdgeInsets.all(2.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.circle,
                color: BACKGROUND_COLOR,
                size: 80.0,
              ),
            ),
            IconButton(
              onPressed: cameraControllers[_currentCameraIndex] != null && _currentCameraIndex == 0
                  ? () => _onFlash()
                  : null,
              icon: Icon(
                Icons.flash_on,
                size: 30.0,
                color: _isFlashOn && _currentCameraIndex == 0 ? PRIMARY_COLOR : GREY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTakePicture(BuildContext context) async {
    XFile? tempFile =
    await cameraControllers[_currentCameraIndex]!.takePicture();

    if (tempFile != null) {
      final capturedImage = img.decodeImage(await tempFile.readAsBytes())!;
      var cropSize = min(capturedImage.width, capturedImage.height);
      int offsetX = (capturedImage.width - cropSize) ~/ 2;
      int offsetY = (capturedImage.height - cropSize) ~/ 2;

      final orientedImage = img.bakeOrientation(capturedImage);
      final croppedImage = img.copyCrop(
        orientedImage,
        x: offsetX,
        y: offsetY,
        width: cropSize,
        height: cropSize,
      );

      String filePath =
          '${(await getTemporaryDirectory()).path}/captured_image_${tempFile.hashCode}.png';
      File imageFile = File(filePath);

      await imageFile.writeAsBytes(img.encodeJpg(croppedImage));
      await Navigator.pushNamed(
        context,
        '/photo/preview',
        arguments: CameraImageModel(
          imagePath: imageFile.path,
          isFromBackCamera: _currentCameraIndex == 0,
          datetime: _now,
        ),
      );
    }
  }

  void _onSwitchCamera() async {
    if (!_isCameraReady) {
      return;
    } else {
      final cameraIndexToChange = (_currentCameraIndex + 1) % 2;
      await cameraControllers[cameraIndexToChange]!.initialize();

      setState(() {
        if (_isFlashOn) {
          cameraControllers[_currentCameraIndex]!.setFlashMode(FlashMode.off);
          if (cameraIndexToChange == 0) {
            cameraControllers[cameraIndexToChange]!.setFlashMode(FlashMode.torch);
          }
        }
        _currentCameraIndex = cameraIndexToChange;
      });
    }
  }

  void _onFlash() {
    if (!_isCameraReady) {
      return;
    } else {
      if (_currentCameraIndex == 0) {
        setState(() {
          cameraControllers[_currentCameraIndex]!
              .setFlashMode(_isFlashOn ? FlashMode.off : FlashMode.torch);
          _isFlashOn = !_isFlashOn;
        });
      }
    }
  }
}
