// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpgradeModel _$UpgradeModelFromJson(Map<String, dynamic> json) => UpgradeModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  baseCost: (json['baseCost'] as num).toInt(),
  baseProfitPerHour: (json['baseProfitPerHour'] as num).toInt(),
  userUpgrades: json['userUpgrades'] as List<dynamic>,
);

Map<String, dynamic> _$UpgradeModelToJson(UpgradeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'baseCost': instance.baseCost,
      'baseProfitPerHour': instance.baseProfitPerHour,
      'userUpgrades': instance.userUpgrades,
    };
