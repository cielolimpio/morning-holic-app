// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      targetWakeUpTime: TargetWakeUpTimeModel.fromJson(
          json['targetWakeUpTime'] as Map<String, dynamic>),
      refundBankNameAndAccount: json['refundBankNameAndAccount'] as String,
      mode: $enumDecode(_$ModeEnumEnumMap, json['mode']),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'targetWakeUpTime': instance.targetWakeUpTime,
      'refundBankNameAndAccount': instance.refundBankNameAndAccount,
      'mode': _$ModeEnumEnumMap[instance.mode]!,
    };

const _$ModeEnumEnumMap = {
  ModeEnum.MILD: 'MILD',
  ModeEnum.CHALLENGE: 'CHALLENGE',
};
