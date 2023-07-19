
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
      final response = await _dioClient.dio.post('/user/register', data: request.toJson());
      final jwtToken = JwtTokenResponse.fromJson(response.data);
      _dioClient.setUserInfo(jwtToken);
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['code'] == 1003) {
      // if (e.response?.data?['code'] == 1003) {
        return e.response!.data['message'];
      }
      rethrow;
    }
  }
}