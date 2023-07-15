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
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.w600
          ),
        ),
        SizedBox.fromSize(size: const Size(0, 5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GREY_COLOR,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            )
          ),
        )
      ],
    );
  }
}
