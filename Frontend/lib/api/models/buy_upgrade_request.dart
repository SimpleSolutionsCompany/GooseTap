import 'package:json_annotation/json_annotation.dart';

part 'buy_upgrade_request.g.dart';

@JsonSerializable()
class BuyUpgradeRequest {
  final String? upgradeId;

  BuyUpgradeRequest({this.upgradeId});

  factory BuyUpgradeRequest.fromJson(Map<String, dynamic> json) =>
      _$BuyUpgradeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BuyUpgradeRequestToJson(this);
}
