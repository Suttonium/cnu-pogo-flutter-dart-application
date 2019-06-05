import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:cnupogo/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = new DatabaseHelper.internal();

  factory DatabaseHelper() => _singleton;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    print("creating");
    await db.transaction((txn) async {
      await txn.execute(
          "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    });
    db.close();
  }

  // insert user into db
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    print(dbClient);
    int response = await dbClient.transaction((txn) async {
      return txn.insert("User", user.toMap());
    });
    dbClient.close();
    return response;
  }

  // delete user from db
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int response = await dbClient.delete("User");
    return response;
  }
}
