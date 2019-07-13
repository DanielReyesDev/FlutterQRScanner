import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter_qr_scanner/src/models/scan.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "scansDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' value TEXT,'
          ')'
        );
      }
    );
  }


  // CRUD
  newScanRaw(Scan scan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES ('${scan.id}','${scan.type}','${scan.value}')"
    );
    return res;
  }

  newScan(Scan scan) async{
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    return res; 
  }

  Future<Scan> getScanId(int id) async {
    final db = await database;
    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Scan.fromJson(res.first) : null;
  }

  Future<List<Scan>> getScans() async {
    final db = await database;
    final res = await db.query("Scans");
    List<Scan> list = res.isEmpty
                      ? res.map((scan) => Scan.fromJson(scan)).toList()
                      : [];
    return list;
  }

  Future<List<Scan>> getScansByType() async {

  }





}