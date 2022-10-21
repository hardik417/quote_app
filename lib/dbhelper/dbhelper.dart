import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper{

  Future<Database> createdb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'quoteapp.db');


    // open the database sqflite
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY autoincrement, name TEXT, link TEXT, desc TEXT)');
        });
    return database;
  }

  Future<List<Map>> viewdb(Database db) async {

    String viewquery = "select * from Test";

    List<Map> list = await db.rawQuery(viewquery);

    return list;
  }

   adddata({required Database db,required String name,required String link,required String desc}) {
    String add = "insert into test (name, link, desc) values('$name','$link','$desc')";

    db.rawInsert(add);
  }

  void updatevalue(Database db, String name, String number, int id) {
    String update = "update test set name = '$name' , number = '$number' where id = '$id'";

    db.rawUpdate(update);
  }

  void deletedata({required Database db,required String id}) {
    String deletedata = "delete from test where name = '$id'";

    db.rawDelete(deletedata);
  }



}