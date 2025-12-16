// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringApiResponse _$StringApiResponseFromJson(Map<String, dynamic> json) =>
    StringApiResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StringApiResponseToJson(StringApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
    };
