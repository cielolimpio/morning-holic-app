import 'package:flutter/material.dart';
import 'package:morning_holic_app/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/welcome',

      routes: {
        '/welcome':(context) => WelcomeScreen(),
        // '/login':(context) => LoginScreen(),
        // '/join':(context) => JoinScreen(),
        // '/home': (context) => HomeScreen(),
        // '/createProfile' :(context) => CreateProfileScreen(),
        // '/searchDetails' : (context) => SearchDetailsScreen(),
      },
    );
  }
}