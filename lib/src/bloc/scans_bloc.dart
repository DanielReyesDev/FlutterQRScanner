import 'dart:async';

import 'package:flutter_qr_scanner/src/models/scan.dart';
import 'package:flutter_qr_scanner/src/providers/db_provider.dart';


class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    getScans();
  }

  final _scansController = StreamController<List<Scan>>.broadcast();

  Stream<List<Scan>> get scansStream => _scansController.stream;


  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getScans());
  }

  addScan(Scan scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAll() async {
    await DBProvider.db.delteAll();
    getScans();
  }
}

final scanBloc = new ScansBloc();