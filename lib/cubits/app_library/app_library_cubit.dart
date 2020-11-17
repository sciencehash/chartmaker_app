import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sembast/sembast.dart';
import '../../stubs/sembast/sembast_stub.dart'
if (dart.library.io) '../../stubs/sembast/sembast_io.dart'
if (dart.library.html) '../../stubs/sembast/sembast_web.dart';

import '../../models/app_library.dart';
import '../../repositories/app_library_repository.dart';

part 'app_library_state.dart';

class AppLibraryCubit extends Cubit<AppLibraryState> {
  final AppLibraryRepository _appLibraryRepository;
  StreamSubscription _appLibrariesSubscription;

  Database db;

  bool defaultLibraryChecked = false;
  int currentLibraryId;

  AppLibraryCubit({
    @required AppLibraryRepository appLibraryRepository,
  })  : _appLibraryRepository = appLibraryRepository,
        super(AppLibraryInitial());

  void loadAppLibraries({int userId}) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appLibrariesSubscription?.cancel();
    _appLibrariesSubscription =
        _appLibraryRepository.libraries(db: db, userId: userId).listen(
              (appLibraries) async {
            if (!defaultLibraryChecked && appLibraries.isEmpty) {
              defaultLibraryChecked = true;
              await _appLibraryRepository.addNew(
                db: db,
                appLibrary: AppLibrary.defaultLibrary(userId),
              );
            }
            emit(AppLibrariesLoaded(appLibraries));
          },
        );
  }

  void addAppLibrary(AppLibrary appLibrary) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    _appLibraryRepository.addNew(db: db, appLibrary: appLibrary);
  }

  @override
  Future<void> close() {
    _appLibrariesSubscription?.cancel();
    return super.close();
  }
}
