import 'package:json_annotation/json_annotation.dart';

part 'click_response.g.dart';

@JsonSerializable()
class ClickResponse {
  final int balance;
  final int currentEnergy;
  final int profitPerClick;
  final int energyRestorePerSecond;

  ClickResponse({
    required this.balance,
    required this.currentEnergy,
    required this.profitPerClick,
    required this.energyRestorePerSecond,
  });

  factory ClickResponse.fromJson(Map<String, dynamic> json) =>
      _$ClickResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClickResponseToJson(this);
}
