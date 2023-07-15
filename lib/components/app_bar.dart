import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomAppBar extends PreferredSize {
  final BuildContext context;
  CustomAppBar({
    required this.context,
    super.key,
  }) : super(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      )
  );
}