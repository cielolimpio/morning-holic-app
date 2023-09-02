
import 'package:dio/dio.dart';
import 'package:morning_holic_app/clients/dio_client.dart';
import 'package:morning_holic_app/payloads/response/user_info_response.dart';

import '../payloads/request/login_request.dart';
import '../payloads/request/register_request.dart';
import '../payloads/response/jwt_token_response.dart';
import '../payloads/response/register_response.dart';

class UserRepository{
  late DioClient _dioClient;

  UserRepository(){
    _dioClient = DioClient();
  }

  Future<UserInfoResponse> getUserInfo() async {
    try {
      final response = await _dioClient.dio.get('/user/info');
      return UserInfoResponse.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<RegisterResponse> getRegisterData() async {
    try {
      final response = await _dioClient.dio.get('/user/register');
      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
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