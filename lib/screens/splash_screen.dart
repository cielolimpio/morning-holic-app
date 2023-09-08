import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:morning_holic_app/database/picture_provider.dart';
import 'package:morning_holic_app/dtos/diary_image_model.dart';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';
import 'package:morning_holic_app/enums/user_status_enum.dart';
import 'package:morning_holic_app/payloads/response/user_info_response.dart';
import 'package:morning_holic_app/provider/diary_home_state.dart';
import 'package:morning_holic_app/provider/user_info_state.dart';
import 'package:morning_holic_app/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Size> _animation;

  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Size>(
      begin: Size(450, 200),
      end: Size(236.4, 158),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _animation.addListener(() {
      setState(() {});
    });

    getUserInfoAndGetRouteName().then((routeName) {
      // TODO: user info가 valid한지에 따라 다른 페이지로 가도록 Handling
      if (routeName == '/welcome') {
        Timer(Duration(milliseconds: 1000), () {
          _animationController.forward();
          Timer(Duration(milliseconds: 500), () {
            Navigator.pushNamed(context, '/welcome');
          });
        });
      } else {
        fetch(routeName).then((_) {
          Navigator.pushNamed(context, routeName);
        });
      }
    });
  }

  Future<String> getUserInfoAndGetRouteName() async {
    String? accessToken = await _getAccessToken();
    if (accessToken == null) {
      return '/welcome';
    } else {
      try {
        UserInfoResponse userInfo = await userRepository.getUserInfo(context);

        switch (userInfo.status) {
          case UserStatusEnum.INITIAL:
            return '/user/status/initial';
          case UserStatusEnum.REQUEST:
            return '/user/status/register';
          case UserStatusEnum.ACCEPT:
            return '/diary/home'; // TODO: home으로 바꿔야함.
          case UserStatusEnum.REJECT:
            return '/user/status/reject';
        }
      } on DioException catch (e) {
        return '/welcome';
      }
    }
  }

  _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> fetch(String routeName) async {
    if (routeName == '/diary/home') {
      // TODO: home으로 바꿔야 함
      final diaryHomeState = Provider.of<DiaryHomeState>(
          context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      DiaryImageTypeEnum.values.forEach((diaryImageType) async {
        int? pictureId = prefs.getInt(diaryImageType.value);
        if (pictureId != null) {
          PictureProvider pictureProvider = PictureProvider();
          Picture? picture = await pictureProvider.getPictureById(pictureId);

          if (picture != null) {
            switch (diaryImageType) {
              case DiaryImageTypeEnum.WAKE_UP:
                diaryHomeState.updateWakeupImage(picture);
                break;
              case DiaryImageTypeEnum.ROUTINE_START:
                diaryHomeState.updateRoutineStartImage(picture);
                break;
              case DiaryImageTypeEnum.ROUTINE_END:
                diaryHomeState.updateRoutineEndImage(picture);
                break;
              case DiaryImageTypeEnum.ROUTINE:
                diaryHomeState.updateRoutineImage(picture);
                break;
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Hero(
            tag: "morning holic",
            child: _getMorningHolicLogo(
              width: _animation.value.width,
              height: _animation.value.height,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getMorningHolicLogo({
  required double width,
  required double height,
}) {
  return Image.asset(
    'assets/img/MorningHolicLogo.png',
    width: width,
    height: height,
  );
}
