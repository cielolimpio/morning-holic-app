import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:morning_holic_app/payloads/response/user_info_response.dart';
import 'package:morning_holic_app/repositories/user_repository.dart';
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

    getUserInfoAndCheckValidation().then((isValid) {
      // TODO: user info가 valid한지에 따라 다른 페이지로 가도록 Handling
      Timer(Duration(milliseconds: 1000), () {
        _animationController.forward();
        Timer(Duration(milliseconds: 500), () {
          Navigator.pushNamed(
            context,
            '/welcome',
          );
        });
      });
    });
  }

  Future<bool> getUserInfoAndCheckValidation() async {
    String? accessToken = await _getAccessToken();
    if (accessToken == null) {
      return false;
    } else {
      try {
        UserInfoResponse userInfo = await userRepository.getUserInfo();
        return true;
      } on DioException catch (e) {
        return false;
      }
    }
  }

  _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
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
