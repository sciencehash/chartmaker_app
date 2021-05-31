import 'dart:async';

import 'package:chartmaker_app/app/controllers/app_user_controller.dart';
import 'package:chartmaker_app/app/controllers/auth_controller.dart';
import 'package:chartmaker_app/app/data/models/app_user.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/modules/home/repositories/home_repository.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/directory/delete_directory_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/directory/edit_directory_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/directory/new_directory_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/document/delete_document_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/document/edit_document_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/library/change_library_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/library/edit_library_dialog_content.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/library/new_library_dialog_content.dart';
import 'package:get/get.dart';

class LibraryController extends GetxController {
  StreamSubscription? _authUserStateSubscription;

  final _appUserCtrl = AppUserController.to;
  StreamSubscription? _appUserSubscription;

  final HomeRepository _homeRepository = HomeRepository();
  StreamSubscription? _librarySubscription;

  bool _creatingDefaultLibrary = false;

  Rxn<Library> currentLibrary = Rxn<Library>();

  var dirs = <DocumentDirectory>[].obs;
  var docs = <DocumentFile>[].obs;

  // Directories entered by the user, each item represents a level of depth.
  var dirLevels = <DocumentDirectory>[].obs;

  // Library list obtained in _loadAllLibraries()
  var libraries = <Library>[].obs;

  // ID of the selected library to save in the AppUser object
  late String selectedLibraryId;

  // If a file is currently downloading or getting from some storage
  var isGettingFile = false.obs;

  @override
  void onInit() async {
    //
    final _authCtrl = AuthController.to;
    //
    _authUserStateSubscription = _authCtrl.watchUserState.listen(
      _handleAuthStateChanges,
    );

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() async {
    await _authUserStateSubscription?.cancel();
    await _librarySubscription?.cancel();
    await _appUserSubscription?.cancel();
    super.onClose();
  }

  // Handle changes between 'authenticated' and 'unauthenticated'
  Future<void> _handleAuthStateChanges(firebaseUser) async {
    // First of all, after an auth state change, close all subscriptions
    await _librarySubscription?.cancel();
    await _appUserSubscription?.cancel();

    // Reset values
    selectedLibraryId = '';

    //
    await _homeRepository.initProviders(
      isLocal: firebaseUser == null,
    );

    // Listen for AppUser changes
    _appUserSubscription = _appUserCtrl.appUser.listen(
      _handleAppUserChanges,
    );

    // For cases in which the user enters directly to a page other than
    // this one, and then enters this page and at that moment the AppUser
    // 'listen' needs a refresh, since that listen is started from the other
    // page and no longer produces initial calls.
    // This Refresh must go here so that the Providers in the
    // repository are previously initiated.
    if (_appUserCtrl.appUser.value != null) {
      _appUserCtrl.appUser.refresh();
    }
  }

  // Handle changes in _appUserCtrl.appUser
  Future<void> _handleAppUserChanges(AppUser? user) async {
    // Avoid first reaction after user sign up
    if (_appUserCtrl.isLogged.value && user!.id == 'local' ||
        _appUserCtrl.isMigratingLocalDataToRemote) {
      return null;
    }

    // If change the selected library,
    // or on init when selectedLibraryId == ''
    if (user!.selectedLibraryId != selectedLibraryId) {
      //
      selectedLibraryId = user.selectedLibraryId;

      //
      await _loadLibrary();
    }
  }

  Future<void> _loadLibrary() async {
    //
    await _librarySubscription?.cancel();
    //
    _librarySubscription =
        _homeRepository.watchLibraryById(selectedLibraryId).listen(
      (library) async {
        // Create a library if not exists
        if (library == null) {
          //
          if (!_creatingDefaultLibrary) {
            //
            await _librarySubscription?.cancel();
            //
            _creatingDefaultLibrary = true;

            // Add and save
            final newLibraryId = await _homeRepository.addLibrary(
              Library.minimum(
                id: '',
                userId: _appUserCtrl.appUser.value!.id,
                title: 'Default library',
              ),
            );

            //
            await _saveSelectedLibraryId(newLibraryId);
          }
        } else {
          //
          _creatingDefaultLibrary = false;

          //
          dirs.value = library.dirs;
          docs.value = library.docs;

          // Find and get the dirs and docs for the current directory level
          for (DocumentDirectory dirLevel in dirLevels) {
            //
            for (DocumentDirectory dirRef in dirs) {
              if (dirLevel == dirRef) {
                dirs.value = dirRef.dirs;
                docs.value = dirRef.docs;
                break;
              }
            }
          }

          // Set new value and refresh view
          currentLibrary.value = library;
          currentLibrary.refresh();
        }
      },
    );
  }

  Future<void> addLibrary() async {
    final String? libraryName = await Get.dialog(
      NewLibraryDialogContent(),
    );

    if (libraryName != null) {
      // Add and save
      final newLibraryId = await _homeRepository.addLibrary(
        Library.minimum(
          id: '',
          userId: _appUserCtrl.appUser.value!.id,
          title: libraryName,
        ),
      );

      //
      await _saveSelectedLibraryId(newLibraryId);
    }
  }

  Future<void> editLibrary() async {
    final String? libraryName = await Get.dialog(
      EditLibraryDialogContent(
        library: currentLibrary.value!,
      ),
    );

    if (libraryName != null) {
      // Add and save
      await _homeRepository.updateLibrary(
        currentLibrary.value!.copyWith(
          title: libraryName,
        ),
      );
    }
  }

  Future<void> changeLibrary() async {
    _loadAllLibraries();

    final String? libraryId = await Get.dialog(
      ChangeLibraryDialogContent(),
    );

    if (libraryId != null) {
      //
      await _saveSelectedLibraryId(libraryId);
    }
  }

  Future<void> _saveSelectedLibraryId(String libraryId) async {
    await _appUserCtrl.updateAppUser(
      _appUserCtrl.appUser.value!.copyWith(
        selectedLibraryId: libraryId,
      ),
    );
  }

  Future<void> removeLibrary(String _libraryId) async {
    // Cancel library subscription to avoid reactions before save changes
    await _librarySubscription?.cancel();

    // Get libraries
    List<Library> _libraries = await _homeRepository.getAllLibraries();

    // Remove the library from this list
    _libraries.removeWhere((l) => l.id == _libraryId);

    // Remove the library from the db
    await _homeRepository.removeLibraryById(_libraryId);

    // Save the new selected library ID
    await _saveSelectedLibraryId(
      _libraries.isEmpty ? '[create_default]' : _libraries.first.id,
    );
  }

  Future<void> _loadAllLibraries() async {
    libraries.value = [];
    libraries.value = await _homeRepository.getAllLibraries();
  }

  void addDirectory() async {
    int _getNextDirsIdLib() {
      currentLibrary.value = currentLibrary.value!.copyWith(
        lastDirsIdLib: currentLibrary.value!.lastDirsIdLib + 1,
      );
      return currentLibrary.value!.lastDirsIdLib;
    }

    final String? dirName = await Get.dialog(
      NewDirectoryDialogContent(),
    );

    if (dirName != null) {
      // Add and save
      await _addDirectory(
        DocumentDirectory.minimum(
          idLib: _getNextDirsIdLib(),
          title: dirName,
        ),
      );
    }
  }

  Future<void> renameDirectory(DocumentDirectory directory) async {
    final String? directoryName = await Get.dialog(
      EditDirectoryDialogContent(
        directory: directory,
      ),
    );

    if (directoryName != null) {
      // Save
      await _updateDirectory(
        directory.copyWith(
          title: directoryName,
        ),
      );
    }
  }

  void deleteDirectory(DocumentDirectory directory) async {
    final bool? confirmed = await Get.dialog(
      DeleteDirectoryDialogContent(
        directory: directory,
      ),
    );

    if (confirmed != null && confirmed == true) {
      // Delete
      await _deleteDirectory(
        directory,
      );
    }
  }

  void toggleViewMode() {
    //
    _homeRepository.updateLibrary(
      currentLibrary.value!.copyWith(
        viewMode: currentLibrary.value!.viewMode == 'list' ? 'grid' : 'list',
      ),
    );
  }

  void toDirectory(DocumentDirectory directory) {
    dirLevels.add(directory);
    dirs.value = directory.dirs;
    docs.value = directory.docs;
  }

  void outsideDirectory() {
    dirLevels.removeLast();
    if (dirLevels.isEmpty) {
      dirs.value = currentLibrary.value!.dirs;
      docs.value = currentLibrary.value!.docs;
    } else {
      dirs.value = dirLevels.last.dirs;
      docs.value = dirLevels.last.docs;
    }
  }

  //
  Future<void> _addDirectory(DocumentDirectory directory) async {
    await _saveDirectoryOrDocumentFile(directory, 'add');
  }

  //
  Future<void> _updateDirectory(DocumentDirectory directory) async {
    await _saveDirectoryOrDocumentFile(directory, 'update');
  }

  //
  Future<void> _deleteDirectory(DocumentDirectory directory) async {
    await _saveDirectoryOrDocumentFile(directory, 'delete');
  }

  //
  Future<void> _addDocumentFile(DocumentFile document) async {
    await _saveDirectoryOrDocumentFile(document, 'add');
  }

  //
  Future<void> _updateDocumentFile(DocumentFile document) async {
    await _saveDirectoryOrDocumentFile(document, 'update');
  }

  //
  Future<void> _deleteDocumentFile(DocumentFile document) async {
    await _saveDirectoryOrDocumentFile(document, 'delete');
  }

  //
  Future<void> _saveDirectoryOrDocumentFile(
    dynamic input,
    String action,
  ) async {
    if (dirLevels.isEmpty) {
      //
      // Add directly on the library
      //
      if (input is DocumentDirectory) {
        if (action == 'add') {
          // Add the new directory
          currentLibrary.value!.dirs.add(input);
        } else if (action == 'update') {
          //
          int dirIdx = currentLibrary.value!.dirs
              .indexWhere((d) => d.idLib == input.idLib);
          //
          currentLibrary.value!.dirs[dirIdx] = input;
        } else if (action == 'delete') {
          // Delete all UserDocumentData of documents in this directory
          await _deleteAllUserDocumentDataByDirectory(
            currentLibrary.value!.dirs
                .firstWhere((d) => d.idLib == input.idLib),
          );
          //
          currentLibrary.value!.dirs.removeWhere((d) => d.idLib == input.idLib);
        }
      } else if (input is DocumentFile) {
        if (action == 'add') {
          // Add the new document
          currentLibrary.value!.docs.add(input);
        } else if (action == 'update') {
          //
          int docIdx = currentLibrary.value!.docs
              .indexWhere((d) => d.idLib == input.idLib);
          //
          currentLibrary.value!.docs[docIdx] = input;
        } else if (action == 'delete') {
          // Delete the UserDocumentData of this document
          await _deleteUserDocumentDataByDocument(
            currentLibrary.value!.docs
                .firstWhere((d) => d.idLib == input.idLib),
          );
          //
          currentLibrary.value!.docs.removeWhere((d) => d.idLib == input.idLib);
        }
      }
    } else {
      //
      // Add inside a directory,
      // looking for the correct directory from the root of the library.
      //

      // Note: Although 'dirs' is a reference to 'currentLibrary.dirs',
      // it is not possible to directly edit 'dirs'
      // because after the first edit the reference is lost.

      // Get reference
      var tempDirsRef = currentLibrary.value!.dirs;
      // Iterate all levels
      for (DocumentDirectory dirLevel in dirLevels) {
        // Iterate directories in this level
        for (DocumentDirectory tempDirRef in tempDirsRef) {
          // If is a directory in the 'dirLevels' list
          if (dirLevel == tempDirRef) {
            // If is the last entered level, the current level
            if (dirLevel == dirLevels.last) {
              if (input is DocumentDirectory) {
                if (action == 'add') {
                  // Add the new directory
                  tempDirRef.dirs.add(input);
                } else if (action == 'update') {
                  //
                  int dirIdx =
                      tempDirRef.dirs.indexWhere((d) => d.idLib == input.idLib);
                  //
                  tempDirRef.dirs[dirIdx] = input;
                } else if (action == 'delete') {
                  // Delete all UserDocumentData of documents in this directory
                  await _deleteAllUserDocumentDataByDirectory(
                    tempDirRef.dirs.firstWhere((d) => d.idLib == input.idLib),
                  );
                  //
                  tempDirRef.dirs.removeWhere((d) => d.idLib == input.idLib);
                }
              } else if (input is DocumentFile) {
                if (action == 'add') {
                  // Add the new document
                  tempDirRef.docs.add(input);
                } else if (action == 'update') {
                  //
                  int docIdx =
                      tempDirRef.docs.indexWhere((d) => d.idLib == input.idLib);
                  //
                  tempDirRef.docs[docIdx] = input;
                } else if (action == 'delete') {
                  // Delete the UserDocumentData of this document
                  await _deleteUserDocumentDataByDocument(
                    tempDirRef.docs.firstWhere((d) => d.idLib == input.idLib),
                  );
                  //
                  tempDirRef.docs.removeWhere((d) => d.idLib == input.idLib);
                }
              }

              // Update directory in the 'dirLevels' list
              final dirLevelIdx = dirLevels.indexOf(dirLevel);
              dirLevels[dirLevelIdx] = tempDirRef;
            }

            // Update directory reference with its subdirectories
            // for the next loop (next level)
            tempDirsRef = tempDirRef.dirs;

            // No find more in this level
            break;
          }
        }
      }
    }

    // Save the new directory or document file
    _homeRepository.updateLibrary(
      currentLibrary.value!,
    );
  }

  int _getNextDocsIdLib() {
    currentLibrary.value = currentLibrary.value!.copyWith(
      lastDocsIdLib: currentLibrary.value!.lastDocsIdLib + 1,
    );
    return currentLibrary.value!.lastDocsIdLib;
  }

  void addLocalFile() async {
    // //
    // isGettingFile.value = true;

    // // Get local file or files with the file picker
    // FilePickerResult? result = await FileRepository().getLocalFile();

    // if (result != null) {
    //   result.files.forEach((file) async {
    //     // Get.snackbar(
    //     //   'File',
    //     //   '${file.path} ${file.name} ${file.bytes?.length}',
    //     //   backgroundColor: Colors.black.withOpacity(.8),
    //     //   colorText: Colors.white,
    //     //   snackPosition: SnackPosition.BOTTOM,
    //     //   borderRadius: 8,
    //     //   margin: const EdgeInsets.all(10),
    //     // );

    //     var docFile = DocumentFile.minimum(
    //       idLib: _getNextDocsIdLib(),
    //       title: file.name!,
    //     );

    //     // Add and save
    //     await _addDocumentFile(docFile);

    //     // Add User Document Data
    //     await _homeRepository.addUserDocumentData(
    //       UserDocumentData.minimum(
    //         id: '${currentLibrary.value!.id}-${docFile.idLib}',
    //       ).copyWith(
    //         files: [
    //           FileReference.minimum(
    //             storage: GetPlatform.isWeb
    //                 ? FileStorage.webCache
    //                 : FileStorage.localCache,
    //           ).copyWith(
    //             path: GetPlatform.isWeb ? null : file.path,
    //           ),
    //         ],
    //       ),
    //       GetPlatform.isWeb ? file.bytes : null,
    //     );
    //   });
    // } else {
    //   // User canceled the picker
    // }

    // //
    // isGettingFile.value = false;
  }

  void addGoogleDriveFile() async {
    // Map<String, dynamic>? driveData = await Get.dialog(
    //   DialogScaffold(
    //     title: 'Google Drive',
    //     content: GoogleDriveExplorerView(),
    //     maxWidth: 550,
    //     contentHorizontalPadding: 0,
    //   ),
    // );

    // if (driveData != null) {
    //   // Futuro: si un item de selectedDriveFiles en un folder, puedo utilizar
    //   // esta lista para obtener los archivos y carpetas dentro de ese folder
    //   // final List<drive.File> allDriveFiles = driveData['allDriveFiles'];

    //   final List<drive.File> selectedDriveFiles =
    //       driveData['selectedDriveFiles'];

    //   for (drive.File driveFile in selectedDriveFiles) {
    //     var docFile = DocumentFile.minimum(
    //       idLib: _getNextDocsIdLib(),
    //       title: driveFile.name!,
    //     );

    //     // Add and save
    //     await _addDocumentFile(docFile);

    //     // Add User Document Data
    //     await _homeRepository.addUserDocumentData(
    //       UserDocumentData.minimum(
    //         id: '${currentLibrary.value!.id}-${docFile.idLib}',
    //       ).copyWith(
    //         files: [
    //           FileReference.minimum(
    //             storage: FileStorage.gDrive,
    //           ).copyWith(
    //             path: driveFile.id,
    //           ),
    //         ],
    //       ),
    //       null,
    //     );
    //   }
    // }
  }

  Future<void> renameDocument(DocumentFile document) async {
    final String? documentName = await Get.dialog(
      EditDocumentDialogContent(
        document: document,
      ),
    );

    if (documentName != null) {
      // Save
      await _updateDocumentFile(
        document.copyWith(
          title: documentName,
        ),
      );
    }
  }

  void deleteDocument(DocumentFile document) async {
    final bool? confirmed = await Get.dialog(
      DeleteDocumentDialogContent(
        document: document,
      ),
    );

    if (confirmed != null && confirmed == true) {
      // Delete
      await _deleteDocumentFile(
        document,
      );
    }
  }

  Future<void> _deleteUserDocumentDataByDocument(
    DocumentFile document,
  ) async {
    await _homeRepository.removeUserDocumentDataById(
      '${currentLibrary.value!.id}-${document.idLib}',
    );
  }

  Future<void> _deleteAllUserDocumentDataByDirectory(
    DocumentDirectory directory,
  ) async {
    // Remove in documents of this directory
    for (DocumentFile document in directory.docs) {
      await _deleteUserDocumentDataByDocument(document);
    }
    // Remove recursively in documents in subdirectories
    for (DocumentDirectory directory in directory.dirs) {
      await _deleteAllUserDocumentDataByDirectory(directory);
    }
  }
}
