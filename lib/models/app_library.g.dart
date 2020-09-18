// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppLibrary _$AppLibraryFromJson(Map<String, dynamic> json) {
  return AppLibrary(
    id: json['id'] as String,
    userId: json['userId'] as String,
    title: json['title'] as String,
    activated: json['activated'] as bool,
  );
}

Map<String, dynamic> _$AppLibraryToJson(AppLibrary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'activated': instance.activated,
    };
