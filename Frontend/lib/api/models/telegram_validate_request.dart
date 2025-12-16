import 'package:json_annotation/json_annotation.dart';

part 'telegram_validate_request.g.dart';

@JsonSerializable()
class TelegramValidateRequest {
  final String? initData;

  TelegramValidateRequest({this.initData});

  factory TelegramValidateRequest.fromJson(Map<String, dynamic> json) =>
      _$TelegramValidateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TelegramValidateRequestToJson(this);
}
