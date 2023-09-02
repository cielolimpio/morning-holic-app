import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/dtos/camera_image_model.dart';

class PhotoPreviewScreen extends StatelessWidget {
  final CameraImageModel cameraImageModel;

  const PhotoPreviewScreen({
    required this.cameraImageModel,
    super.key,
  });

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

  AspectRatio _getPreview() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          ClipRect(
            child: Transform(
              alignment: Alignment.center,
              transform: cameraImageModel.isFromBackCamera
                  ? Matrix4.rotationY(0)
                  : Matrix4.rotationY(pi),
              child: Image.file(
                File(cameraImageModel.imagePath),
              ),
            ),
          ),
          Positioned(
            bottom: 45.0,
            left: 25.0,
            child: Text(
              cameraImageModel.datetime,
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
          child: _getTextButton(
            text: '사진 사용',
            onPressed: () {},
          ),
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
}
