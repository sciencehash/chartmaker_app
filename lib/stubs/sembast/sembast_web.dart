import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

Future<Database> openSembastDB() async {
  final String dbPath = 'flutterstudio';
  DatabaseFactory dbFactory = databaseFactoryWeb;
  return await dbFactory.openDatabase(dbPath);
}