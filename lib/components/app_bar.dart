import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomAppBar extends PreferredSize {
  final BuildContext context;
  final double horizontalPadding;
  Widget? leading;
  final String title;
  final bool centerTitle;

  CustomAppBar({
    required this.context,
    this.horizontalPadding = 30.0,
    this.leading,
    this.title = '',
    this.centerTitle = false,
    super.key,
  }) : super(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: AppBar(
              backgroundColor: BACKGROUND_COLOR,
              elevation: 0,
              leading: leading,
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: centerTitle,
            ),
          ),
        );
}
