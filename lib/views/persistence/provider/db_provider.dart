import 'dart:async';

import 'package:flutter_learning/views/persistence/model/dog.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  final String DOG_TABLE = 'dogs';
  static final DBProvider db = DBProvider();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return openDatabase(join(await getDatabasesPath(), 'doggie_database.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    }, version: 1);
  }

  Future<List<Dog>> getDogs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(DOG_TABLE);
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;
    await db.insert(
      DOG_TABLE,
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDog(Dog dog) async {
    final Database db = await database;
    await db.update(DOG_TABLE, dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    await db.delete(DOG_TABLE, where: 'id=?', whereArgs: [id]);
  }
}
