import 'dart:async';

import 'package:hive/hive.dart';
import 'package:chartmaker_app/app/core/utils/helpers/model.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/data/services/library_service.dart';

class LibraryHiveProvider extends LibraryService {
  // Hive box instance
  late Box _hiveBox;

  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('libraries');
  }

  ///
  Future<Library?> byId(String id) async {
    final boxValue = _hiveBox.get(id);
    return boxValue != null
        ? Library.fromJson(Map<String, dynamic>.from(boxValue))
        : null;
  }

  ///
  Stream<Library?> watchById(String id) async* {
    var firstValue = _hiveBox.get(id);

    if (firstValue != null) {
      //
      yield Library.fromJson(
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
          ? Library.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  Future<String> add(Library library) async {
    if (library.id == '')
      library = library.copyWith(
        id: ModelHelpers.generateFirestoreID(),
      );
    await _hiveBox.put(library.id, library.toJson());
    return library.id;
  }

  ///
  Future<void> update(Library library) async {
    await _hiveBox.put(library.id, library.toJson());
  }

  ///
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }

  ///
  Future<List<Library>> all() async {
    List<Library> libraries = [];
    final keys = List<String>.from(_hiveBox.keys);
    for (String key in keys) {
      var value = await _hiveBox.get(key);
      libraries.add(
        Library.fromJson(Map<String, dynamic>.from(value)),
      );
    }
    return libraries;
  }
}
