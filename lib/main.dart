
import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/provider/register_state.dart';
import 'package:morning_holic_app/screens/camera_screen.dart';
import 'package:morning_holic_app/screens/login.dart';
import 'package:morning_holic_app/screens/nickname.dart';
import 'package:morning_holic_app/screens/photo_preview_screen.dart';
import 'package:morning_holic_app/screens/register.dart';
import 'package:morning_holic_app/screens/register_complete.dart';
import 'package:morning_holic_app/screens/sign_up.dart';
import 'package:morning_holic_app/screens/user_initial_status.dart';
import 'package:morning_holic_app/screens/user_register_status.dart';
import 'package:morning_holic_app/screens/user_reject_status.dart';
import 'package:morning_holic_app/screens/welcome.dart';
import 'package:provider/provider.dart';

import 'dtos/camera_image_model.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => RegisterState(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: BACKGROUND_COLOR,
        fontFamily: 'AppleSDGothicNeo',
      ),
      initialRoute: '/welcome',

      routes: {
        '/welcome':(context) => WelcomeScreen(),
        '/sign-up':(context) => SignUpScreen(),
        '/nickname-setting':(context) => NicknameSettingScreen(),
        '/register':(context) => RegisterScreen(),
        '/register/complete':(context) => RegisterCompleteScreen(),
        '/user/status/initial':(context) => UserInitialStatusScreen(),
        '/user/status/register':(context) => UserRegisterStatusScreen(),
        '/login':(context) => LoginScreen(),
        '/user/status/reject':(context) => UserRejectStatusScreen(),
        '/camera':(context) => CameraScreen(),
        '/photo/preview':(context) => PhotoPreviewScreen(
          cameraImageModel: ModalRoute.of(context)?.settings.arguments as CameraImageModel,
        ),
        // '/home': (context) => HomeScreen(),
        // '/createProfile' :(context) => CreateProfileScreen(),
        // '/searchDetails' : (context) => SearchDetailsScreen(),
      },
    );
  }
}