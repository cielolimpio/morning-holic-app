import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitle(
              title: '회원가입',
              description: '회원가입에 필요한 정보들을 입력해주세요.',
            ),
            SizedBox.fromSize(size: Size(0, 30)),
            CustomTextFormField(placeHolder: '이름'),
          ],
        ),
      ),
    );
  }
}
