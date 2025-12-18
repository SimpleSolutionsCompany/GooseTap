// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpgradeModel _$UpgradeModelFromJson(Map<String, dynamic> json) => UpgradeModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  boosterType: (json['boosterType'] as num).toInt(),
  currentLevel: (json['currentLevel'] as num).toInt(),
  maxLevel: (json['maxLevel'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  effectValue: (json['effectValue'] as num).toInt(),
  costMultiplier: (json['costMultiplier'] as num).toDouble(),
  canBuy: json['canBuy'] as bool,
);

Map<String, dynamic> _$UpgradeModelToJson(UpgradeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'boosterType': instance.boosterType,
      'currentLevel': instance.currentLevel,
      'maxLevel': instance.maxLevel,
      'price': instance.price,
      'effectValue': instance.effectValue,
      'costMultiplier': instance.costMultiplier,
      'canBuy': instance.canBuy,
    };
