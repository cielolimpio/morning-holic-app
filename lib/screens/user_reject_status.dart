import 'package:flutter/material.dart';

import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/constants/color.dart';

class UserRejectStatusScreen extends StatelessWidget {
  const UserRejectStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rejectReason = ModalRoute
        .of(context)!
        .settings
        .arguments as String?;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.block,
              size: 120,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            const Text(
              '신청이 반려되었습니다.',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              '사유: $rejectReason',
              style: TextStyle(
                fontSize: 15,
                color: GREY_COLOR,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: '다시 신청하기',
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            )
          ],
        ),
      ),
    );
  }
}
