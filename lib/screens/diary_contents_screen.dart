import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:morning_holic_app/enums/diary_image_type_enum.dart';
import 'package:morning_holic_app/enums/diary_type_enum.dart';
import 'package:morning_holic_app/payloads/request/diary_image_request.dart';
import 'package:morning_holic_app/payloads/request/upload_diary_request.dart';
import 'package:morning_holic_app/provider/diary_home_state.dart';
import 'package:morning_holic_app/provider/user_info_state.dart';
import 'package:morning_holic_app/repositories/diary_repository.dart';
import 'package:morning_holic_app/repositories/image_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:image/image.dart' as img;

class DiaryContentsScreen extends StatefulWidget {
  const DiaryContentsScreen({super.key});

  @override
  State<DiaryContentsScreen> createState() => _DiaryContentsScreenState();
}

class _DiaryContentsScreenState extends State<DiaryContentsScreen> {
  TextEditingController contentController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int _currentPage = 0;
  List<Uint8List> images = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final diaryHomeState = Provider.of<DiaryHomeState>(context, listen: false);

    List<Picture?> items;
    if (diaryHomeState.routineImage == null) {
      items = [
        diaryHomeState.wakeUpImage,
        diaryHomeState.routineStartImage,
        diaryHomeState.routineEndImage
      ];
    } else {
      items = [diaryHomeState.wakeUpImage, diaryHomeState.routineImage];
    }
    images = items
        .where((element) => element?.picture != null)
        .map((e) => e!.picture!)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _getAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                _getProfileRow(),
                _getContentsField(),
                const SizedBox(height: 10),
                _getImages(),
                _getIndicators(),
                const SizedBox(height: 10),
                _getButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _getAppBar(BuildContext context) {
    return CustomAppBar(
      context: context,
      leading: const Icon(
        Icons.edit,
        size: 30.0,
        color: Colors.black87,
      ),
      title: '다이어리',
      hasBottomLine: true,
    );
  }

  Widget _getProfileRow() {
    return Consumer<UserInfoState>(builder: (builder, userInfoState, _) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userInfoState.profileEmoji!,
            style: const TextStyle(fontSize: 34.0),
          ),
          const SizedBox(width: 10),
          Text(
            userInfoState.nickname!,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    });
  }

  Widget _getContentsField() {
    return Scrollbar(
      controller: scrollController,
      child: TextFormField(
        controller: contentController,
        scrollController: scrollController,
        cursorColor: GREY_COLOR,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10.0,
          ),
          labelText: '다이어리를 작성해주세요.\n\n',
          labelStyle: TextStyle(color: GREY_COLOR),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        maxLines: 4,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget _getImages() {
    return Consumer<DiaryHomeState>(builder: (builder, diaryHomeState, _) {
      return Stack(children: [
        CarouselSlider(
          items: images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.memory(i);
              },
            );
          }).toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, _) {
                setState(() {
                  _currentPage = index;
                });
              }),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
            ),
          ),
      ]);
    });
  }

  Widget _getIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images
          .asMap()
          .entries
          .map((e) => Container(
                width: _currentPage == e.key ? 9.0 : 8.0,
                height: _currentPage == e.key ? 9.0 : 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == e.key
                        ? Colors.black87
                        : GREY_COLOR_FOR_BUTTON),
              ))
          .toList(),
    );
  }

  Widget _getButton() {
    return CustomElevatedButton(
      text: '다이어리 등록',
      onPressed: _getButtonOnPressed(context),
    );
  }

  VoidCallback _getButtonOnPressed(BuildContext context) {
    return () async {
      setState(() {
        isLoading = true;
      });
      DiaryRepository diaryRepository = DiaryRepository();

      final diaryHomeState =
          Provider.of<DiaryHomeState>(context, listen: false);
      final userInfoState = Provider.of<UserInfoState>(context, listen: false);
      int userId = userInfoState.userId!;

      UploadDiaryRequest request;

      DiaryImageRequest? wakeUpDiaryImageRequest;
      if (diaryHomeState.wakeUpImage!.picture != null) {
        await _uploadToS3(userId: userId, picture: diaryHomeState.wakeUpImage!);
        wakeUpDiaryImageRequest = _getDiaryImageRequest(
            userId: userId,
            diaryImageType: DiaryImageTypeEnum.WAKE_UP,
            picture: diaryHomeState.wakeUpImage!);
      }

      if (diaryHomeState.diaryType == DiaryTypeEnum.INDOOR) {
        await _uploadToS3(
            userId: userId, picture: diaryHomeState.routineStartImage!);
        DiaryImageRequest routineStartDiaryImageRequest = _getDiaryImageRequest(
            userId: userId,
            diaryImageType: DiaryImageTypeEnum.ROUTINE_START,
            picture: diaryHomeState.routineStartImage!);
        await _uploadToS3(
            userId: userId, picture: diaryHomeState.routineEndImage!);
        DiaryImageRequest routineEndDiaryImageRequest = _getDiaryImageRequest(
            userId: userId,
            diaryImageType: DiaryImageTypeEnum.ROUTINE_END,
            picture: diaryHomeState.routineEndImage!);

        request = UploadDiaryRequest(
          diaryType: DiaryTypeEnum.INDOOR,
          diaryImages: wakeUpDiaryImageRequest != null
              ? [
                  wakeUpDiaryImageRequest,
                  routineStartDiaryImageRequest,
                  routineEndDiaryImageRequest
                ]
              : [routineStartDiaryImageRequest, routineEndDiaryImageRequest],
          diaryContent: contentController.text,
        );
      } else {
        await _uploadToS3(
            userId: userId, picture: diaryHomeState.routineImage!);
        DiaryImageRequest routineDiaryImageRequest = _getDiaryImageRequest(
            userId: userId,
            diaryImageType: DiaryImageTypeEnum.ROUTINE,
            picture: diaryHomeState.routineImage!);

        request = UploadDiaryRequest(
          diaryType: DiaryTypeEnum.OUTDOOR,
          diaryImages: wakeUpDiaryImageRequest != null
              ? [wakeUpDiaryImageRequest, routineDiaryImageRequest]
              : [routineDiaryImageRequest],
          diaryContent: contentController.text,
        );
      }

      try {
        diaryRepository.uploadDiary(request);
        setState(() {
          isLoading = false;
        });
        // TODO: navigator to home
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
      }
    };
  }

  DiaryImageRequest _getDiaryImageRequest({
    required int userId,
    required DiaryImageTypeEnum diaryImageType,
    required Picture picture,
  }) {
    DateTime datetime = DateTime.parse(picture.datetime!);
    return DiaryImageRequest(
      originalS3Path: _getOriginalS3Path(userId: userId, picture: picture),
      thumbnailS3Path: _getThumbnailS3Path(userId: userId, picture: picture),
      diaryImageType: diaryImageType,
      datetime: datetime.toUtc(),
      timezone: datetime.timeZoneName,
      timezoneOffset: datetime.timeZoneOffset.inMinutes,
      minusScore: picture.minusScore,
    );
  }

  _uploadToS3({required int userId, required Picture picture}) async {
    ImageRepository imageRepository = ImageRepository();

    String originalS3Path =
        _getOriginalS3Path(userId: userId, picture: picture);
    await imageRepository.uploadToS3(
      picture: picture.picture!,
      s3Path: originalS3Path,
    );

    String dir = (await getTemporaryDirectory()).path;
    File temp = File('$dir/${picture.datetime.hashCode}.png');
    final cmd = img.Command()
      ..decodeImage(picture.picture!)
      ..copyResize(width: 700)
      ..writeToFile(temp.path);

    await cmd.executeThread();

    String thumbnailS3Path =
        _getThumbnailS3Path(userId: userId, picture: picture);
    await imageRepository.uploadToS3(
      picture: temp.readAsBytesSync(),
      s3Path: thumbnailS3Path,
    );
  }

  String _getOriginalS3Path({required int userId, required Picture picture}) {
    DateTime datetime = DateTime.parse(picture.datetime!);
    return "morning-holic/images/user_$userId/"
        "${datetime.year % 100}${datetime.month.toString().padLeft(2, '0')}${datetime.day.toString().padLeft(2, '0')}/"
        "${datetime.hashCode}.png";
  }

  String _getThumbnailS3Path({required int userId, required Picture picture}) {
    DateTime datetime = DateTime.parse(picture.datetime!);
    return "morning-holic/thumbnails/user_$userId/"
        "${datetime.year % 100}${datetime.month.toString().padLeft(2, '0')}${datetime.day.toString().padLeft(2, '0')}/"
        "${datetime.hashCode}.png";
  }
}
