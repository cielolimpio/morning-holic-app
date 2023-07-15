import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/img/MorningHolicLogo.png',
          width: 236.4,
          height: 158,
        ),
        CustomElevatedButton(
          text: '회원가입',
          buttonWidth: 340.0,
          buttonHeight: 55.0,
          onPressed: () {},
        )
      ],
    );
  }
}
