import 'dart:io';
import 'package:flutter_codigo_taskdb/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbAdmin {
  Database? myDatabase;

//SINGLETON:
  static final DbAdmin db = DbAdmin._();
  DbAdmin._();

  //VERIFICAR SI AL INICIO EXISTE EL DATABASE:
  Future<Database?> checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = await initDatabase();
    return myDatabase;
  }

  Future<Database> initDatabase() async {
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

  insertRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        'INSERT INTO TASK(title, description,status) VALUES ("Ir de compras","Tenemos que ir a Tottus","false")');
    print(res);
  }

  insertTask() async {
    Database? db = await checkDatabase();
    int res = await db!.insert('TASK', {
      'title': 'Ir de compras',
      'description': 'Tenemos que ir a Tottus',
      'status': 'false'
    });
    print(res);
  }

  getRawTask() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery('SELECT * FROM TASK');
    print(tasks);
  }

  Future<List<TaskModel>> getTask() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query('TASK');
    List<TaskModel> taskModelList =
        tasks.map((e) => TaskModel.deMapAModel(e)).toList();

    return taskModelList;
  }

  updateRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE TASK SET title='x',description='xx',status='xxx' WHERE id=2");
    print(res);
  }

  updateTask() async {
    Database? db = await checkDatabase();
    int res = await db!.update(
        'TASK', {'title': 'y', 'description': 'yy', 'status': 'yyy'},
        where: 'id=1');
    print(res);
  }

  deleteRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawDelete('DELETE FROM TASK WHERE id =3');
    print(res);
  }

  deleteTask() async {
    Database? db = await checkDatabase();
    int res = await db!.delete('TASK', where: 'id=1');
    print(res);
  }
}
