// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDocument _$AppDocumentFromJson(Map<String, dynamic> json) {
  return AppDocument(
    id: json['id'] as String,
    userId: json['userId'] as String,
    libraryId: json['libraryId'] as String,
    title: json['title'] as String,
    provider: _$enumDecode(_$CloudProviderEnumMap, json['provider']),
    path: json['path'] as String,
    pageNum: json['pageNum'] as int,
    utcLastUpdate: DateTime.parse(json['utcLastUpdate'] as String),
    scale: json['scale'] as double,
    activated: json['activated'] as bool,
  );
}

Map<String, dynamic> _$AppDocumentToJson(AppDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'libraryId': instance.libraryId,
      'title': instance.title,
      'provider': _$CloudProviderEnumMap[instance.provider],
      'path': instance.path,
      'pageNum': instance.pageNum,
      'utcLastUpdate': instance.utcLastUpdate.toIso8601String(),
      'scale': instance.scale,
      'activated': instance.activated,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$CloudProviderEnumMap = {
  CloudProvider.pCloud: 'pCloud',
  CloudProvider.gDrive: 'gDrive',
  CloudProvider.dropbox: 'dropbox',
};
