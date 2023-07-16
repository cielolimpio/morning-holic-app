import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/dropdown.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/components/radio_button.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController bankAccountController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(context: context),
              const CustomTitle(
                  title: "8월 모닝홀릭 신청",
                  description: "8월 모닝홀릭이 시작되기 전에는 아래 정보들을 언제지 변경할 수 있습니다."
              ),
              const SizedBox(height: 30,),
              const CustomDropdown(
                options: ['4시', '4시 30분', '5시', '5시 30분', '6시', '6시 30분', '7시', '7시 30분', '8시'],
                hint: '목표 기상시간'
              ),
              const SizedBox(height: 30,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('모드 선택', style: TextStyle(fontSize: 16.0),),
                  SizedBox(width: 5,),
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
              const CustomRadioButton(
                  options: ['마일드 모드', '챌린지 모드'],
              ),
              const SizedBox(height: 30,),
              const Text('환급 받을 계좌', style: TextStyle(fontSize: 16.0),),
              const SizedBox(height: 10,),
              const CustomDropdown(options: ['국민', '우리', '기업', '카카오뱅크', '신한', '농협'], hint: '은행',),
              const SizedBox(height: 10,),
              CustomTextFormField(
                  textController: bankAccountController,
                  placeHolder: '계좌 번호'
              ),
              const SizedBox(height: 30,),


              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.exclamationmark, color: Color(0xFFFF0000)),
                  Text('꼭 확인해주세요', style: TextStyle(color: Color(0xFFFF0000), fontSize: 18),),
                  Icon(CupertinoIcons.exclamationmark, color: Color(0xFFFF0000))
                ],
              ),
              const SizedBox(height: 10,),
              const Text('입금 계좌: [토스뱅크 100067440674 김유민]', style: TextStyle(fontSize: 15),),
              const SizedBox(height: 8,),
              const Text('마일드모드: 30,000원\n챌린지모드: 50,000원', style: TextStyle(fontSize: 15),),
              const SizedBox(height: 8,),
              const Text('보증금을 입금해주시면 입금 확인 후 승인됩니다. 입금이 안 된 경우 신청이 반려될 수 있습니다.', style: TextStyle(fontSize: 15),),
              const SizedBox(height: 30,),
              CustomElevatedButton(text: '신청 완료', onPressed: (){
                // TODO
              }),
            ],
          ),
        ),
      ),
    );
  }
}
