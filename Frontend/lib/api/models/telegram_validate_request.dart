import 'package:json_annotation/json_annotation.dart';

part 'telegram_validate_request.g.dart';

@JsonSerializable()
class TelegramValidateRequest {
  @JsonKey(name: 'initDataRaw')
  final String? initDataRaw;

  TelegramValidateRequest({this.initDataRaw});

  factory TelegramValidateRequest.fromJson(Map<String, dynamic> json) =>
      _$TelegramValidateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TelegramValidateRequestToJson(this);
}
