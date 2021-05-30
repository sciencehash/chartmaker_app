import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:chartmaker_app/app/core/utils/helpers/model.dart';

part 'student.g.dart';

enum PaymentPeriod {
  mensual,
  annual,
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class Student extends Equatable {
  // Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String? name;

  @JsonKey(name: 'b')
  final String? photoUrl;

  @JsonKey(name: 'c')
  final String? email;

  @JsonKey(
    name: 'd',
    defaultValue: 'sys',
  )
  final String lang;

  @JsonKey(
    name: 'e',
    defaultValue: 'sys',
  )
  final String theme;

  @JsonKey(
    name: 'f',
    fromJson: ModelHelpers.colorFromJson,
    toJson: ModelHelpers.colorToJson,
  )
  final Color? customThemeColor;

  @JsonKey(
    name: 'g',
    defaultValue: '',
  )
  final String selectedLibraryId;

  @JsonKey(name: 'h')
  final DateTime signUpAt;

  @JsonKey(name: 'i')
  final DateTime? lastPaymentAt;

  @JsonKey(
    name: 'j',
    fromJson: _paymentPeriodFromJson,
    toJson: _paymentPeriodToJson,
  )
  final PaymentPeriod? paymentPeriod;

  @JsonKey(
    name: 'k',
    defaultValue: false,
  )
  final bool isSuspended;

  @JsonKey(name: 't')
  final bool activated;

  @JsonKey(
    name: 'u',
    fromJson: _studentConfigFromJson,
  )
  final StudentConfig config;

  static PaymentPeriod? _paymentPeriodFromJson(int? index) =>
      index != null ? PaymentPeriod.values[index] : null;

  static int? _paymentPeriodToJson(PaymentPeriod? period) => period?.index;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static StudentConfig _studentConfigFromJson(val) =>
      StudentConfig.fromJson(Map<String, dynamic>.from(val));

  Student({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.lang,
    required this.theme,
    required this.customThemeColor,
    required this.selectedLibraryId,
    required this.signUpAt,
    required this.lastPaymentAt,
    required this.paymentPeriod,
    required this.isSuspended,
    required this.activated,
    required this.config,
  });

  Student.minimum({required String id})
      : id = id,
        name = null,
        photoUrl = null,
        email = null,
        lang = 'sys',
        theme = 'sys',
        customThemeColor = null,
        selectedLibraryId = '[create_default]',
        signUpAt = DateTime.now().toUtc(),
        lastPaymentAt = null,
        paymentPeriod = null,
        isSuspended = false,
        activated = true,
        config = StudentConfig.minimum();

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        email,
        lang,
        theme,
        customThemeColor,
        selectedLibraryId,
        signUpAt,
        lastPaymentAt,
        paymentPeriod,
        isSuspended,
        activated,
        config,
      ];

  Student copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    String? lang,
    String? theme,
    Color? customThemeColor,
    String? selectedLibraryId,
    DateTime? signUpAt,
    DateTime? lastPaymentAt,
    PaymentPeriod? paymentPeriod,
    bool? isSuspended,
    bool? activated,
    StudentConfig? config,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      customThemeColor: customThemeColor ?? this.customThemeColor,
      selectedLibraryId: selectedLibraryId ?? this.selectedLibraryId,
      signUpAt: signUpAt ?? this.signUpAt,
      lastPaymentAt: lastPaymentAt ?? this.lastPaymentAt,
      paymentPeriod: paymentPeriod ?? this.paymentPeriod,
      isSuspended: isSuspended ?? this.isSuspended,
      activated: activated ?? this.activated,
      config: config ?? this.config,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  //
  factory Student.fromFirestoreMap(String snapshotId, Map data) {
    //
    var json = Map<String, dynamic>.from(
      data,
    );

    //
    json['id'] = snapshotId;

    // Convert 'signUpAt' to DateTime
    json['h'] = (json['h'] as Timestamp).toDate().toIso8601String();

    // Convert 'lastPaymentAt' to DateTime
    json['i'] = (json['i'] as Timestamp?)?.toDate().toIso8601String();

    //
    return _$StudentFromJson(json);
  }

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  Map<String, dynamic> toFirestoreDocument() {
    Map<String, dynamic> doc = this.toDocument();

    // Convert 'signUpAt' to Firestore Timestamp
    doc['h'] = Timestamp.fromDate(DateTime.parse(doc['h']));

    // Convert 'lastPaymentAt' to Firestore Timestamp
    doc['i'] =
        doc['i'] != null ? Timestamp.fromDate(DateTime.parse(doc['i'])) : null;

    return doc;
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class StudentConfig extends Equatable {
  @JsonKey(
    name: 'a',
    defaultValue: false,
  )
  final bool avoidInstallMobileAppMsg;

  StudentConfig({
    required this.avoidInstallMobileAppMsg,
  });

  StudentConfig.minimum() : avoidInstallMobileAppMsg = false;

  @override
  List<Object> get props => [
        avoidInstallMobileAppMsg,
      ];

  StudentConfig copyWith({
    bool? avoidInstallMobileAppMsg,
  }) {
    return StudentConfig(
      avoidInstallMobileAppMsg:
          avoidInstallMobileAppMsg ?? this.avoidInstallMobileAppMsg,
    );
  }

  factory StudentConfig.fromJson(Map<String, dynamic> json) =>
      _$StudentConfigFromJson(json);

  Map<String, dynamic> toJson() {
    // Convert to JSON Map
    Map<String, dynamic> json = _$StudentConfigToJson(this);

    // Remove 'avoidInstallMobileAppMsg' if have its default value
    if (avoidInstallMobileAppMsg == false) json.remove('a');

    return json;
  }

  @override
  bool get stringify => true;
}
