// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      refundBankName: json['refundBankName'] as String,
      refundAccount: json['refundAccount'] as String,
      mode: json['mode'] as String,
      targetWakeUpTime: json['targetWakeUpTime'] as String,
    );

Map<String, dynamic> _$SignUpRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'refundBankName': instance.refundBankName,
      'refundAccount': instance.refundAccount,
      'mode': instance.mode,
      'targetWakeUpTime': instance.targetWakeUpTime,
    };
