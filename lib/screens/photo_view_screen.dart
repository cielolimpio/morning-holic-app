import 'dart:io';

import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:morning_holic_app/provider/diary_home_state.dart';
import 'package:provider/provider.dart';

class PhotoViewScreen extends StatelessWidget {
  final Picture picture;

  const PhotoViewScreen({
    required this.picture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: SafeArea(
          child: Image.memory(picture.picture!),
      ),
    );
  }

  PreferredSize _getAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
        return CustomAppBar(
          context: context,
          horizontalPadding: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: "${diaryHomeState.currentDiaryImageType.displayName} 인증",
          centerTitle: true,
        );
      }),
    );
  }
}
