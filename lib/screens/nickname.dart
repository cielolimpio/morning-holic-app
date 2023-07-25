import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/dtos/sign_up_model.dart';
import 'package:morning_holic_app/payloads/request/sign_up_request.dart';
import 'package:morning_holic_app/repositories/auth_repository.dart';
import '../components/elevated_button.dart';

class NicknameSettingScreen extends StatefulWidget {
  const NicknameSettingScreen({super.key});

  @override
  State<NicknameSettingScreen> createState() => _NicknameSettingScreenState();
}

class _NicknameSettingScreenState extends State<NicknameSettingScreen> {
  bool isValidatorOn = false;
  bool isNicknameDuplicated = false;

  TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              validator: nicknameValidator,
              isValidatorOn: isValidatorOn,
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomElevatedButton(
              text: '다음',
              onPressed: buttonOnPressed,
            )
          ],
        ),
      ),
    );
  }

  String? nicknameValidator(String? value) {
    if (isNicknameDuplicated) {
      return '이미 존재하는 닉네임입니다.';
    } else {
      return null;
    }
  }

  void buttonOnPressed() async {
    setState(() {
      isValidatorOn = false;
      isNicknameDuplicated = false;
    });
    final signUpRequest = ModalRoute
        .of(context)!
        .settings
        .arguments as SignUpModel;

    SignUpRequest request = SignUpRequest(
      name: signUpRequest.name,
      phoneNumber: signUpRequest.phoneNumber,
      password: signUpRequest.password,
      nickname: nicknameController.text,
    );

    AuthRepository authRepository = AuthRepository();
    final response = await authRepository.signUp(request);
    if (response is String) {
      setState(() {
        isValidatorOn = true;
        isNicknameDuplicated = true;
      });
    } else {
      Navigator.pushNamed(context, '/user/status/initial');
    }
  }
}