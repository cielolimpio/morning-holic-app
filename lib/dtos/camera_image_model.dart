class CameraImageModel {
  final String imagePath;
  final bool isFromBackCamera;
  final String formattedDatetime;
  final DateTime datetime;

  CameraImageModel({
    required this.imagePath,
    required this.isFromBackCamera,
    required this.formattedDatetime,
    required this.datetime,
  });
}
