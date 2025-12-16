import 'package:json_annotation/json_annotation.dart';

part 'game_update_request.g.dart';

@JsonSerializable()
class GameUpdateRequest {
  final int? clicks;
  final int? energySpent;
  final DateTime? timestamp;

  GameUpdateRequest({
    this.clicks,
    this.energySpent,
    this.timestamp,
  });

  factory GameUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$GameUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GameUpdateRequestToJson(this);
}
