import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sembast/sembast.dart';

part 'app_library.g.dart';

@JsonSerializable(nullable: false)
class AppLibrary extends Equatable {
  AppLibrary({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.activated,
  });

  final int id;
  final int userId;
  final String title;
  final bool activated;

  AppLibrary.defaultLibrary(int _userId) :
    id = null,
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
    int id,
    int userId,
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

  AppLibrary.fromSembastSnapshot(RecordSnapshot snapshot)
      : id = snapshot.key as int,
        userId = snapshot.value['userId'] as int,
        title = snapshot.value['title'] as String,
        activated = snapshot.value['activated'] as bool;

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  @override
  bool get stringify => true;
}
