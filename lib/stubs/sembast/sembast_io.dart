import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> openSembastDB() async {
    final String dbPath = 'flutterstudio.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    return await dbFactory.openDatabase(dbPath);
}
