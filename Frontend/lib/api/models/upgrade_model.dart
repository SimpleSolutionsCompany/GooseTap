import 'package:json_annotation/json_annotation.dart';

part "upgrade_model.g.dart";

@JsonSerializable()
class UpgradeModel {
  final String id;
  final String name;
  final String description;
  final int baseCost;
  final int baseProfitPerHour;
  final List<dynamic> userUpgrades;

  UpgradeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.baseCost,
    required this.baseProfitPerHour,
    required this.userUpgrades,
  });

  factory UpgradeModel.fromJson(Map<String, dynamic> json) =>
      _$UpgradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpgradeModelToJson(this);
}
