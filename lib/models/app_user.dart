import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sembast/sembast.dart';

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

  final int id;
  final String pCloudToken;
  final String gDriveToken;
  final String dropboxToken;
  final bool activated;

  AppUser.empty(int id)
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
    int id,
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

  AppUser.fromSembastSnapshot(RecordSnapshot snapshot)
      : id = snapshot.key as int,
        pCloudToken = snapshot.value['pCloudToken'] as String,
        gDriveToken = snapshot.value['gDriveToken'] as String,
        dropboxToken = snapshot.value['dropboxToken'] as String,
        activated = snapshot.value['activated'] as bool;

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  @override
  bool get stringify => true;
}
