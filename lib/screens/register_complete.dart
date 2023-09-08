import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/constants/color.dart';

class RegisterCompleteScreen extends StatelessWidget {
  const RegisterCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 120,
              color: PRIMARY_COLOR,
            ),
            const SizedBox(height: 10),
            const Text(
              '신청이 완료되었습니다.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              '승인까지 1~2일 정도 소요될 수 있습니다.',
              style: TextStyle(
                fontSize: 15,
                color: GREY_COLOR,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: '확인',
              onPressed: () {
                Navigator.pushNamed(context, '/user/status/register');
              },
            )
          ],
        ),
      ),
    );
  }
}
