import 'package:chartmaker_app/app/data/models/student.dart';
import 'package:chartmaker_app/app/data/providers/student_firestore_provider.dart';
import 'package:chartmaker_app/app/data/providers/student_hive_provider.dart';
import 'package:chartmaker_app/app/data/services/student_service.dart';

class StudentRepository {
  late StudentService _studentService;

  Future<void> initProviders({required bool isLocal}) async {
    _studentService =
        isLocal ? StudentHiveProvider() : StudentFirestoreProvider();
    await _studentService.initProvider();
  }

  Stream<Student?> watchById(String id) {
    return _studentService.watchById(id);
  }

  Future<void> add(Student user) async {
    await _studentService.add(user);
  }

  Future<void> update(Student user) async {
    await _studentService.update(user);
  }

  // Migrate local db collections to the remote db
  Future<String> migrateLocalCollectionsToRemoteDb(String userId) async {
    // // Local services
    // final StudentService _localStudentService = StudentHiveProvider();
    // final LibraryService _localLibraryService = LibraryHiveProvider();
    // final UserDocumentDataService _localUserDocumentDataService =
    //     UserDocumentDataHiveProvider();

    // // Remote services
    // final LibraryService _remoteLibraryService = LibraryFirestoreProvider();
    // final UserDocumentDataService _remoteUserDocumentDataService =
    //     UserDocumentDataFirestoreProvider();

    // // Init local providers
    // await _localStudentService.initProvider();
    // await _localLibraryService.initProvider();
    // await _localUserDocumentDataService.initProvider();

    // // Init remote providers
    // await _remoteLibraryService.initProvider();
    // await _remoteUserDocumentDataService.initProvider();

    // // Migrate Library documents
    // await _localLibraryService.all()
    //   ..forEach((library) {
    //     // Add to remote
    //     _remoteLibraryService.add(
    //       library.copyWith(
    //         userId: userId,
    //       ),
    //     );
    //     // Remove from local
    //     _localLibraryService.removeById(library.id);
    //   });

    // // Migrate UserDocumentData documents
    // await _localUserDocumentDataService.all()
    //   ..forEach((userDocumentData) {
    //     // Add to remote
    //     _remoteUserDocumentDataService.add(
    //       userDocumentData,
    //     );
    //     // Remove from local
    //     _localUserDocumentDataService.removeById(userDocumentData.id);
    //   });

    // // Get local selectedLibraryId
    // final _localStudent = await _localStudentService.byId('local');
    // final String _selectedLibraryId = _localStudent!.selectedLibraryId;

    // // Remove local user
    // _localStudentService.removeById('local');

    // // Return local selectedLibraryId
    // return _selectedLibraryId;
    return '';
  }
}
