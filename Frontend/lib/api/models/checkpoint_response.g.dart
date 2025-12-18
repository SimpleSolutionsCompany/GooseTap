// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckpointResponse _$CheckpointResponseFromJson(Map<String, dynamic> json) =>
    CheckpointResponse(
      balance: (json['balance'] as num?)?.toInt(),
      energy: (json['energy'] as num?)?.toInt(),
      maxEnergy: (json['maxEnergy'] as num?)?.toInt(),
      profitPerHour: (json['profitPerHour'] as num?)?.toDouble(),
      offlineIncome: (json['offlineIncome'] as num?)?.toDouble(),
      lastSyncDate: json['lastSyncDate'] == null
          ? null
          : DateTime.parse(json['lastSyncDate'] as String),
      level: (json['level'] as num?)?.toInt(),
      rank: json['rank'] as String?,
      multitapLevel: (json['multitapLevel'] as num?)?.toInt(),
      energyLimitLevel: (json['energyLimitLevel'] as num?)?.toInt(),
      rechargeSpeedLevel: (json['rechargeSpeedLevel'] as num?)?.toInt(),
      profitPerClick: (json['profitPerClick'] as num?)?.toInt(),
      energyRestorePerSecond: (json['energyRestorePerSecond'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckpointResponseToJson(CheckpointResponse instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'energy': instance.energy,
      'maxEnergy': instance.maxEnergy,
      'profitPerHour': instance.profitPerHour,
      'offlineIncome': instance.offlineIncome,
      'lastSyncDate': instance.lastSyncDate?.toIso8601String(),
      'level': instance.level,
      'rank': instance.rank,
      'multitapLevel': instance.multitapLevel,
      'energyLimitLevel': instance.energyLimitLevel,
      'rechargeSpeedLevel': instance.rechargeSpeedLevel,
      'profitPerClick': instance.profitPerClick,
      'energyRestorePerSecond': instance.energyRestorePerSecond,
    };
