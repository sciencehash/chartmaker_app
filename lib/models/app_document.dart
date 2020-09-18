import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:sembast/sembast.dart';

// import '../repositories/local_storage_repository.dart';
import '../models/app_user.dart';
// import '../widgets/cloud_explorer/repositories/cloud_repository_pcloud.dart';

part 'app_document.g.dart';

enum CloudProvider {
  pCloud,
  gDrive,
  dropbox,
}

@JsonSerializable(nullable: false)
class AppDocument extends Equatable {
  AppDocument({
    @required this.id,
    @required this.userId,
    @required this.libraryId,
    @required this.title,
    @required this.provider,
    @required this.path,
    @required this.pageNum,
    @required this.utcLastUpdate,
    @required this.scale,
    @required this.activated,
    this.coverThumbnail,
    this.fileData,
  });

  final String id;
  final String userId;
  final String libraryId;
  final String title;
  final CloudProvider provider;
  // fileid in pCloud, ___ en GDrive, ...
  final String path;
  final int pageNum;
  final DateTime utcLastUpdate;
  final double scale;
  final bool activated;

  // Auto generated values
  @JsonKey(ignore: true)
  final Uint8List coverThumbnail;
  @JsonKey(ignore: true)
  final Uint8List fileData;

  @override
  List<Object> get props => [
        id,
        userId,
        libraryId,
        title,
        provider,
        path,
        pageNum,
        utcLastUpdate,
        scale,
        activated,
        coverThumbnail,
        fileData,
      ];

  AppDocument copyWith({
    String id,
    String userId,
    String libraryId,
    String title,
    String path,
    int pageNum,
    DateTime utcLastUpdate,
    double scale,
    bool activated,
    Uint8List coverThumbnail,
    Uint8List fileData,
  }) {
    return AppDocument(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      libraryId: libraryId ?? this.libraryId,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      path: path ?? this.path,
      pageNum: pageNum ?? this.pageNum,
      utcLastUpdate: utcLastUpdate ?? this.utcLastUpdate,
      scale: scale ?? this.scale,
      activated: activated ?? this.activated,
      coverThumbnail: coverThumbnail ?? this.coverThumbnail,
      fileData: fileData ?? this.fileData,
    );
  }

  factory AppDocument.fromJson(Map<String, dynamic> json) =>
      _$AppDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$AppDocumentToJson(this);

  AppDocument.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.reference.id,
        userId = snapshot.data()['userId'] as String,
        libraryId = snapshot.data()['libraryId'] as String,
        title = snapshot.data()['title'] as String,
//        provider = snapshot.data()['provider'] as CloudProvider,
        provider = CloudProvider.pCloud,
        path = snapshot.data()['path'] as String,
        pageNum = snapshot.data()['pageNum'] as int,
        utcLastUpdate =
            (snapshot.data()['utcLastUpdate'] as Timestamp).toDate(),
        scale = snapshot.data()['scale'] as double,
        activated = snapshot.data()['activated'] as bool,
        coverThumbnail = null,
        fileData = null;

  Map<String, dynamic> toDocument() {
    // Firebase document is toJson without 'id' field
    final Map<String, dynamic> fbDocument = this.toJson();
    fbDocument.remove('id');

    // Convert DateTime to Firebase Timestamp
    fbDocument['utcLastUpdate'] = Timestamp.fromDate(this.utcLastUpdate);

    // TEMP remove 'provider'
    fbDocument.remove('provider');

    // Return
    return fbDocument;
  }

  //
//   Future<Uint8List> getFileData({
//     @required AppUser user,
//     @required Database localStorageDb,
//   }) async {
//     //
//     Uint8List fileData;
//
//     // Get data from local storage
//     Uint8List localFileData; // temp
//     // Uint8List localFileData = await LocalStorageRepository.getDocumentFileData(
//     //   localStorageDb: localStorageDb,
//     //   documentId: this.id,
//     // );
//
//     // if exists locally
//     if (localFileData != null) {
//       //
//       // Use data from local storage
//       //
//       fileData = localFileData;
//     } else {
//       //
//       // Get data from cloud provider
//       //
//       if (this.provider == CloudProvider.pCloud) {
// //        CloudRepositoryPCloud cloudRepositoryPCloud = CloudRepositoryPCloud();
// //        fileData = await cloudRepositoryPCloud.downloadFile(
// //          token: user.pCloudToken,
// //          fileId: this.path,
// //        );
//         // TEMP !!!!!!!!!!!!
//         fileData = (await compute(
//           rootBundle.load,
//           'assets/Quick Start Guide to Dart Programming_2019_225p.pdf',
//         ))
//             .buffer
//             .asUint8List();
//       } else if (this.provider == CloudProvider.gDrive) {
//         //
//       } else if (this.provider == CloudProvider.dropbox) {
//         //
//       }
//
//       // Save file data locally
//       // LocalStorageRepository.upsertDocumentFileData(
//       //   localStorageDb: localStorageDb,
//       //   documentId: this.id,
//       //   fileData: fileData,
//       // );
//     }
//
//     //
//     return fileData;
//   }

  @override
  bool get stringify => true;
}
