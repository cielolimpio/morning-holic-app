import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/enums/diary_type_enum.dart';
import 'package:morning_holic_app/provider/diary_home_state.dart';
import 'package:provider/provider.dart';

class CustomToggleButton extends StatefulWidget {
  final List<bool> selectedContents;
  final List<Widget> contents;

  CustomToggleButton(
      {Key? key, required this.contents, required this.selectedContents})
      : super(key: key);

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool vertical = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
        return ToggleButtons(
          direction: vertical ? Axis.vertical : Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < widget.selectedContents.length; i++) {
                widget.selectedContents[i] = (i == index);
              }
              if (widget.selectedContents[index] && index == 0) {
                diaryHomeState.updateDiaryType(DiaryTypeEnum.INDOOR);
              } else {
                diaryHomeState.updateDiaryType(DiaryTypeEnum.OUTDOOR);
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: PRIMARY_COLOR,
          borderColor: GREY_COLOR_FOR_BUTTON,
          selectedColor: Colors.white,
          fillColor: PRIMARY_COLOR,
          color: Colors.white,
          splashColor: PRIMARY_COLOR,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 150.0,
          ),
          isSelected: widget.selectedContents,
          children: widget.contents.indexed
              .map(
                (e) => widget.selectedContents[e.$1]
                    ? e.$2
                    : Container(
                        width: 150.0,
                        height: 40.0,
                        color: GREY_COLOR_FOR_BUTTON,
                        child: Center(
                          child: e.$2,
                        ),
                      ),
              )
              .toList(),
        );
      }),
    );
  }
}
