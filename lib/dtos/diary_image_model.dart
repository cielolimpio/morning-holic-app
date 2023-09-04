class DiaryImageModel {
  String? imagePath;
  int minusScore = 0;
  DateTime? dateTime;

  DiaryImageModel({
    this.imagePath,
    required this.minusScore,
    this.dateTime,
  });
}