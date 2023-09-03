import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomAppBar extends PreferredSize {
  final BuildContext context;
  final double horizontalPadding;
  Widget? leading;
  double leadingWidth;
  final String title;
  final bool centerTitle;
  final bool hasBottomLine;

  CustomAppBar({
    required this.context,
    this.horizontalPadding = 30.0,
    this.leading,
    this.leadingWidth = 30.0,
    this.title = '',
    this.centerTitle = false,
    this.hasBottomLine = false,
    super.key,
  }) : super(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: AppBar(
              backgroundColor: BACKGROUND_COLOR,
              elevation: 0,
              leading: leading,
              leadingWidth: leadingWidth,
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: centerTitle,
              bottom: hasBottomLine
                  ? const PreferredSize(
                      preferredSize: Size(double.maxFinite, 1),
                      child:
                          Divider(thickness: 1, color: GREY_COLOR, height: 1),
                    )
                  : null,
            ),
          ),
        );
}
