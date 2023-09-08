import 'package:dio/dio.dart';
import 'package:morning_holic_app/clients/dio_client.dart';
import 'package:morning_holic_app/payloads/request/upload_diary_request.dart';

class DiaryRepository {
  late DioClient _dioClient;

  DiaryRepository() {
    _dioClient = DioClient();
  }

  uploadDiary(UploadDiaryRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/diary',
        data: request.toJson()
      );
    } on DioException catch (e) {
      print(e);
    }
  }
}