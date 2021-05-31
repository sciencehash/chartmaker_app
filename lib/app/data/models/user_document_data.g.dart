// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_document_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDocumentData _$UserDocumentDataFromJson(Map<String, dynamic> json) {
  return UserDocumentData(
    id: json['id'] as String,
    pageNumber: json['a'] as int,
    dyOffset: (json['b'] as num).toDouble(),
    deviceProfiles: UserDocumentData._deviceProfilesFromJson(json['c']),
    files: UserDocumentData._filesFromJson(json['d']),
  );
}

Map<String, dynamic> _$UserDocumentDataToJson(UserDocumentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'a': instance.pageNumber,
      'b': instance.dyOffset,
      'c': instance.deviceProfiles.map((e) => e.toJson()).toList(),
      'd': instance.files.map((e) => e.toJson()).toList(),
    };

DeviceProfile _$DeviceProfileFromJson(Map<String, dynamic> json) {
  return DeviceProfile(
    screenType: DeviceProfile._screenTypeFromJson(json['a'] as int),
    landscapeZoomLevel: (json['b'] as num).toDouble(),
    portraitZoomLevel: (json['c'] as num).toDouble(),
    landscapeDxOffset: (json['d'] as num).toDouble(),
    portraitDxOffset: (json['e'] as num).toDouble(),
    blockHorizontalScrolling: json['f'] as bool,
    modePageCount: json['g'] as int,
    modeScrollDirection: _$enumDecode(_$AxisEnumMap, json['h']),
    modeContinuous: json['i'] as bool,
  );
}

Map<String, dynamic> _$DeviceProfileToJson(DeviceProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('a', DeviceProfile._screenTypeToJson(instance.screenType));
  val['b'] = instance.landscapeZoomLevel;
  val['c'] = instance.portraitZoomLevel;
  val['d'] = instance.landscapeDxOffset;
  val['e'] = instance.portraitDxOffset;
  val['f'] = instance.blockHorizontalScrolling;
  val['g'] = instance.modePageCount;
  val['h'] = _$AxisEnumMap[instance.modeScrollDirection];
  val['i'] = instance.modeContinuous;
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$AxisEnumMap = {
  Axis.horizontal: 'horizontal',
  Axis.vertical: 'vertical',
};

FileReference _$FileReferenceFromJson(Map<String, dynamic> json) {
  return FileReference(
    storage: FileReference._storageFromJson(json['a'] as int),
    path: json['b'] as String,
  );
}

Map<String, dynamic> _$FileReferenceToJson(FileReference instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('a', FileReference._storageToJson(instance.storage));
  val['b'] = instance.path;
  return val;
}
