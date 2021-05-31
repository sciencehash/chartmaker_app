import 'package:chartmaker_app/app/data/models/library.dart';

abstract class LibraryService {
  ///
  Future<void> initProvider();

  ///
  Future<Library?> byId(String id);

  ///
  Stream<Library?> watchById(String id);

  ///
  Future<String> add(Library library);

  ///
  Future<void> update(Library library);

  ///
  Future<void> removeById(String id);

  ///
  Future<List<Library>> all();
}
