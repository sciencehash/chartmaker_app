import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_library.g.dart';

@JsonSerializable(nullable: false)
class AppLibrary extends Equatable {
  AppLibrary({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.activated,
  });

  final String id;
  final String userId;
  final String title;
  final bool activated;

  AppLibrary.defaultLibrary(String _userId) :
    id = '',
    userId = _userId,
    title = 'My library',
    activated = true;

  @override
  List<Object> get props => [
    id,
    userId,
    title,
    activated,
  ];

  AppLibrary copyWith({
    String id,
    String userId,
    String title,
    bool activated,
  }) {
    return AppLibrary(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      activated: activated ?? this.activated,
    );
  }

  factory AppLibrary.fromJson(Map<String, dynamic> json) => _$AppLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$AppLibraryToJson(this);

  AppLibrary.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.reference.id,
        userId = snapshot.data()['userId'] as String,
        title = snapshot.data()['title'] as String,
        activated = snapshot.data()['activated'] as bool;

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  @override
  bool get stringify => true;
}
