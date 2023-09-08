import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:morning_holic_app/clients/dio_client.dart';
import 'package:http/http.dart' as http;
import 'package:morning_holic_app/entities/picture.dart';

class ImageRepository {
  late DioClient _dioClient;

  ImageRepository() {
    _dioClient = DioClient();
  }

  Future<int> uploadToS3({required Uint8List picture, required String s3Path}) async {
    try {
      String presignedUrl = await getPresignedUrl(s3Path);
      http.Response response = await http.put(Uri.parse(presignedUrl), body: picture);
      return response.statusCode;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<String> getPresignedUrl(String s3Path) async {
    try {
      final response = await _dioClient.dio.get(
        '/image/presigned-url',
        queryParameters: {
          's3Path': s3Path
        }
      );
      return response.data;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}