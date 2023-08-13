import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info_popup/info_popup.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/dropdown.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/components/radio_button.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/dtos/target_wake_up_time_model.dart';
import 'package:morning_holic_app/enums/BankEnum.dart';
import 'package:morning_holic_app/enums/ModeEnum.dart';
import 'package:morning_holic_app/payloads/request/register_request.dart';
import 'package:morning_holic_app/payloads/response/register_response.dart';
import 'package:morning_holic_app/provider/register_state.dart';
import 'package:morning_holic_app/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController bankAccountController = TextEditingController();
  bool isFirstRegister = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerData = ModalRoute.of(context)!.settings.arguments as RegisterResponse?;

      if (registerData != null) {
        setState(() {
          isFirstRegister = false;
        });
        final bankNameAndAccount = registerData.refundBankNameAndAccount.split(' ');
        final bankName = BankEnum.getByDisplayName(bankNameAndAccount[0]);
        bankAccountController.text = bankNameAndAccount[1];

        final registerState = Provider.of<RegisterState>(context, listen: false);
        registerState.updateWakeupTime(targetWakeUpTimeModelToString(registerData.targetWakeUpTime));
        registerState.updateRefundBankName(bankName);
        registerState.updateMode(registerData.mode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTitle(
                  title: "8월 모닝홀릭 신청",
                  description: "8월 모닝홀릭이 시작되기 전에는 아래 정보들을 언제든지 변경할 수 있습니다."),
              const SizedBox(height: 30),
              _targetWakeUpTimeDropdownBox,
              const SizedBox(height: 30),
              _modeSelection,
              const SizedBox(height: 30),
              _refundAccountInput(bankAccountController),
              const SizedBox(height: 30),
              _checkPleaseText,
              const SizedBox(height: 30),
              _completeButton(context, bankAccountController),
            ],
          ),
        ),
      ),
    );
  }

  final _targetWakeUpTimeDropdownBox =
    Consumer<RegisterState>(builder: (context, registerState, _) {
    return CustomDropdown(
        options: const [
          '4시',
          '4시 30분',
          '5시',
          '5시 30분',
          '6시',
          '6시 30분',
          '7시',
          '7시 30분',
          '8시'
        ],
        hint: '목표 기상시간',
        selectedValue: registerState.targetWakeUpTime,
        onChanged: (newValue) {
          registerState.updateWakeupTime(newValue!);
        });
  });

  final Column _modeSelection = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '모드 선택',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 5),
          InfoPopupWidget(
            contentTitle: '마일드 모드: 심플, 챌린지 모드 : 어려움',
            child: Icon(
              Icons.help_outline_rounded,
              color: Colors.black,
              size: 15,
            ),
          ),
        ],
      ),
      Consumer<RegisterState>(builder: (context, registerState, _) {
        return CustomRadioButton(
          options: ModeEnum.values.map((e) => e.displayName).toList(),
          currentValue: registerState.mode?.displayName,
          onChanged: (newValue) {
            registerState.updateMode(ModeEnum.getByDisplayName(newValue!));
          },
        );
      })
    ],
  );

  Column _refundAccountInput(TextEditingController bankAccountController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '환급 받을 계좌',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Consumer<RegisterState>(
          builder: (context, registerState, _) {
            return Row(
              children: [
                CustomDropdown(
                  width: 150.0,
                  options: BankEnum.values.map((e) => e.displayName).toList(),
                  hint: '은행',
                  selectedValue: registerState.refundBankName?.displayName,
                  onChanged: (newValue) {
                    registerState.updateRefundBankName(
                        BankEnum.getByDisplayName(newValue!));
                  },
                ),
                const Spacer(),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          textController: bankAccountController,
          placeHolder: '계좌 번호',
          maxLength: 20,
          textInputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
          ],
        )
      ],
    );
  }

  final _checkPleaseText = const Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.exclamationmark,
            color: Color(0xFFFF0000),
            size: 20,
          ),
          SizedBox(width: 12),
          Text(
            '꼭 확인해주세요',
            style: TextStyle(
              color: Color(0xFFFF0000),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 12),
          Icon(
            CupertinoIcons.exclamationmark,
            color: Color(0xFFFF0000),
            size: 20,
          )
        ],
      ),
      SizedBox(height: 20),
      Text(
        '입금 계좌: [토스뱅크 100067440674 김유민]',
        style: TextStyle(fontSize: 13),
      ),
      SizedBox(height: 10),
      Text(
        '마일드모드: 30,000원\n챌린지모드: 50,000원',
        style: TextStyle(fontSize: 13),
      ),
      SizedBox(height: 10),
      Text(
        '보증금을 입금해주시면 입금 확인 후 승인됩니다. 입금이 안 된 경우 신청이 반려될 수 있습니다.',
        style: TextStyle(fontSize: 13),
      )
    ],
  );

  CustomElevatedButton _completeButton(
    BuildContext context,
    TextEditingController bankAccountController,
  ) {
    UserRepository userRepository = UserRepository();

    return CustomElevatedButton(
        text: isFirstRegister ? '신청 완료' : '수정 완료',
        onPressed: () async {
          // TODO
          RegisterState registerState = context.read<RegisterState>();
          if (registerState.refundBankName == null ||
              registerState.mode == null ||
              registerState.targetWakeUpTime == null) {
            // error 처리
            return;
          }

          String targetWakeUpTime = registerState.targetWakeUpTime!;

          RegisterRequest registerRequest = RegisterRequest(
            refundBankName: registerState.refundBankName!.value,
            refundAccount: bankAccountController.text,
            mode: registerState.mode!.value,
            targetWakeUpTime: stringToTargetWakeUpTimeModel(targetWakeUpTime),
          );

          final response = await userRepository.register(registerRequest);
          if (response is String) {
            print(response);
          } else {
            Navigator.pushNamed(context, '/register/complete');
          }
        });
  }

  TargetWakeUpTimeModel stringToTargetWakeUpTimeModel(String targetWakeUpTime) {
    List<String> list = targetWakeUpTime.split('시');
    int hour = int.parse(list.first);
    int minute = list[1].isNotEmpty ? 30 : 0;
    return TargetWakeUpTimeModel(hour: hour, minute: minute);
  }

  String targetWakeUpTimeModelToString(TargetWakeUpTimeModel targetWakeUpTimeModel) {
    if (targetWakeUpTimeModel.minute == 0) {
      return "${targetWakeUpTimeModel.hour}시";
    } else {
      return "${targetWakeUpTimeModel.hour}시 ${targetWakeUpTimeModel.minute}";
    }
  }
}
