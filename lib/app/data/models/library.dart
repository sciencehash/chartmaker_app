import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'library.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class Library extends Equatable {
  /// Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String userId;

  @JsonKey(name: 'b')
  final String title;

  @JsonKey(
    name: 'c',
    fromJson: _dirsFromJson,
  )
  final List<DocumentDirectory> dirs;

  @JsonKey(
    name: 'd',
    fromJson: _docsFromJson,
  )
  final List<DocumentFile> docs;

  @JsonKey(name: 'e')
  final String viewMode;

  /// Max idLib on dirs list
  @JsonKey(
    name: 'f',
    defaultValue: 0,
  )
  final int lastDirsIdLib;

  /// Max idLib on docs list
  @JsonKey(
    name: 'g',
    defaultValue: 0,
  )
  final int lastDocsIdLib;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static List<DocumentDirectory> _dirsFromJson(val) => (val as List<dynamic>)
      .map((e) => DocumentDirectory.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static List<DocumentFile> _docsFromJson(val) => (val as List<dynamic>)
      .map((e) => DocumentFile.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  Library({
    required this.id,
    required this.userId,
    required this.title,
    required this.dirs,
    required this.docs,
    required this.viewMode,
    required this.lastDirsIdLib,
    required this.lastDocsIdLib,
  });

  Library.minimum({
    required String id,
    required String userId,
    required String title,
  })  : id = id,
        userId = userId,
        title = title,
        dirs = [],
        docs = [],
        viewMode = 'list',
        lastDirsIdLib = 0,
        lastDocsIdLib = 0;

  @override
  List<Object?> get props =>
      [id, userId, title, dirs, docs, viewMode, lastDirsIdLib, lastDocsIdLib];

  Library copyWith({
    String? id,
    String? userId,
    String? title,
    String? viewMode,
    List<DocumentDirectory>? dirs,
    List<DocumentFile>? docs,
    int? lastDirsIdLib,
    int? lastDocsIdLib,
  }) {
    return Library(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      dirs: dirs ?? this.dirs,
      docs: docs ?? this.docs,
      viewMode: viewMode ?? this.viewMode,
      lastDirsIdLib: lastDirsIdLib ?? this.lastDirsIdLib,
      lastDocsIdLib: lastDocsIdLib ?? this.lastDocsIdLib,
    );
  }

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryToJson(this);

  //
  factory Library.fromFirestoreMap(String snapshotId, Map data) {
    //
    var json = Map<String, dynamic>.from(
      data,
    );

    //
    json['id'] = snapshotId;

    //
    return _$LibraryFromJson(json);
  }

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  Map<String, dynamic> toFirestoreDocument() => this.toDocument()..remove('id');

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class DocumentDirectory extends Equatable {
  /// ID in the its library
  @JsonKey(name: 'a')
  final int idLib;

  @JsonKey(name: 'b')
  final String title;

  @JsonKey(
    name: 'c',
    fromJson: _dirsFromJson,
  )
  final List<DocumentDirectory> dirs;

  @JsonKey(
    name: 'd',
    fromJson: _docsFromJson,
  )
  final List<DocumentFile> docs;

  // To fix "type 'Map<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'"
  static List<DocumentDirectory> _dirsFromJson(val) => (val as List<dynamic>)
      .map((e) => DocumentDirectory.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  // To fix "type 'Map<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'"
  static List<DocumentFile> _docsFromJson(val) => (val as List<dynamic>)
      .map((e) => DocumentFile.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  DocumentDirectory({
    required this.idLib,
    required this.title,
    required this.dirs,
    required this.docs,
  });

  DocumentDirectory.minimum({required int idLib, required String title})
      : idLib = idLib,
        title = title,
        dirs = [],
        docs = [];

  @override
  List<Object?> get props => [
        idLib,
        title,
        dirs,
        docs,
      ];

  DocumentDirectory copyWith({
    int? idLib,
    String? title,
    List<DocumentDirectory>? dirs,
    List<DocumentFile>? docs,
  }) {
    return DocumentDirectory(
      idLib: idLib ?? this.idLib,
      title: title ?? this.title,
      dirs: dirs ?? this.dirs,
      docs: docs ?? this.docs,
    );
  }

  factory DocumentDirectory.fromJson(Map<String, dynamic> json) =>
      _$DocumentDirectoryFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDirectoryToJson(this);

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class DocumentFile extends Equatable {
  /// ID in the its library
  @JsonKey(name: 'a')
  final int idLib;

  @JsonKey(name: 'b')
  final String title;

  @JsonKey(name: 'c')
  final String? userDocumentDataId;

  DocumentFile({
    required this.idLib,
    required this.title,
    required this.userDocumentDataId,
  });

  DocumentFile.minimum({required int idLib, required String title})
      : idLib = idLib,
        title = title,
        userDocumentDataId = null;

  @override
  List<Object?> get props => [
        idLib,
        title,
        userDocumentDataId,
      ];

  DocumentFile copyWith({
    int? idLib,
    String? title,
    String? userDocumentDataId,
  }) {
    return DocumentFile(
      idLib: idLib ?? this.idLib,
      title: title ?? this.title,
      userDocumentDataId: userDocumentDataId ?? this.userDocumentDataId,
    );
  }

  factory DocumentFile.fromJson(Map<String, dynamic> json) =>
      _$DocumentFileFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentFileToJson(this);

  @override
  bool get stringify => true;
}
