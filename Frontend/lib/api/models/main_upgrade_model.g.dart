// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_upgrade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainUpgradeModel _$MainUpgradeModelFromJson(Map<String, dynamic> json) =>
    MainUpgradeModel(
      message: json['message'] as String,
      upgrades: (json['upgrades'] as List<dynamic>)
          .map((e) => UpgradeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainUpgradeModelToJson(MainUpgradeModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'upgrades': instance.upgrades,
    };
