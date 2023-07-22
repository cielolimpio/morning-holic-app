// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      refundBankName: json['refundBankName'] as String,
      refundAccount: json['refundAccount'] as String,
      mode: json['mode'] as String,
      targetWakeUpTime: DateTime.parse(json['targetWakeUpTime'] as String),
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'refundBankName': instance.refundBankName,
      'refundAccount': instance.refundAccount,
      'mode': instance.mode,
      'targetWakeUpTime': instance.targetWakeUpTime.toIso8601String(),
    };
