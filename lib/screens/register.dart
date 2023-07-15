import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/dropdown.dart';
import 'package:morning_holic_app/components/radio_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomDropdown(options: ['4시', '5시 30분', '6시'], hint: '목표 기상시간을 정해주세요.',),
            CustomRadioButton(options: ['마일드 모드', '챌린지 모드'], width: 140,)
          ],
        ),
      ),
    );
  }
}
