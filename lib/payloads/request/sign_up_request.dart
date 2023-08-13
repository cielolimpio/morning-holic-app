import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  final String name;
  final String phoneNumber;
  final String password;
  final String profileEmoji;
  final String nickname;

  SignUpRequest({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.profileEmoji,
    required this.nickname,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
