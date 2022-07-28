import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class LocalDatabase {
  static Database? _database;
  static const String _tableName = 'tasks';
  static Future<void> initDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = '${databasesPath}tasks.db';
    if (_database != null) {
      return;
    } else {
      try {
        _database = await openDatabase(path, version: 2,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $_tableName " 
              "( id INTEGER PRIMARY KEY, "
              " title STRING, "
              " date STRING, "
              " start STRING, "
              " end STRING, "
              " reminder INTEGER, "
              " completed INTEGER, "
              " favourite INTEGER)"
              );
        });
      } catch (e) {
        print(e);
      }
    }
  }
  static Future<int> insertRaw(Task? task)async{
    return await _database?.insert(_tableName, task!.toMap())??0;
  }

 static Future<int> delete(Task task)async{
    return await _database?.delete(_tableName,where: 'id=?',whereArgs: [task.id])??0;
  }

 static Future<int> update(Task task,Map<String,dynamic> newValues)async{
    return await _database?.update(_tableName,newValues,where:'id=?',whereArgs: [task.id])??0;
  }

 static Future<List<Map<String, dynamic>>?> getData()async{
    return await _database?.query(_tableName);
  }
}
