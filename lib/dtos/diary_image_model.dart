class DiaryImageModel {
  String? imagePath;
  int minusScore = 0;
  DateTime? datetime;

  DiaryImageModel({
    this.imagePath,
    required this.minusScore,
    this.datetime,
  });
}