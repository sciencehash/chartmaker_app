// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    id: json['id'] as String,
    name: json['a'] as String?,
    photoUrl: json['b'] as String?,
    email: json['c'] as String?,
    lang: json['d'] as String? ?? 'sys',
    theme: json['e'] as String? ?? 'sys',
    customThemeColor: ModelHelpers.colorFromJson(json['f'] as int?),
    selectedLibraryId: json['g'] as String? ?? '',
    signUpAt: DateTime.parse(json['h'] as String),
    lastPaymentAt:
        json['i'] == null ? null : DateTime.parse(json['i'] as String),
    paymentPeriod: Student._paymentPeriodFromJson(json['j'] as int?),
    isSuspended: json['k'] as bool? ?? false,
    activated: json['t'] as bool,
    config: Student._studentConfigFromJson(json['u']),
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('a', instance.name);
  writeNotNull('b', instance.photoUrl);
  writeNotNull('c', instance.email);
  val['d'] = instance.lang;
  val['e'] = instance.theme;
  writeNotNull('f', ModelHelpers.colorToJson(instance.customThemeColor));
  val['g'] = instance.selectedLibraryId;
  val['h'] = instance.signUpAt.toIso8601String();
  writeNotNull('i', instance.lastPaymentAt?.toIso8601String());
  writeNotNull('j', Student._paymentPeriodToJson(instance.paymentPeriod));
  val['k'] = instance.isSuspended;
  val['t'] = instance.activated;
  val['u'] = instance.config.toJson();
  return val;
}

StudentConfig _$StudentConfigFromJson(Map<String, dynamic> json) {
  return StudentConfig(
    avoidInstallMobileAppMsg: json['a'] as bool? ?? false,
  );
}

Map<String, dynamic> _$StudentConfigToJson(StudentConfig instance) =>
    <String, dynamic>{
      'a': instance.avoidInstallMobileAppMsg,
    };
