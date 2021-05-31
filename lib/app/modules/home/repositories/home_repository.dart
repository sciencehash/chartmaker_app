import 'dart:typed_data';

import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/data/models/user_document_data.dart';
import 'package:chartmaker_app/app/data/providers/library_firestore_provider.dart';
import 'package:chartmaker_app/app/data/providers/user_document_data_firestore_provider.dart';
import 'package:chartmaker_app/app/data/providers/user_document_data_hive_provider.dart';
import 'package:chartmaker_app/app/data/services/library_service.dart';
import 'package:chartmaker_app/app/data/providers/library_hive_provider.dart';
import 'package:chartmaker_app/app/data/services/user_document_data_service.dart';

class HomeRepository {
  late LibraryService _libraryService;
  late UserDocumentDataService _userDocumentDataService;

  Future<void> initProviders({required bool isLocal}) async {
    //
    // Init Library service
    //

    _libraryService =
        isLocal ? LibraryHiveProvider() : LibraryFirestoreProvider();

    await _libraryService.initProvider();

    //
    // Init User Document Data service
    //

    _userDocumentDataService = isLocal
        ? UserDocumentDataHiveProvider()
        : UserDocumentDataFirestoreProvider();

    await _userDocumentDataService.initProvider();
  }

  Stream<Library?> watchLibraryById(String id) {
    return _libraryService.watchById(id);
  }

  Future<String> addLibrary(Library library) async {
    return await _libraryService.add(library);
  }

  Future<void> updateLibrary(Library library) async {
    await _libraryService.update(library);
  }

  Future<void> removeLibraryById(String id) async {
    await _libraryService.removeById(id);
  }

  Future<List<Library>> getAllLibraries() async {
    return await _libraryService.all();
  }

  //
  //
  //

  Future<String> addUserDocumentData(
    UserDocumentData userDocumentData,
    Uint8List? data,
  ) async {
    final String newUDDId = await _userDocumentDataService.add(
      userDocumentData,
    );

    return newUDDId;
  }

  Future<void> removeUserDocumentDataById(String id) async {
    await _userDocumentDataService.removeById(id);
  }
}
