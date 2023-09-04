import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:morning_holic_app/payloads/response/jwt_token_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio _dio;
  late Dio _dioWithoutAccessToken;
  final _storage = const FlutterSecureStorage();

  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  Dio get dio => _dio;

  Dio get dioWithoutAccessToken => _dioWithoutAccessToken;

  var options = BaseOptions(
    baseUrl: 'http://54.180.78.85:9001/api/',
    // baseUrl: 'http://localhost:9000/api/',
    contentType: Headers.jsonContentType,
  );

  DioClient._internal() {
    _dioWithoutAccessToken = Dio(options);
    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await _getAccessToken();
        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.data['code'] == 1) {
          final isSuccess = await refreshAccessToken();
          if (isSuccess) {
            return handler.resolve(
              await _dioWithoutAccessToken.request(
                error.requestOptions.path,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
                options: _getOptionsFromRequestOptions(error.requestOptions),
              ),
            );
          }
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response: Response(
                statusCode: 400,
                requestOptions: error.requestOptions,
              ),
              message: 'Fail To Refresh Access Token',
            ),
          );
        }
        return handler.next(error);
      },
    ));
  }

  setUserInfo(JwtTokenResponse jwtToken) async {
    await _setAccessToken(jwtToken.accessToken);
    await _setRefreshToken(jwtToken.refreshToken);
    await _setUserId(jwtToken.userId);
  }

  _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  _setAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  _getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  _setRefreshToken(String refreshToken) async {
    await _storage.write(key: 'accessToken', value: refreshToken);
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  _setUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  Future<bool> refreshAccessToken() async {
    String? refreshToken = await _getRefreshToken();
    if (refreshToken != null) {
      final response = await _dio.post(
          '/auth/refresh', data: {'refreshToken': refreshToken});

      if (response.statusCode == 200) {
        await _setAccessToken(response.data['accessToken']);
        await _setRefreshToken(response.data['refreshToken']);
        return true;
      }
    }

    return false;
  }

  Options _getOptionsFromRequestOptions(RequestOptions requestOptions) {
    return Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      contentType: requestOptions.contentType,
      responseType: requestOptions.responseType,
    );
  }
}
