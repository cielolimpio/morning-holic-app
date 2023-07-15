import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _morningHolicLogo,
            _WelcomeButtons(),
          ],
        ),
      ),
    );
  }
}

Widget _morningHolicLogo = Image.asset(
  'assets/img/MorningHolicLogo.png',
  width: 236.4,
  height: 158,
);

class _WelcomeButtons extends StatelessWidget {
  const _WelcomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: '회원가입',
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          buttonWidth: 340.0,
          buttonHeight: 55.0,
          onPressed: () {
            Navigator.pushNamed(context, '/sign-up');
          },
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            '이미 가입된 계정이 있다면?',
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                fontSize: 16.0
            ),
          ),
        )
      ],
    );
  }
}
