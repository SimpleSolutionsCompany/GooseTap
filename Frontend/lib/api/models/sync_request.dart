import 'package:json_annotation/json_annotation.dart';

part 'sync_request.g.dart';

@JsonSerializable()
class SyncRequest {
  final int? clickCount;

  SyncRequest({this.clickCount});

  factory SyncRequest.fromJson(Map<String, dynamic> json) =>
      _$SyncRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SyncRequestToJson(this);
}
