import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomAppBar extends PreferredSize {
  final BuildContext context;
  final bool hasIcon;
  CustomAppBar({
    required this.context,
    this.hasIcon = true,
    super.key,
  }) : super(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        elevation: 0,
        leading: hasIcon
          ? IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        )
        : null,
      )
  );
}