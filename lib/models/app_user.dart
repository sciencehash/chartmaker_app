import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable(nullable: false)
class AppUser extends Equatable {
  AppUser({
    @required this.id,
    @required this.pCloudToken,
    @required this.gDriveToken,
    @required this.dropboxToken,
    @required this.activated,
  });

  final String id;
  final String pCloudToken;
  final String gDriveToken;
  final String dropboxToken;
  final bool activated;

  AppUser.empty(String id)
      : id = id,
        pCloudToken = null,
        gDriveToken = null,
        dropboxToken = null,
        activated = true;

  @override
  List<Object> get props => [
        id,
        pCloudToken,
        gDriveToken,
        dropboxToken,
        activated,
      ];

  AppUser copyWith({
    String id,
    String pCloudToken,
    String gDriveToken,
    String dropboxToken,
    bool activated,
  }) {
    return AppUser(
      id: id ?? this.id,
      pCloudToken: pCloudToken ?? this.pCloudToken,
      gDriveToken: gDriveToken ?? this.gDriveToken,
      dropboxToken: dropboxToken ?? this.dropboxToken,
      activated: activated ?? this.activated,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  AppUser.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.reference.id,
        pCloudToken = snapshot.data()['pCloudToken'] as String,
        gDriveToken = snapshot.data()['gDriveToken'] as String,
        dropboxToken = snapshot.data()['dropboxToken'] as String,
        activated = snapshot.data()['activated'] as bool;

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  @override
  bool get stringify => true;
}
