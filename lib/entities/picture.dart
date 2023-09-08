import 'dart:typed_data';

class Picture {
  int? id;
  Uint8List? picture;
  int minusScore;
  String? datetime;

  Picture({
    this.id,
    required this.picture,
    required this.minusScore,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "picture": picture,
      "minusScore": minusScore,
      "datetime": datetime,
    };
  }
}
