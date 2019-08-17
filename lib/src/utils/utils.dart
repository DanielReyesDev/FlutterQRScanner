import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/models/scan.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, Scan scan) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  } 
}