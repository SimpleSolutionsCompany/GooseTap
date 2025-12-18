import 'package:json_annotation/json_annotation.dart';

part "upgrade_model.g.dart";

@JsonSerializable()
class UpgradeModel {
  final String id;
  final String name;
  final String description;
  final int boosterType;
  final int currentLevel;
  final int maxLevel;
  final int price;
  final int effectValue;
  final double costMultiplier;
  final bool canBuy;

  UpgradeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.boosterType,
    required this.currentLevel,
    required this.maxLevel,
    required this.price,
    required this.effectValue,
    required this.costMultiplier,
    required this.canBuy,
  });

  factory UpgradeModel.fromJson(Map<String, dynamic> json) =>
      _$UpgradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpgradeModelToJson(this);
}
