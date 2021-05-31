import 'package:chartmaker_app/app/data/models/user_document_data.dart';

abstract class UserDocumentDataService {
  ///
  Future<void> initProvider();

  ///
  Future<UserDocumentData?> byId(String id);

  ///
  Stream<UserDocumentData?> watchById(String id);

  ///
  Future<String> add(UserDocumentData userDocumentData);

  ///
  Future<void> update(UserDocumentData userDocumentData);

  ///
  Future<void> removeById(String id);

  ///
  Future<List<UserDocumentData>> all();
}
