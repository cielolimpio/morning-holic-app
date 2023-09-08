import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomTitle extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String description;
  final bool hasHorizontalLine;

  const CustomTitle({
    required this.title,
    this.description = "",
    this.icon,
    this.hasHorizontalLine = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            if(icon != null)
              Icon(
                icon,
                size: 22.0,
              ),
            if(icon != null)
              const SizedBox(width: 5.0,),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
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
        ),
      ],
    );
  }
}
