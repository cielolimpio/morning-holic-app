// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      userId: json['userId'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      nickname: json['nickname'] as String,
      targetWakeUpTime: json['targetWakeUpTime'] == null
          ? null
          : TargetWakeUpTimeModel.fromJson(
              json['targetWakeUpTime'] as Map<String, dynamic>),
      refundBankName:
          $enumDecodeNullable(_$BankEnumEnumMap, json['refundBankName']),
      refundAccount: json['refundAccount'] as String?,
      mode: $enumDecodeNullable(_$ModeEnumEnumMap, json['mode']),
      status: $enumDecode(_$UserStatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'nickname': instance.nickname,
      'targetWakeUpTime': instance.targetWakeUpTime,
      'refundBankName': _$BankEnumEnumMap[instance.refundBankName],
      'refundAccount': instance.refundAccount,
      'mode': _$ModeEnumEnumMap[instance.mode],
      'status': _$UserStatusEnumEnumMap[instance.status]!,
    };

const _$BankEnumEnumMap = {
  BankEnum.KOOKMIN: 'KOOKMIN',
  BankEnum.SHINHAN: 'SHINHAN',
  BankEnum.KAKAO: 'KAKAO',
  BankEnum.WOORI: 'WOORI',
  BankEnum.SC: 'SC',
  BankEnum.INDUSTRIAL: 'INDUSTRIAL',
  BankEnum.NONGHYUP: 'NONGHYUP',
};

const _$ModeEnumEnumMap = {
  ModeEnum.MILD: 'MILD',
  ModeEnum.CHALLENGE: 'CHALLENGE',
};

const _$UserStatusEnumEnumMap = {
  UserStatusEnum.INITIAL: 'INITIAL',
  UserStatusEnum.REQUEST: 'REQUEST',
  UserStatusEnum.ACCEPT: 'ACCEPT',
  UserStatusEnum.REJECT: 'REJECT',
};
