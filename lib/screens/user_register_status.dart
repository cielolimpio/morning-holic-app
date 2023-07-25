import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/payloads/response/register_response.dart';
import 'package:morning_holic_app/repositories/user_repository.dart';

class UserRegisterStatusScreen extends StatefulWidget {
  const UserRegisterStatusScreen({super.key});

  @override
  State<UserRegisterStatusScreen> createState() => _UserRegisterStatusScreenState();
}

class _UserRegisterStatusScreenState extends State<UserRegisterStatusScreen> {
  UserRepository userRepository = UserRepository();
  RegisterResponse? registerData;

  @override
  void initState() {
    super.initState();
    _initializeRegisterData();
  }

  void _initializeRegisterData() async {
    final response = await userRepository.getRegisterData();
    setState(() {
      registerData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (registerData == null) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: CustomAppBar(
          context: context,
          hasLeadingIcon: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTitle(
                title: '승인 대기 중입니다.',
                description: '승인까지 1~2일 정도 소요될 수 있습니다.',
              ),
              const SizedBox(height: 30),
              _registerInfo('목표 기상 시간',
                  _getTargetWakeUpTimeString(registerData!.targetWakeUpTime),
                  false),
              const SizedBox(height: 30),
              _registerInfo('모드 선택', registerData!.mode.displayName, true),
              const SizedBox(height: 30),
              _registerInfo(
                  '환급 받을 계좌', registerData!.refundBankNameAndAccount, false),
              const SizedBox(height: 80),
              _checkPleaseText,
              const SizedBox(height: 30),
              CustomElevatedButton(
                text: '수정하기',
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

  String _getTargetWakeUpTimeString(DateTime targetWakeUpTime) {
    final hour = targetWakeUpTime.hour;
    final minute = targetWakeUpTime.minute;

    if (minute != 0) {
      return "$hour시 $minute분";
    } else {
      return "$hour시";
    }
  }

  Column _registerInfo(
    String title,
    String data,
    bool hasPopUp,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            if (hasPopUp)
              const InfoPopupWidget(
                contentTitle: '마일드 모드: 심플, 챌린지 모드 : 어려움',
                child: Icon(
                  Icons.help_outline_rounded,
                  color: Colors.black,
                  size: 15,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_outlined,
              color: PRIMARY_COLOR,
              size: 30,
            ),
            const SizedBox(width: 5),
            Text(
              data,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        )
      ],
    );
  }

  final _checkPleaseText = const Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
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
      ),
      SizedBox(height: 10),
      Text(
        '기타 문의 사항은 [URL] 카카오톡 오픈채팅방을 활용해주세요.',
        style: TextStyle(fontSize: 13),
      ),
    ],
  );
}
