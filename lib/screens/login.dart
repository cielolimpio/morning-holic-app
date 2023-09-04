import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/enums/user_status_enum.dart';
import 'package:morning_holic_app/payloads/request/login_request.dart';
import 'package:morning_holic_app/payloads/response/get_user_status_response.dart';
import 'package:morning_holic_app/payloads/response/user_info_response.dart';
import 'package:morning_holic_app/provider/user_info_state.dart';
import 'package:morning_holic_app/repositories/auth_repository.dart';
import 'package:morning_holic_app/repositories/user_repository.dart';
import 'package:morning_holic_app/screens/sign_up.dart';
import 'package:provider/provider.dart';

import '../components/app_bar.dart';
import '../components/elevated_button.dart';
import '../components/password_text_form_field.dart';
import '../components/phone_num_dash_formatter.dart';
import '../components/text_form_field.dart';
import '../components/title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isValidatorOn = false;
  bool isPhoneNumberDuplicated = false;
  String duplicatedPhoneNumber = '';
  AuthRepository authRepository = AuthRepository();
  UserRepository userRepository = UserRepository();

  final numberRegex = RegExp(r'[0-9-]');
  final alphabetRegex = RegExp(r'[a-zA-Z]');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomTitle(title: '로그인'),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomTextFormField(
              textController: phoneNumberController,
              placeHolder: '전화번호를 입력하세요.',
              maxLength: 13,
              textInputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                PhoneNumDashFormatter(),
              ],
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (value.length != 13 || !value.startsWith('010-')) {
                    return '전화번호가 올바르지 않습니다.';
                  }
                } else {
                  return '전화번호를 입력해주세요.';
                }
                return null;
              },
              isValidatorOn: isValidatorOn,
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomPasswordTextFormField(
              textController: passwordController,
              placeHolder: '비밀번호',
              maxLength: 20,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (value.length < 8 ||
                      !numberRegex.hasMatch(value) ||
                      !alphabetRegex.hasMatch(value)) {
                    return '비밀번호는 8자리 이상이어야 하며 영문과 숫자를 반드시 포함해야 합니다.';
                  }
                }
                return null;
              },
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomElevatedButton(
              text: '로그인',
              // isDisabled: checkIfButtonDisabled(),
              onPressed: () async {
                setState(() {
                  isValidatorOn = false;
                });

                bool isFormValid = validateForms(
                    phoneNumberController.text, passwordController.text);

                if (!isFormValid) {
                  setState(() {
                    isValidatorOn = true;
                  });
                } else {
                  // TODO
                  LoginRequest loginRequest = LoginRequest(
                      phoneNumber: phoneNumberController.text,
                      password: passwordController.text);
                  final response = await authRepository.login(loginRequest);
                  if (response is String) {
                    print(response);
                  } else {
                    // Success
                    try {
                      UserInfoResponse userInfo = await userRepository.getUserInfo();

                      final userInfoState = Provider.of<UserInfoState>(context, listen: false);
                      userInfoState.updateUserInfo(
                        userId: userInfo.userId,
                        name: userInfo.name,
                        phoneNumber: userInfo.phoneNumber,
                        nickname: userInfo.nickname,
                        targetWakeUpTime: userInfo.targetWakeUpTime,
                        refundBankName: userInfo.refundBankName,
                        refundAccount: userInfo.refundAccount,
                        mode: userInfo.mode,
                        status: userInfo.status,
                        rejectReason: userInfo.rejectReason,
                      );

                      switch (userInfo.status) {
                        case UserStatusEnum.INITIAL:
                          Navigator.pushNamed(context, '/user/status/initial');
                        case UserStatusEnum.REQUEST:
                          Navigator.pushNamed(context, '/user/status/register');
                        case UserStatusEnum.ACCEPT:
                          Navigator.pushNamed(context, '/diary/home'); // TODO: home으로 바꿔야함.
                        case UserStatusEnum.REJECT:
                          Navigator.pushNamed(context, '/user/status/reject');
                      }
                    } on DioException catch (e) {
                      Navigator.pushNamed(context, '/welcome');
                    }
                    // 신청 O ->
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  bool validateForms(String phoneNumber, String password) {
    if (phoneNumber.isEmpty || password.isEmpty) return false;

    if (phoneNumber.length != 13) return false;
    if (!phoneNumber.startsWith('010-')) return false;
    return true;
  }
}
