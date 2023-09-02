import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/components/title.dart';
import 'package:morning_holic_app/components/toggle_button.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/enums/DiaryTypeEnum.dart';
import 'package:provider/provider.dart';

import '../provider/diary_home_state.dart';


class DiaryHomeScreen extends StatefulWidget {
  const DiaryHomeScreen({Key? key}) : super(key: key);

  @override
  State<DiaryHomeScreen> createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTitle(
                  title: '인증', icon: Icons.home, hasHorizontalLine: true,),
              ],
            ),
            const Divider(thickness: 1, color: GREY_COLOR, height: 1),
            SizedBox(height: 15,),
            Text(
              "루틴 시작 인증까지 남은 시간 : 00 : 21 : 49",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 15,),

            // TODO : 실내, 야외 선택 버튼
            CustomToggleButton(
              contents: <Widget>[
                Text("실내"),
                Text("야외")
              ],
              selectedContents: <bool>[true, false],
            ),

            SizedBox(height: 15,),

            Column(
              children: [

                // 기상 인증 ROW
                Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _){
                  if(diaryHomeState.wakeupImage != null){
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle),
                          color: PRIMARY_COLOR,
                          iconSize: 30.0,
                        ),
                        Text("기상 인증"),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt),
                          color: GREY_COLOR,
                        )
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle),
                          color: GREY_COLOR,
                          iconSize: 30.0,
                        ),
                        Text("기상 인증"),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt),
                        )
                      ],
                    );
                  }
                }),

                // 루틴 시작 인증 ROW
                Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
                  if(diaryHomeState.diaryType == DiaryTypeEnum.INDOOR){
                    return Column(
                      children: [
                        Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _){
                          if(diaryHomeState.routineStartImage != null){
                           return Row(
                             children: [
                               IconButton(
                                 onPressed: () {},
                                 icon: const Icon(Icons.check_circle),
                                 color: PRIMARY_COLOR,
                                 iconSize: 30.0,
                               ),
                               Text("루틴 시작 인증"),
                               Spacer(),
                               IconButton(
                                 onPressed: () {},
                                 icon: Icon(Icons.camera_alt),
                                 color: GREY_COLOR,
                               ),
                             ],
                           );
                          } else {
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  color: GREY_COLOR,
                                  iconSize: 30.0,
                                ),
                                Text("루틴 시작 인증"),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.camera_alt),
                                ),
                              ],
                            );
                          }
                        }),

                        // 루틴 끝 인증 ROW
                        Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _){
                          if(diaryHomeState.routineImage != null){
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  color: PRIMARY_COLOR,
                                  iconSize: 30.0,
                                ),
                                Text("루틴 끝 인증"),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.camera_alt),
                                  color: GREY_COLOR,
                                )
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  color: GREY_COLOR,
                                  iconSize: 30.0,
                                ),
                                Text("루틴 끝 인증"),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.camera_alt),
                                )
                              ],
                            );
                          }
                        }),
                      ],
                    );
                  } else { // 야외
                    return Column(
                      children: [
                        Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _){
                          if(diaryHomeState.routineImage != null){
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  color: PRIMARY_COLOR,
                                  iconSize: 30.0,
                                ),
                                Text("루틴 인증"),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.camera_alt),
                                  color: GREY_COLOR,
                                )
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  color: GREY_COLOR,
                                  iconSize: 30.0,
                                ),
                                Text("루틴 인증"),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.camera_alt),
                                )
                              ],
                            );
                          }

                        }),
                      ],
                    );
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
