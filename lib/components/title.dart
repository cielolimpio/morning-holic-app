import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String description;

  const CustomTitle({
    required this.title,
    required this.description,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.w600
          ),
        ),
        SizedBox.fromSize(size: const Size(0, 5)),
        Text(
          description,
          style: TextStyle(
            color: GREY_COLOR,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          )
        )
      ],
    );
  }
}
