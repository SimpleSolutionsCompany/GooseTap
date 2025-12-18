// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClickResponse _$ClickResponseFromJson(Map<String, dynamic> json) =>
    ClickResponse(
      balance: (json['balance'] as num).toInt(),
      currentEnergy: (json['currentEnergy'] as num).toInt(),
      profitPerClick: (json['profitPerClick'] as num).toInt(),
      energyRestorePerSecond: (json['energyRestorePerSecond'] as num).toInt(),
    );

Map<String, dynamic> _$ClickResponseToJson(ClickResponse instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'currentEnergy': instance.currentEnergy,
      'profitPerClick': instance.profitPerClick,
      'energyRestorePerSecond': instance.energyRestorePerSecond,
    };
