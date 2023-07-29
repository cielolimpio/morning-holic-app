import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/enums/UserStatusEnum.dart';
import 'package:morning_holic_app/payloads/request/login_request.dart';
import 'package:morning_holic_app/payloads/response/get_user_status_response.dart';
import 'package:morning_holic_app/repositories/auth_repository.dart';
import 'package:morning_holic_app/screens/sign_up.dart';

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

  final numberRegex = RegExp(r'[0-9-]');
  final alphabetRegex = RegExp(r'[a-zA-Z]');

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
            const CustomTitle(
              title: '로그인'
            ),
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
                  phoneNumberController.text,
                  passwordController.text
                );

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
                    } else{
                      // Success
                      // TODO : User 상태에 따라 Redirect 다르게 해야함.
                      final response = await authRepository.getUserStatus();
                      if(response is String){

                      } else {
                        GetUserStatusResponse res = response as GetUserStatusResponse;
                        UserStatusEnum userStatus = res.userStatus;

                        if(userStatus == UserStatusEnum.INITIAL){
                          // 신청 X -> register screen
                          Navigator.pushNamed(context, '/register');
                        } else if(userStatus == UserStatusEnum.REQUEST){
                          Navigator.pushNamed(context, '/user/status/register');
                        } else if(userStatus == UserStatusEnum.ACCEPT){
                          // Navigator.pushNamed(context, '/home')
                        } else if(userStatus == UserStatusEnum.REJECT){
                          print(res.rejectReason);
                          print(res.userStatus);
                          Navigator.pushNamed(context, '/user/status/reject',
                              arguments: res.rejectReason);
                        }

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

  bool validateForms(
      String phoneNumber, String password) {
    if (phoneNumber.isEmpty || password.isEmpty) return false;

    if (phoneNumber.length != 13) return false;
    if (!phoneNumber.startsWith('010-')) return false;
    return true;
  }
}
