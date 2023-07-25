import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/repositories/auth_repository.dart';

import '../components/password_text_form_field.dart';
import '../components/phone_num_dash_formatter.dart';
import '../dtos/sign_up_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<String> _agreements = [];
  List<bool> _agreementsBool = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  bool isValidatorOn = false;
  bool isPhoneNumberDuplicated = false;
  String duplicatedPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _agreements = ['서비스 이용약관 동의 (필수)', '개인정보 수집 및 이용 동의 (필수)'];
    _agreementsBool = _agreements.indexed.map((e) => false).toList();
  }

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
              validator: nameValidator,
              isValidatorOn: isValidatorOn,
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
              validator: phoneNumberValidator,
              isValidatorOn: isValidatorOn,
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomPasswordTextFormField(
              textController: passwordController,
              placeHolder: '비밀번호',
              maxLength: 20,
              validator: passwordValidator,
            ),
            SizedBox.fromSize(size: const Size(0, 30)),
            CustomPasswordTextFormField(
              textController: passwordCheckController,
              placeHolder: '비밀번호 확인',
              maxLength: 20,
              validator: passwordValidator,
            ),
            SizedBox.fromSize(size: const Size(0, 50)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Agreements(
                  agreements: _agreements,
                  agreementsBool: _agreementsBool,
                  allAgreeOnPressed: allAgreeOnPressed,
                  agreementOnPressed: agreementOnPressed,
                ),
                CustomElevatedButton(
                  text: '다음',
                  isDisabled: checkIfButtonDisabled(),
                  onPressed: buttonOnPressed,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요.';
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (isPhoneNumberDuplicated) {
      if (value == duplicatedPhoneNumber) {
        return '이미 가입된 전화번호가 있습니다.';
      }
    } else if (value != null && value.isNotEmpty) {
      if (value.length != 13 || !value.startsWith('010-')) {
        return '전화번호가 올바르지 않습니다.';
      }
    } else {
      return '전화번호를 입력해주세요.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 8 ||
          !numberRegex.hasMatch(value) ||
          !alphabetRegex.hasMatch(value)) {
        return '비밀번호는 8자리 이상이어야 하며 영문과 숫자를 반드시 포함해야 합니다.';
      }
    }
    return null;
  }

  void buttonOnPressed() async {
    setState(() {
      isValidatorOn = false;
      isPhoneNumberDuplicated = false;
    });

    bool isFormValid = validateForms(
      nameController.text,
      phoneNumberController.text,
      passwordController.text,
      passwordCheckController.text,
    );
    if (!isFormValid) {
      setState(() {
        isValidatorOn = true;
      });
    } else {
      AuthRepository authRepository = AuthRepository();
      bool isPhoneNumberValid = await authRepository
          .validateSignUp(phoneNumberController.text);
      print(isPhoneNumberValid);
      if (isPhoneNumberValid) {
        Navigator.pushNamed(
          context,
          '/nickname-setting',
          arguments: SignUpModel(
            name: nameController.text,
            phoneNumber: phoneNumberController.text,
            password: passwordController.text,
          ),
        );
      } else {
        setState(() {
          isValidatorOn = true;
          isPhoneNumberDuplicated = true;
          duplicatedPhoneNumber = phoneNumberController.text;
        });
      }
    }
  }

  bool checkIfButtonDisabled() {
    if (_agreementsBool.any((element) => element == false)) {
      return true;
    }
    return false;
  }

  void allAgreeOnPressed() {
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
  }

  void agreementOnPressed(int index) {
    setState(() {
      _agreementsBool[index] = !_agreementsBool[index];
    });
  }
}

final numberRegex = RegExp(r'[0-9-]');
final alphabetRegex = RegExp(r'[a-zA-Z]');

bool validateForms(
    String name, String phoneNumber, String password, String passwordCheck) {
  if (name.isEmpty ||
      phoneNumber.isEmpty ||
      password.isEmpty ||
      passwordCheck.isEmpty) return false;

  if (phoneNumber.length != 13) return false;
  if (!phoneNumber.startsWith('010-')) return false;
  if (password != passwordCheck) return false;

  return true;
}

class _Agreements extends StatefulWidget {
  final List<String> agreements;
  final List<bool> agreementsBool;
  final VoidCallback allAgreeOnPressed;
  final Function(int index) agreementOnPressed;

  const _Agreements({
    required this.agreements,
    required this.agreementsBool,
    required this.allAgreeOnPressed,
    required this.agreementOnPressed,
    super.key,
  });

  @override
  State<_Agreements> createState() => _AgreementsState();
}

class _AgreementsState extends State<_Agreements> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: widget.allAgreeOnPressed,
              icon: const Icon(Icons.check_circle),
              color: widget.agreementsBool.any((element) => element == false)
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
          children: widget.agreements
              .asMap()
              .entries
              .map((e) => _Agreement(
                    text: e.value,
                    isSelected: widget.agreementsBool[e.key],
                    checkCircleOnPressed: () {
                      widget.agreementOnPressed(e.key);
                    },
                  ))
              .toList(),
        ),
        SizedBox.fromSize(size: const Size(0, 30)),
      ],
    );
  }
}

class _Agreement extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: checkCircleOnPressed,
              icon: const Icon(Icons.check_circle),
              color: isSelected ? PRIMARY_COLOR : GREY_COLOR,
              iconSize: 30.0,
            ),
            Text(
              text,
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
