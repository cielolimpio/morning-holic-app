// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserStatusResponse _$GetUserStatusResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserStatusResponse(
      userStatus: $enumDecode(_$UserStatusEnumEnumMap, json['userStatus']),
      rejectReason: json['rejectReason'] ?? "",
    );

Map<String, dynamic> _$GetUserStatusResponseToJson(
        GetUserStatusResponse instance) =>
    <String, dynamic>{
      'userStatus': _$UserStatusEnumEnumMap[instance.userStatus]!,
      'rejectReason': instance.rejectReason,
    };

const _$UserStatusEnumEnumMap = {
  UserStatusEnum.INITIAL: 'INITIAL',
  UserStatusEnum.REQUEST: 'REQUEST',
  UserStatusEnum.ACCEPT: 'ACCEPT',
  UserStatusEnum.REJECT: 'REJECT',
};
