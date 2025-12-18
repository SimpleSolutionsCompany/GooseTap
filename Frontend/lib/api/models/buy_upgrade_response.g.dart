// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_upgrade_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyUpgradeResponse _$BuyUpgradeResponseFromJson(Map<String, dynamic> json) =>
    BuyUpgradeResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      newBalance: (json['newBalance'] as num).toInt(),
      newLevel: (json['newLevel'] as num).toInt(),
      nextLevelPrice: (json['nextLevelPrice'] as num).toInt(),
      effectValue: (json['effectValue'] as num).toInt(),
    );

Map<String, dynamic> _$BuyUpgradeResponseToJson(BuyUpgradeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'newBalance': instance.newBalance,
      'newLevel': instance.newLevel,
      'nextLevelPrice': instance.nextLevelPrice,
      'effectValue': instance.effectValue,
    };
