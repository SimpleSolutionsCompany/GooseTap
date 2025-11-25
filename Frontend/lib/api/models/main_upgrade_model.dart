import 'package:goose_tap/api/models/upgrade_model.dart';
import 'package:json_annotation/json_annotation.dart';

part "main_upgrade_model.g.dart";

@JsonSerializable()
class MainUpgradeModel {
  final String message;
  final List<UpgradeModel> upgrades;

  const MainUpgradeModel({required this.message, required this.upgrades});

  factory MainUpgradeModel.fromJson(Map<String, dynamic> json) =>
      _$MainUpgradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainUpgradeModelToJson(this);
}
