import 'package:json_annotation/json_annotation.dart';
import 'package:morning_holic_app/enums/UserStatusEnum.dart';

part 'get_user_status_response.g.dart';

@JsonSerializable()
class GetUserStatusResponse {
  final UserStatusEnum userStatus;
  var rejectReason;

  GetUserStatusResponse({
    required this.userStatus,
    this.rejectReason = ""
  });

  factory GetUserStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserStatusResponseToJson(this);
}