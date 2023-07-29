import 'package:dio/dio.dart';
import 'package:morning_holic_app/clients/dio_client.dart';
import 'package:morning_holic_app/payloads/request/sign_up_request.dart';

import '../payloads/request/login_request.dart';
import '../payloads/response/jwt_token_response.dart';

class AuthRepository {
  late DioClient _dioClient;

  AuthRepository() {
    _dioClient = DioClient();
  }

  Future<bool> validateSignUp(String phoneNumber) async {
    try {
      final response = await _dioClient.dioWithoutAccessToken.get(
          '/auth/sign-up/validate',
          queryParameters: {
            'phoneNumber': phoneNumber,
          }
      );
      return response.data as bool;
    } catch (e) {
      rethrow;
    }
  }

  signUp(SignUpRequest request) async {
    try {
      final response = await _dioClient.dioWithoutAccessToken.post('/auth/sign-up', data: request.toJson());
      final jwtToken = JwtTokenResponse.fromJson(response.data);
      _dioClient.setUserInfo(jwtToken);
    } on DioException catch (e) {
      if (e.response?.data?['code'] == 1003) {
        return e.response!.data['message'];
      }
      throw e;
    }
  }

  login(LoginRequest loginRequest) async{
    try{
      final response = await _dioClient.dio.post('/auth/login', data: loginRequest.toJson());
      final jwtToken = JwtTokenResponse.fromJson(response.data);
      _dioClient.setUserInfo(jwtToken);
    } on DioException catch (e){
      print(e);
      if (e.response?.data is Map && e.response?.data['code'] == 1003) {
        // if (e.response?.data?['code'] == 1003) {
        return e.response!.data['message'];
      }
      throw e;
    }
  }
}