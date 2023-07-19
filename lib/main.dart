
import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/provider/register_state.dart';
import 'package:morning_holic_app/screens/nickname.dart';
import 'package:morning_holic_app/screens/register.dart';
import 'package:morning_holic_app/screens/sign_up.dart';
import 'package:morning_holic_app/screens/welcome.dart';
import 'package:provider/provider.dart';

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
      initialRoute: '/register',

      routes: {
        '/welcome':(context) => WelcomeScreen(),
        '/sign-up':(context) => SignUpScreen(),
        '/nickname-setting':(context) => NicknameSettingScreen(),
        '/register':(context) => RegisterScreen(),
        // '/login':(context) => LoginScreen(),
        // '/home': (context) => HomeScreen(),
        // '/createProfile' :(context) => CreateProfileScreen(),
        // '/searchDetails' : (context) => SearchDetailsScreen(),
      },
    );
  }
}