import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/app_library.dart';
import '../../repositories/app_library_repository.dart';

part 'app_library_state.dart';

class AppLibraryCubit extends Cubit<AppLibraryState> {
  final AppLibraryRepository _appLibraryRepository;
  StreamSubscription _appLibrariesSubscription;

  AppLibraryCubit({
    @required AppLibraryRepository appLibraryRepository,
  })  : _appLibraryRepository = appLibraryRepository,
        super(AppLibraryInitial());

  void loadAppLibraries({String userId}) async {
    _appLibrariesSubscription?.cancel();
    _appLibrariesSubscription = _appLibraryRepository.libraries(userId: userId).listen(
          (appLibraries) => emit(AppLibrariesLoaded(appLibraries)),
    );
  }

  void addAppLibrary(AppLibrary appLibrary) async {
    _appLibraryRepository.addNew(appLibrary);
  }

  @override
  Future<void> close() {
    _appLibrariesSubscription?.cancel();
    return super.close();
  }
}
