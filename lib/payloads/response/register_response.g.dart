// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      targetWakeUpTime: DateTime.parse(json['targetWakeUpTime'] as String),
      refundBankNameAndAccount: json['refundBankNameAndAccount'] as String,
      mode: $enumDecode(_$ModeEnumEnumMap, json['mode']),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'targetWakeUpTime': instance.targetWakeUpTime.toIso8601String(),
      'refundBankNameAndAccount': instance.refundBankNameAndAccount,
      'mode': _$ModeEnumEnumMap[instance.mode]!,
    };

const _$ModeEnumEnumMap = {
  ModeEnum.MILD: 'MILD',
  ModeEnum.CHALLENGE: 'CHALLENGE',
};
