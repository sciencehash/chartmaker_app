part of 'app_library_cubit.dart';

abstract class AppLibraryState extends Equatable {
  const AppLibraryState();
}

class AppLibraryInitial extends AppLibraryState {
  @override
  List<Object> get props => [];
}

class AppLibrariesLoaded extends AppLibraryState {
  final List<AppLibrary> appLibraries;

  const AppLibrariesLoaded([this.appLibraries]);

  @override
  List<Object> get props => [appLibraries];

  @override
  bool get stringify => true;
}
