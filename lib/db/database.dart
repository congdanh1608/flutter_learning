import 'dart:io';

import 'package:flutter_learning/db/client.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDB();

    return _database!;
  }

  //table name
  final String DB_NAME = "TestDB.db";
  final String TABLE_CLIENT = "Client";
  final String COLUMN_ID = "id";
  final String COLUMN_FIRSTNAME = "firstName";
  final String COLUMN_LASTNAME = "lastName";
  final String COLUMN_BLOCKED = "blocked";

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db
          .execute('CREATE TABLE Client ($COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_FIRSTNAME Text, $COLUMN_LASTNAME Text, $COLUMN_BLOCKED BIT)');
    });
  }

  addNewClient(Client client) async {
    final db = await (database);
    var res = await db.insert(TABLE_CLIENT, client.toJson());
    return res;
  }

  getAllClients() async {
    final db = await (database);
    var res = await db.query(TABLE_CLIENT);
    return res.map<Client>((e) => Client.fromJson(e)).toList();
  }

  getAllUnBlockedClients() async {
    final db = await (database);
    var res = await db.rawQuery('SELECT * FROM $TABLE_CLIENT WHERE $COLUMN_BLOCKED = 0');
    return res.map((e) => Client.fromJson(e)).toList();
  }

  getClient(int id) async {
    final db = await (database);
    var res = await db.query(TABLE_CLIENT, where: '$COLUMN_ID = ?', whereArgs: [id]);
    return res.map((e) => Client.fromJson(e));
  }

  updateClient(Client client) async {
    final db = await (database);
    var res = await db.update(TABLE_CLIENT, client.toJson(), where: '$COLUMN_ID = ?', whereArgs: [client.id]);
    return res;
  }

  blockOrUnblock(Client client) async {
    final db = await (database);
    Client item = Client(client.firstName, client.lastName, client.blocked == 1 ? 0 : 1);
    var res = await db.update(TABLE_CLIENT, item.toJson(), where: '$COLUMN_ID = ?', whereArgs: [client.id]);
    return res;
  }

  deleteClient(int? id) async {
    final db = await (database);
    await db.delete(TABLE_CLIENT, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  deleteAllClients() async {
    final db = await (database);
    await db.delete(TABLE_CLIENT);
  }
}
