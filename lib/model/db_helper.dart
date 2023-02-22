import 'package:dashboard/model/item_model.dart';
import 'package:sqflite/sqflite.dart ' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart%20';

class DBHelper {
  static Future<Database> _getDataBase() async {
    //here we get android and ios sql DB, and get the path to it  ...daPath i string
    final dbPath = await sql.getDatabasesPath();
    // here we open our Db if it exists , or create new one
    // sqlDb is the name of our dataBase

    return await sql.openDatabase(path.join(dbPath, 'places.db'), version: 1,
        onCreate: (db, version) {
      // create new table which called user_places
      return db.execute(
        'CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT ,price REAL)',
      );
    });
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    // here we get our database
    final db = await DBHelper._getDataBase();
    // insert row in this pre specified table .... data must match column names in the table with the same order
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

// always data that returns from database  is list<map<string,dynamic>>
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // here we  call _getDataBase to get our lovely database
    final db = await DBHelper._getDataBase();
    return db.query(table);
  }

  static Future<int> updateData(Item item) async {
    // here we  call _getDataBase to get our lovely database
    final db = await DBHelper._getDataBase();
    return db.rawUpdate(
      'UPDATE items SET name = ?,  price = ? WHERE id = ? ',
      [item.name, item.price, item.id],
    );
  }

  static Future<int> deleteData(int id) async {
    // here we  call _getDataBase to get our lovely database
    final db = await DBHelper._getDataBase();
    return db.rawDelete(
      'DELETE FROM items WHERE id = ? ',
      [id],
    );
  }
}
