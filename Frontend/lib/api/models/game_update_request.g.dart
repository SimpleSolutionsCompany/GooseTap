// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameUpdateRequest _$GameUpdateRequestFromJson(Map<String, dynamic> json) =>
    GameUpdateRequest(
      clicks: (json['clicks'] as num?)?.toInt(),
      energySpent: (json['energySpent'] as num?)?.toInt(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$GameUpdateRequestToJson(GameUpdateRequest instance) =>
    <String, dynamic>{
      'clicks': instance.clicks,
      'energySpent': instance.energySpent,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
