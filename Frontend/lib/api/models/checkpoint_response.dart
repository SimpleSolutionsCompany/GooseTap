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

  CheckpointResponse({
    this.balance,
    this.energy,
    this.maxEnergy,
    this.profitPerHour,
    this.offlineIncome,
    this.lastSyncDate,
    this.level,
    this.rank,
  });

  factory CheckpointResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckpointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointResponseToJson(this);
}
