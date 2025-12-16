import 'package:json_annotation/json_annotation.dart';

part 'checkpoint_response.g.dart';

@JsonSerializable()
class CheckpointResponse {
  final int? balance;
  final int? energy;
  final int? maxEnergy;
  final double? profitPerHour;
  final double? offlineIncome;
  final DateTime? lastSyncDate;
  final int? level;
  final String? rank;

  // Boosters
  final int? multitapLevel;
  final int? energyLimitLevel;
  final int? rechargeSpeedLevel;
  final int? profitPerClick;
  final int? energyRestorePerSecond;

  CheckpointResponse({
    this.balance,
    this.energy,
    this.maxEnergy,
    this.profitPerHour,
    this.offlineIncome,
    this.lastSyncDate,
    this.level,
    this.rank,
    this.multitapLevel,
    this.energyLimitLevel,
    this.rechargeSpeedLevel,
    this.profitPerClick,
    this.energyRestorePerSecond,
  });

  factory CheckpointResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckpointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointResponseToJson(this);
}
