import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_chart.g.dart';

@JsonSerializable(nullable: false)
class AppChart extends Equatable {
  AppChart({
    @required this.id,
    @required this.userId,
    @required this.libraryId,
    @required this.title,
    @required this.config,
    @required this.utcLastUpdate,
    @required this.activated,
    this.thumbnail,
  });

  final String id;
  final String userId;
  final String libraryId;
  final String title;
  final Map config;
  final DateTime utcLastUpdate;
  final bool activated;

  // Auto generated values
  @JsonKey(ignore: true)
  final Uint8List thumbnail;

  @override
  List<Object> get props => [
        id,
        userId,
        libraryId,
        title,
        config,
        utcLastUpdate,
        activated,
        thumbnail,
      ];

  AppChart copyWith({
    String id,
    String userId,
    String libraryId,
    String title,
    Map config,
    DateTime utcLastUpdate,
    bool activated,
    Uint8List thumbnail,
  }) {
    return AppChart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      libraryId: libraryId ?? this.libraryId,
      title: title ?? this.title,
      config: config ?? this.config,
      utcLastUpdate: utcLastUpdate ?? this.utcLastUpdate,
      activated: activated ?? this.activated,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory AppChart.fromJson(Map<String, dynamic> json) =>
      _$AppChartFromJson(json);
  Map<String, dynamic> toJson() => _$AppChartToJson(this);

  AppChart.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.reference.id,
        userId = snapshot.data()['userId'] as String,
        libraryId = snapshot.data()['libraryId'] as String,
        title = snapshot.data()['title'] as String,
        config = snapshot.data()['config'] as Map<String, dynamic>,
        utcLastUpdate =
            (snapshot.data()['utcLastUpdate'] as Timestamp).toDate(),
        activated = snapshot.data()['activated'] as bool,
        thumbnail = null;

  Map<String, dynamic> toDocument() {
    // Firebase document is toJson without 'id' field
    final Map<String, dynamic> fbDocument = this.toJson();
    fbDocument.remove('id');

    // Convert DateTime to Firebase Timestamp
    fbDocument['utcLastUpdate'] = Timestamp.fromDate(this.utcLastUpdate);

    // Return
    return fbDocument;
  }

  @override
  bool get stringify => true;
}
