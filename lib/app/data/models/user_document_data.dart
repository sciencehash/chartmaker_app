import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_document_data.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class UserDocumentData extends Equatable {
  /// Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final int pageNumber;

  @JsonKey(name: 'b')
  final double dyOffset;

  @JsonKey(
    name: 'c',
    fromJson: _deviceProfilesFromJson,
  )
  final List<DeviceProfile> deviceProfiles;

  @JsonKey(
    name: 'd',
    fromJson: _filesFromJson,
  )
  final List<FileReference> files;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static List<DeviceProfile> _deviceProfilesFromJson(val) =>
      (val as List<dynamic>)
          .map((e) => DeviceProfile.fromJson(Map<String, dynamic>.from(e)))
          .toList();

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static List<FileReference> _filesFromJson(val) => (val as List<dynamic>)
      .map((e) => FileReference.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  UserDocumentData({
    required this.id,
    required this.pageNumber,
    required this.dyOffset,
    required this.deviceProfiles,
    required this.files,
  });

  UserDocumentData.minimum({
    required String id,
  })   : id = id,
        pageNumber = 1,
        dyOffset = 0,
        deviceProfiles = [],
        files = [];

  @override
  List<Object?> get props => [
        id,
        pageNumber,
        dyOffset,
        deviceProfiles,
        files,
      ];

  UserDocumentData copyWith({
    String? id,
    int? pageNumber,
    double? dyOffset,
    List<DeviceProfile>? deviceProfiles,
    List<FileReference>? files,
  }) {
    return UserDocumentData(
      id: id ?? this.id,
      pageNumber: pageNumber ?? this.pageNumber,
      dyOffset: dyOffset ?? this.dyOffset,
      deviceProfiles: deviceProfiles ?? this.deviceProfiles,
      files: files ?? this.files,
    );
  }

  // Get the current device screen type
  DeviceScreenType deviceScreenType() {
    return Get.context!.responsiveValue<DeviceScreenType>(
      watch: DeviceScreenType.watch,
      mobile: DeviceScreenType.mobile,
      tablet: DeviceScreenType.tablet,
      desktop: DeviceScreenType.desktop,
    ) as DeviceScreenType;
  }

  // Get the current device profile
  DeviceProfile deviceProfile() {
    final _deviceScreenType = deviceScreenType();
    return deviceProfiles.firstWhere(
      (d) => d.screenType == _deviceScreenType,
      orElse: () => DeviceProfile.minimum(
        screenType: _deviceScreenType,
      ),
    );
  }

  double getZoomLevel() {
    final DeviceProfile _deviceProfile = deviceProfile();
    if (Get.context!.isLandscape) {
      return _deviceProfile.landscapeZoomLevel;
    } else {
      return _deviceProfile.portraitZoomLevel;
    }
  }

  List<DeviceProfile> copyProfilesWithZoomLevel(double zoomLevel) {
    // Get values
    DeviceProfile _deviceProfile = deviceProfile();
    final _deviceScreenType = deviceScreenType();
    var _deviceProfiles = List<DeviceProfile>.from(deviceProfiles);

    // Update model
    _deviceProfile = _deviceProfile.copyWith(
      landscapeZoomLevel: Get.context!.isLandscape ? zoomLevel : null,
      portraitZoomLevel: Get.context!.isPortrait ? zoomLevel : null,
    );

    // Finde device profile index
    final idx = _deviceProfiles.indexWhere(
      (d) => d.screenType == _deviceScreenType,
    );

    // If device profile do not exists yet in the list
    if (idx == -1) {
      // Add to the list
      _deviceProfiles.add(_deviceProfile);
    } else {
      // Update list
      _deviceProfiles[idx] = _deviceProfile;
    }

    return _deviceProfiles;
  }

  factory UserDocumentData.fromJson(Map<String, dynamic> json) =>
      _$UserDocumentDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDocumentDataToJson(this);

  //
  factory UserDocumentData.fromFirestoreMap(String snapshotId, Map data) {
    //
    var json = Map<String, dynamic>.from(
      data,
    );

    //
    json['id'] = snapshotId;

    //
    return _$UserDocumentDataFromJson(json);
  }

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  Map<String, dynamic> toFirestoreDocument() => this.toDocument()..remove('id');

  @override
  bool get stringify => true;
}

enum DeviceScreenType {
  watch,
  mobile,
  tablet,
  desktop,
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class DeviceProfile extends Equatable {
  @JsonKey(
    name: 'a',
    fromJson: _screenTypeFromJson,
    toJson: _screenTypeToJson,
  )
  final DeviceScreenType screenType;

  @JsonKey(name: 'b')
  final double landscapeZoomLevel;

  @JsonKey(name: 'c')
  final double portraitZoomLevel;

  @JsonKey(name: 'd')
  final double landscapeDxOffset;

  @JsonKey(name: 'e')
  final double portraitDxOffset;

  @JsonKey(name: 'f')
  final bool blockHorizontalScrolling;

  @JsonKey(name: 'g')
  final int modePageCount;

  @JsonKey(name: 'h')
  final Axis modeScrollDirection;

  @JsonKey(name: 'i')
  final bool modeContinuous;

  static DeviceScreenType _screenTypeFromJson(int index) =>
      DeviceScreenType.values[index];

  static int _screenTypeToJson(DeviceScreenType storage) => storage.index;

  DeviceProfile({
    required this.screenType,
    required this.landscapeZoomLevel,
    required this.portraitZoomLevel,
    required this.landscapeDxOffset,
    required this.portraitDxOffset,
    required this.blockHorizontalScrolling,
    required this.modePageCount,
    required this.modeScrollDirection,
    required this.modeContinuous,
  });

  DeviceProfile.minimum({
    required DeviceScreenType screenType,
  })   : screenType = screenType,
        landscapeZoomLevel = 1,
        portraitZoomLevel = 1,
        landscapeDxOffset = 1,
        portraitDxOffset = 1,
        blockHorizontalScrolling = false,
        modePageCount = 1,
        modeScrollDirection = Axis.vertical,
        modeContinuous = true;

  @override
  List<Object?> get props => [
        screenType,
        landscapeZoomLevel,
        portraitZoomLevel,
        landscapeDxOffset,
        portraitDxOffset,
        blockHorizontalScrolling,
        modePageCount,
        modeScrollDirection,
        modeContinuous,
      ];

  DeviceProfile copyWith({
    DeviceScreenType? screenType,
    double? landscapeZoomLevel,
    double? portraitZoomLevel,
    double? landscapeDxOffset,
    double? portraitDxOffset,
    bool? blockHorizontalScrolling,
    int? modePageCount,
    Axis? modeScrollDirection,
    bool? modeContinuous,
  }) {
    return DeviceProfile(
      screenType: screenType ?? this.screenType,
      landscapeZoomLevel: landscapeZoomLevel ?? this.landscapeZoomLevel,
      portraitZoomLevel: portraitZoomLevel ?? this.portraitZoomLevel,
      landscapeDxOffset: landscapeDxOffset ?? this.landscapeDxOffset,
      portraitDxOffset: portraitDxOffset ?? this.portraitDxOffset,
      blockHorizontalScrolling:
          blockHorizontalScrolling ?? this.blockHorizontalScrolling,
      modePageCount: modePageCount ?? this.modePageCount,
      modeScrollDirection: modeScrollDirection ?? this.modeScrollDirection,
      modeContinuous: modeContinuous ?? this.modeContinuous,
    );
  }

  factory DeviceProfile.fromJson(Map<String, dynamic> json) =>
      _$DeviceProfileFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceProfileToJson(this);

  @override
  bool get stringify => true;
}

enum FileStorage {
  webCache,
  localCache,
  gDrive,
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class FileReference extends Equatable {
  @JsonKey(
    name: 'a',
    fromJson: _storageFromJson,
    toJson: _storageToJson,
  )
  final FileStorage storage;

  /// File path or ID:
  /// - null for local file on web (file data stored in browser cache storage)
  /// - file path for local file on non-web
  /// - fileId for Google Drive files
  @JsonKey(name: 'b')
  final String path;

  static FileStorage _storageFromJson(int index) => FileStorage.values[index];

  static int _storageToJson(FileStorage storage) => storage.index;

  FileReference({
    required this.storage,
    required this.path,
  });

  FileReference.minimum({
    required FileStorage storage,
  })   : storage = storage,
        path = '';

  @override
  List<Object?> get props => [
        storage,
        path,
      ];

  FileReference copyWith({
    FileStorage? storage,
    String? path,
  }) {
    return FileReference(
      storage: storage ?? this.storage,
      path: path ?? this.path,
    );
  }

  factory FileReference.fromJson(Map<String, dynamic> json) =>
      _$FileReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$FileReferenceToJson(this);

  @override
  bool get stringify => true;
}
