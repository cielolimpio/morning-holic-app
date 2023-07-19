
import 'package:json_annotation/json_annotation.dart';

part 'jwt_token_response.g.dart';

@JsonSerializable()
class JwtTokenResponse {
  final int userId;
  final String accessToken;
  final String refreshToken;

  JwtTokenResponse({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory JwtTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$JwtTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JwtTokenResponseToJson(this);
}
