import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/text_form_field.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/dtos/sign_up_model.dart';
import 'package:morning_holic_app/payloads/request/sign_up_request.dart';
import 'package:morning_holic_app/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../components/elevated_button.dart';

class NicknameSettingScreen extends StatefulWidget {
  const NicknameSettingScreen({super.key});

  @override
  State<NicknameSettingScreen> createState() => _NicknameSettingScreenState();
}

class _NicknameSettingScreenState extends State<NicknameSettingScreen> {
  bool isValidatorOn = false;
  bool isNicknameDuplicated = false;
  bool isEmojiPickerOn = false;

  TextEditingController nicknameController = TextEditingController();
  TextEditingController profileEmojiController = TextEditingController();

  String profileEmoji = '🌞';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isEmojiPickerOn = false;
                    });
                  },
                  child: Container(
                    color: BACKGROUND_COLOR,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CustomTitle(
                          title: '프로필 설정하기',
                          description:
                              '앱에서 사용할 프로필 이모지와 닉네임을 설정하세요. 나중에 언제든지 변경할 수 있습니다.',
                        ),
                        SizedBox.fromSize(size: const Size(0, 30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isEmojiPickerOn = !isEmojiPickerOn;
                                      profileEmojiController.text = '';
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    foregroundColor: BACKGROUND_COLOR,
                                  ),
                                  child: Text(
                                    profileEmoji,
                                    style: const TextStyle(fontSize: 36.0),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isEmojiPickerOn = !isEmojiPickerOn;
                                      profileEmojiController.text = '';
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    foregroundColor: BACKGROUND_COLOR,
                                  ),
                                  child: const Text(
                                    '선택',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: SizedBox(
                                height: 47.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                      child: CustomTextFormField(
                                        textController: nicknameController,
                                        placeHolder: '닉네임',
                                        maxLength: 20,
                                        validator: nicknameValidator,
                                        isValidatorOn: isValidatorOn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox.fromSize(size: const Size(0, 30)),
                        CustomElevatedButton(
                          text: '다음',
                          onPressed: buttonOnPressed,
                        ),
                        const SizedBox(height: 100.0),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Offstage(
                    offstage: !isEmojiPickerOn,
                    child: EmojiPicker(
                      textEditingController: profileEmojiController,
                      onEmojiSelected: (Category? category, Emoji emoji) {
                        setState(() {
                          profileEmoji = profileEmojiController.text;
                          profileEmojiController.text = '';
                        });
                      },
                      onBackspacePressed: () {},
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 28 *
                            (foundation.defaultTargetPlatform ==
                                TargetPlatform.iOS
                                ? 1.30
                                : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.SMILEYS,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: PRIMARY_COLOR,
                        iconColor: GREY_COLOR,
                        iconColorSelected: PRIMARY_COLOR,
                        backspaceColor: const Color(0xFFF2F2F2),
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: GREY_COLOR,
                        enableSkinTones: true,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        loadingIndicator: const SizedBox.shrink(),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                        checkPlatformCompatibility: true,
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
    final signUpRequest =
        ModalRoute.of(context)!.settings.arguments as SignUpModel;

    SignUpRequest request = SignUpRequest(
      name: signUpRequest.name,
      phoneNumber: signUpRequest.phoneNumber,
      password: signUpRequest.password,
      profileEmoji: profileEmoji,
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
