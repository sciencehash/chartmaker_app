// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    id: json['id'] as String,
    pCloudToken: json['pCloudToken'] as String,
    gDriveToken: json['gDriveToken'] as String,
    dropboxToken: json['dropboxToken'] as String,
    activated: json['activated'] as bool,
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'pCloudToken': instance.pCloudToken,
      'gDriveToken': instance.gDriveToken,
      'dropboxToken': instance.dropboxToken,
      'activated': instance.activated,
    };
