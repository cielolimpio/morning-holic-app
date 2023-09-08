import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:morning_holic_app/provider/diary_home_state.dart';
import 'package:morning_holic_app/provider/register_state.dart';
import 'package:morning_holic_app/provider/user_info_state.dart';
import 'package:morning_holic_app/screens/camera_screen.dart';
import 'package:morning_holic_app/screens/diary_contents_screen.dart';
import 'package:morning_holic_app/screens/diary_home_screen.dart';
import 'package:morning_holic_app/screens/login_screen.dart';
import 'package:morning_holic_app/screens/nickname_screen.dart';
import 'package:morning_holic_app/screens/photo_preview_screen.dart';
import 'package:morning_holic_app/screens/photo_view_screen.dart';
import 'package:morning_holic_app/screens/register_screen.dart';
import 'package:morning_holic_app/screens/register_complete.dart';
import 'package:morning_holic_app/screens/sign_up_screen.dart';
import 'package:morning_holic_app/screens/splash_screen.dart';
import 'package:morning_holic_app/screens/user_initial_status_screen.dart';
import 'package:morning_holic_app/screens/user_register_status_screen.dart';
import 'package:morning_holic_app/screens/user_reject_status_screen.dart';
import 'package:morning_holic_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'dtos/camera_image_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserInfoState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RegisterState()),
          ChangeNotifierProvider(create: (context) => DiaryHomeState())
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: BACKGROUND_COLOR,
            fontFamily: 'AppleSDGothicNeo',
          ),
          initialRoute: '/splash',
          routes: {
            '/splash':(context) => SplashScreen(),
            '/welcome': (context) => WelcomeScreen(),
            '/sign-up': (context) => SignUpScreen(),
            '/nickname-setting': (context) => NicknameSettingScreen(),
            '/register': (context) => RegisterScreen(),
            '/register/complete': (context) => RegisterCompleteScreen(),
            '/user/status/initial': (context) => UserInitialStatusScreen(),
            '/user/status/register': (context) => UserRegisterStatusScreen(),
            '/login': (context) => LoginScreen(),
            '/user/status/reject': (context) => UserRejectStatusScreen(),
            '/diary/home': (context) => DiaryHomeScreen(),
            '/camera': (context) => CameraScreen(),
            '/photo/preview': (context) => PhotoPreviewScreen(
                  cameraImageModel: ModalRoute.of(context)?.settings.arguments
                      as CameraImageModel,
                ),
            '/photo/view': (context) => PhotoViewScreen(picture: ModalRoute.of(context)?.settings.arguments as Picture),
            '/diary/contents': (context) => DiaryContentsScreen(),
            // '/home': (context) => HomeScreen(),
            // '/createProfile' :(context) => CreateProfileScreen(),
            // '/searchDetails' : (context) => SearchDetailsScreen(),
          },
        ));
  }
}
