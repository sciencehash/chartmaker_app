// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) {
  return Library(
    id: json['id'] as String,
    userId: json['a'] as String,
    title: json['b'] as String,
    dirs: Library._dirsFromJson(json['c']),
    docs: Library._docsFromJson(json['d']),
    viewMode: json['e'] as String,
    lastDirsIdLib: json['f'] as int? ?? 0,
    lastDocsIdLib: json['g'] as int? ?? 0,
  );
}

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'id': instance.id,
      'a': instance.userId,
      'b': instance.title,
      'c': instance.dirs.map((e) => e.toJson()).toList(),
      'd': instance.docs.map((e) => e.toJson()).toList(),
      'e': instance.viewMode,
      'f': instance.lastDirsIdLib,
      'g': instance.lastDocsIdLib,
    };

DocumentDirectory _$DocumentDirectoryFromJson(Map<String, dynamic> json) {
  return DocumentDirectory(
    idLib: json['a'] as int,
    title: json['b'] as String,
    dirs: DocumentDirectory._dirsFromJson(json['c']),
    docs: DocumentDirectory._docsFromJson(json['d']),
  );
}

Map<String, dynamic> _$DocumentDirectoryToJson(DocumentDirectory instance) =>
    <String, dynamic>{
      'a': instance.idLib,
      'b': instance.title,
      'c': instance.dirs.map((e) => e.toJson()).toList(),
      'd': instance.docs.map((e) => e.toJson()).toList(),
    };

DocumentFile _$DocumentFileFromJson(Map<String, dynamic> json) {
  return DocumentFile(
    idLib: json['a'] as int,
    title: json['b'] as String,
    userDocumentDataId: json['c'] as String?,
  );
}

Map<String, dynamic> _$DocumentFileToJson(DocumentFile instance) {
  final val = <String, dynamic>{
    'a': instance.idLib,
    'b': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('c', instance.userDocumentDataId);
  return val;
}
