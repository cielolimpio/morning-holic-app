import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/dtos/sign_up_model.dart';
import 'package:morning_holic_app/payloads/request/sign_up_request.dart';
import 'package:morning_holic_app/repositories/auth_repository.dart';
import '../components/elevated_button.dart';
import '../payloads/response/jwt_token_response.dart';

class NicknameSettingScreen extends StatelessWidget {
  const NicknameSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();

    TextEditingController nicknameController = TextEditingController();

    final signUpRequest = ModalRoute
        .of(context)!
        .settings
        .arguments as SignUpModel;

    return Scaffold(
      appBar: CustomAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitle(
              title: '닉네임 설정하기',
              description: '앱에서 사용할 닉네임을 설정하세요. 나중에 언제든지 변경할 수 있습니다.',
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomTextFormField(
              textController: nicknameController,
              placeHolder: '닉네임',
              maxLength: 20,
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomElevatedButton(
              text: '다음',
              onPressed: () {
                SignUpRequest request = SignUpRequest(
                  name: signUpRequest.name,
                  phoneNumber: signUpRequest.phoneNumber,
                  password: signUpRequest.password,
                  nickname: nicknameController.text,
                );

                final response = authRepository.signUp(request);
              },
            )
          ],
        ),
      ),
    );
  }
}