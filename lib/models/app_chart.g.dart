// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppChart _$AppChartFromJson(Map<String, dynamic> json) {
  return AppChart(
    id: json['id'] as int,
    userId: json['userId'] as int,
    libraryId: json['libraryId'] as int,
    title: json['title'] as String,
    config: json['config'] as Map<String, dynamic>,
    utcLastUpdate: DateTime.parse(json['utcLastUpdate'] as String),
    activated: json['activated'] as bool,
  );
}

Map<String, dynamic> _$AppChartToJson(AppChart instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'libraryId': instance.libraryId,
      'title': instance.title,
      'config': instance.config,
      'utcLastUpdate': instance.utcLastUpdate.toIso8601String(),
      'activated': instance.activated,
    };
