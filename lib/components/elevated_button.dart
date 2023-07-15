import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  Color buttonColor;
  Color textColor;
  double buttonWidth;
  double buttonHeight;
  double fontSize;
  FontWeight fontWeight;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.buttonColor = PRIMARY_COLOR,
    this.textColor = Colors.white,
    this.buttonWidth = 320.0,
    this.buttonHeight = 44.0,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w500,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            fixedSize: Size(buttonWidth, buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
