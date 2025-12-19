import 'package:json_annotation/json_annotation.dart';

part 'click_response.g.dart';

@JsonSerializable()
class ClickResponse {
  final int balance;
  final int currentEnergy;
  final int profitPerClick;
  final int energyRestorePerSecond;
  final int maxEnergy;
  final int level;
  final double progress;

  ClickResponse({
    required this.balance,
    required this.currentEnergy,
    required this.profitPerClick,
    required this.energyRestorePerSecond,
    this.maxEnergy = 1000,
    this.level = 1,
    this.progress = 0,
  });

  factory ClickResponse.fromJson(Map<String, dynamic> json) =>
      _$ClickResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClickResponseToJson(this);
}
