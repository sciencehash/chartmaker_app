part of 'app_document_cubit.dart';

abstract class AppDocumentState extends Equatable {
  const AppDocumentState();
}

class AppDocumentInitial extends AppDocumentState {
  @override
  List<Object> get props => [];
}

class AppDocumentsLoaded extends AppDocumentState {
  final String libraryId;
  final List<AppDocument> appDocuments;

  const AppDocumentsLoaded({
    this.libraryId,
    this.appDocuments,
  });

  @override
  List<Object> get props => [appDocuments, libraryId];

  @override
  bool get stringify => true;
}

class AppDocumentLoaded extends AppDocumentState {
  final AppDocument appDocument;

  const AppDocumentLoaded([this.appDocument]);

  @override
  List<Object> get props => [appDocument];

  @override
  bool get stringify => true;
}
