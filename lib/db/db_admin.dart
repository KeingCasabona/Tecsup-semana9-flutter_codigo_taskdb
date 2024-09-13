import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbAdmin {
  Database? myDatabase;

//SINGLETON:
  static final DbAdmin db = DbAdmin._();
  DbAdmin._();

  //VERIFICAR SI AL INICIO EXISTE EL DATABASE:
  checkDatabase() {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = initDatabase();
    return myDatabase;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'TaskDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        //CREAR LA TABLA CORRESPONDIENTE:
        await dbx.execute(
            'CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)');
      },
    );
  }
}
