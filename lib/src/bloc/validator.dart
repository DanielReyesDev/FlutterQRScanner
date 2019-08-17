
import 'dart:async';

import 'package:flutter_qr_scanner/src/models/scan.dart';

class Validators {
  final validateGeo = StreamTransformer<List<Scan>, List<Scan>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where( (s) => s.type == 'geo' ).toList();
      sink.add(geoScans);
    }
  );

  final validateHttp = StreamTransformer<List<Scan>, List<Scan>>.fromHandlers(
    handleData: (scans, sink) {
      final httpScans = scans.where( (s) => s.type == 'http' ).toList();
      sink.add(httpScans);
    }
  );
}