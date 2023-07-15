import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/constants/color.dart';

import '../components/password_text_form_field.dart';
import '../components/phone_num_dash_formatter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordCheckController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(context: context),
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
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomTextFormField(
              textController: nameController,
              placeHolder: '이름',
              maxLength: 10,
              textInputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]')),
              ],
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomTextFormField(
              textController: phoneNumberController,
              placeHolder: '전화번호',
              maxLength: 13,
              textInputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                PhoneNumDashFormatter(),
              ],
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomPasswordTextFormField(
              textController: passwordController,
              placeHolder: '비밀번호',
              maxLength: 20,
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomPasswordTextFormField(
              textController: passwordCheckController,
              placeHolder: '비밀번호 확인',
              maxLength: 20,
            ),
            SizedBox.fromSize(size: const Size(0, 50)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Agreements(),
                CustomElevatedButton(
                  text: '다음',
                  onPressed: () {
                    bool isValid = validateForms(
                      nameController.text,
                      phoneNumberController.text,
                      passwordController.text,
                      passwordCheckController.text,
                    );
                    if (isValid) {
                      Navigator.pushNamed(context, '/nickname-setting');
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

bool validateForms(String name, String phoneNumber, String password,
    String passwordCheck) {
  if (name.isEmpty || phoneNumber.isEmpty ||
      password.isEmpty || passwordCheck.isEmpty) return false;

  if (password != passwordCheck) return false;

  return true;
}

class _Agreements extends StatefulWidget {
  const _Agreements({super.key});

  @override
  State<_Agreements> createState() => _AgreementsState();
}

class _AgreementsState extends State<_Agreements> {
  List<String> _agreements = [];
  List<bool> _agreementsBool = [];

  @override
  void initState() {
    _agreements =
    ['서비스 이용약관 동의 (필수)', '개인정보 수집 및 이용 동의 (필수)', '마케팅 수신 동의 (선택)'];
    _agreementsBool = _agreements.indexed.map((e) => false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (_agreementsBool.any((element) => element == false)) {
                  setState(() {
                    _agreementsBool.replaceRange(0, _agreementsBool.length,
                        _agreementsBool.map((e) => true).toList());
                  });
                } else {
                  setState(() {
                    _agreementsBool.replaceRange(0, _agreementsBool.length,
                        _agreementsBool.map((e) => false).toList());
                  });
                }
              },
              icon: const Icon(Icons.check_circle),
              color: _agreementsBool.any((element) => element == false)
                  ? GREY_COLOR
                  : PRIMARY_COLOR,
              iconSize: 30.0,
            ),
            const Text(
              '전체 동의',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const Divider(
          color: Colors.black,
          thickness: 0.3,
        ),
        Column(
          children:
          _agreements
              .asMap()
              .entries
              .map((e) =>
              _Agreement(
                text: e.value,
                isSelected: _agreementsBool[e.key],
                checkCircleOnPressed: () {
                  setState(() {
                    _agreementsBool[e.key] = !_agreementsBool[e.key];
                  });
                },
              ))
              .toList(),
        ),
        SizedBox.fromSize(size: const Size(0, 30)),
      ],
    );
  }
}

class _Agreement extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function() checkCircleOnPressed;

  const _Agreement({
    required this.text,
    required this.isSelected,
    required this.checkCircleOnPressed,
    super.key,
  });

  @override
  State<_Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<_Agreement> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: widget.checkCircleOnPressed,
              icon: const Icon(Icons.check_circle),
              color: widget.isSelected ? PRIMARY_COLOR : GREY_COLOR,
              iconSize: 30.0,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
            ),
            SizedBox.fromSize(size: const Size(10, 0)),
          ],
        ),
      ],
    );
  }
}
