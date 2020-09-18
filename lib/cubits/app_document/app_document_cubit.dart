import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// import 'package:sembast/sembast.dart';

// import '../../repositories/local_storage_repository.dart';

import '../../models/app_user.dart';

import '../../models/app_document.dart';
import '../../repositories/app_document_repository.dart';

part 'app_document_state.dart';

class AppDocumentCubit extends Cubit<AppDocumentState> {
  final AppDocumentRepository _appDocumentRepository;
  StreamSubscription _appDocumentsSubscription;
  StreamSubscription _appDocumentSubscription;

  AppDocumentCubit({
    @required AppDocumentRepository appDocumentRepository,
  })  : _appDocumentRepository = appDocumentRepository,
        super(AppDocumentInitial());

  void loadAppDocuments({
    String userId,
    String libraryId,
  }) async {
    _appDocumentsSubscription?.cancel();
    _appDocumentsSubscription = _appDocumentRepository
        .documents(
      userId: userId,
      libraryId: libraryId,
    )
        .listen(
      (appDocuments) async {
        emit(AppDocumentsLoaded(
          libraryId: libraryId,
          appDocuments: appDocuments,
        ));
      },
    );
  }

  void loadAppDocument({
    @required AppUser user,
    @required String documentId,
    bool withFileData = true,
  }) async {
    _appDocumentSubscription?.cancel();
    _appDocumentSubscription = _appDocumentRepository
        .document(
      userId: user.id,
      documentId: documentId,
    )
        .listen(
      (appDocument) async {

        // Default values, null for no changes
        int localPageNum;
        double localScale;

        // If local value is more recent of remote db values
        // if (isLocalDataMoreRecent) {
        //   // Get pageNum saved locally (null for no changes)
        //   localPageNum = await LocalStorageRepository.getDocumentPageNumber(
        //         localStorageDb: localStorageDb,
        //         documentId: appDocument.id,
        //       ) ??
        //       null;
        //
        //   // Get scale saved locally (null for no changes)
        //   localScale = await LocalStorageRepository.getDocumentScale(
        //         localStorageDb: localStorageDb,
        //         documentId: appDocument.id,
        //       ) ??
        //       null;
        // } else {
        //   // Use remote utcLastUpdate value
        //   localUtcLastUpdate = null;
        // }

        // emit(
        //   AppDocumentLoaded(
        //     appDocument.copyWith(
        //       coverThumbnail: thumbnailData,
        //       fileData: fileData,
        //       pageNum: localPageNum,
        //       scale: localScale,
        //       utcLastUpdate: localUtcLastUpdate,
        //     ),
        //   ),
        // );
      },
    );
  }

  void addAppDocument(AppDocument appDocument) async {
    _appDocumentRepository.addNew(appDocument);
  }

  void updateAppDocument({
    @required AppDocument appDocument,
    // @required Database localStorageDb,
  }) async {
    // Get utcLastUpdate saved locally
    // final DateTime localUtcLastUpdate =
    //     await LocalStorageRepository.getDocumentUtcLastUpdate(
    //           localStorageDb: localStorageDb,
    //           documentId: appDocument.id,
    //         ) ??
    //         null;
    //
    // // Get pageNum saved locally
    // final localPageNum = await LocalStorageRepository.getDocumentPageNumber(
    //       localStorageDb: localStorageDb,
    //       documentId: appDocument.id,
    //     ) ??
    //     null;
    //
    // // Get scale saved locally
    // final localScale = await LocalStorageRepository.getDocumentScale(
    //       localStorageDb: localStorageDb,
    //       documentId: appDocument.id,
    //     ) ??
    //     null;
    //
    // // If local value is more recent of remote db values
    // if (localUtcLastUpdate != null &&
    //     localUtcLastUpdate.isAfter(appDocument.utcLastUpdate)) {
    //   // Use local values in AppDocument
    //   appDocument = appDocument.copyWith(
    //     pageNum: localPageNum,
    //     scale: localScale,
    //     utcLastUpdate: localUtcLastUpdate,
    //   );
    // }
    //
    // //
    // _appDocumentRepository.update(appDocument);
  }

  void deleteAppDocument(AppDocument appDocument) async {
    _appDocumentRepository.delete(appDocument);
  }

  @override
  Future<void> close() {
    _appDocumentsSubscription?.cancel();
    _appDocumentSubscription?.cancel();
    return super.close();
  }
}
