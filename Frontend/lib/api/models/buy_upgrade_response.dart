import 'package:json_annotation/json_annotation.dart';

part 'buy_upgrade_response.g.dart';

@JsonSerializable()
class BuyUpgradeResponse {
  final bool success;
  final String message;
  final int newBalance;
  final int newLevel;
  final int nextLevelPrice;
  final int effectValue;

  BuyUpgradeResponse({
    required this.success,
    required this.message,
    required this.newBalance,
    required this.newLevel,
    required this.nextLevelPrice,
    required this.effectValue,
  });

  factory BuyUpgradeResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyUpgradeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BuyUpgradeResponseToJson(this);
}
