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
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "ScansDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' value TEXT'
          ')'
        );
      }
    );
  }


  // CRUD
  newScanRaw(Scan scan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT Into Scans (id, type, value) "
      "VALUES (${scan.id},'${scan.type}','${scan.value}')"
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
    List<Scan> list = res.isNotEmpty
                      ? res.map((scan) => Scan.fromJson(scan)).toList()
                      : [];
    return list;
  }

  Future<List<Scan>> getScansByType(String type) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE type='$type'");
    List<Scan> list = res.isNotEmpty
                          ? res.map( (c) => Scan.fromJson(c) ).toList()
                          : [];
    return list;
  }

  Future<int> updateScan(Scan scan) async {
    final db = await database;
    final res = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> delteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }





}