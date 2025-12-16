import 'package:json_annotation/json_annotation.dart';

part 'string_api_response.g.dart';

@JsonSerializable()
class StringApiResponse {
  final bool? success;
  final String? message;
  final String? data;
  final List<String>? errors;

  StringApiResponse({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory StringApiResponse.fromJson(Map<String, dynamic> json) =>
      _$StringApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StringApiResponseToJson(this);
}
