// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JwtTokenResponse _$JwtTokenResponseFromJson(Map<String, dynamic> json) =>
    JwtTokenResponse(
      userId: json['userId'] as int,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$JwtTokenResponseToJson(JwtTokenResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
