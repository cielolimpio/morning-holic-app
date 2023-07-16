import 'package:dio/dio.dart';
import 'package:morning_holic_app/clients/dio_client.dart';
import 'package:morning_holic_app/payloads/request/sign_up_request.dart';

import '../payloads/response/jwt_token_response.dart';

class AuthRepository {
  late DioClient _dioClient;

  AuthRepository() {
    _dioClient = DioClient();
  }

  Future<JwtTokenResponse> signUp(SignUpRequest request) async {
    try {
      final response = await _dioClient.dioWithoutAccessToken.post('/auth/sign-up', data: request.toJson());
      return JwtTokenResponse.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}