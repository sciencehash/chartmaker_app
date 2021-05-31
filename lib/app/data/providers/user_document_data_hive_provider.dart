import 'dart:async';

import 'package:hive/hive.dart';
import 'package:chartmaker_app/app/core/utils/helpers/model.dart';
import 'package:chartmaker_app/app/data/models/user_document_data.dart';
import 'package:chartmaker_app/app/data/services/user_document_data_service.dart';

class UserDocumentDataHiveProvider extends UserDocumentDataService {
  // Hive box instance
  late Box _hiveBox;

  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('userDocumentData');
  }

  ///
  Future<UserDocumentData?> byId(String id) async {
    final boxValue = _hiveBox.get(id);
    return boxValue != null
        ? UserDocumentData.fromJson(Map<String, dynamic>.from(boxValue))
        : null;
  }

  ///
  Stream<UserDocumentData?> watchById(String id) async* {
    var firstValue = _hiveBox.get(id);

    if (firstValue != null) {
      //
      yield UserDocumentData.fromJson(
        Map<String, dynamic>.from(
          firstValue,
        ),
      );
    } else {
      yield null;
    }
    //
    yield* _hiveBox.watch(key: id).map((event) {
      return event.value != null
          ? UserDocumentData.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  Future<String> add(UserDocumentData userDocumentData) async {
    if (userDocumentData.id == '')
      userDocumentData = userDocumentData.copyWith(
        id: ModelHelpers.generateFirestoreID(),
      );
    await _hiveBox.put(userDocumentData.id, userDocumentData.toJson());
    return userDocumentData.id;
  }

  ///
  Future<void> update(UserDocumentData userDocumentData) async {
    // print('print provider');
    await _hiveBox.put(userDocumentData.id, userDocumentData.toJson());
  }

  ///
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }

  ///
  Future<List<UserDocumentData>> all() async {
    List<UserDocumentData> libraries = [];
    final keys = List<String>.from(_hiveBox.keys);
    for (String key in keys) {
      var value = await _hiveBox.get(key);
      libraries.add(
        UserDocumentData.fromJson(Map<String, dynamic>.from(value)),
      );
    }
    return libraries;
  }
}
