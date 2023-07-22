
import 'package:dio/dio.dart';
import 'package:morning_holic_app/clients/dio_client.dart';

import '../payloads/request/register_request.dart';
import '../payloads/response/jwt_token_response.dart';

class UserRepository{
  late DioClient _dioClient;

  UserRepository(){
    _dioClient = DioClient();
  }

  register(RegisterRequest request) async {
    try {
      await _dioClient.dio.post('/user/register', data: request.toJson());
    } on DioException catch (e) {
      if ([2001, 2002, 2003].contains(e.response?.data?['code'])) {
        return e.response!.data['message'];
      }
      rethrow;
    }
  }
}