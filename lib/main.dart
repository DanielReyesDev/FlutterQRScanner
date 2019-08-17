import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/pages/home_page.dart';
import 'package:flutter_qr_scanner/src/pages/map_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Scanner',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'map' : (BuildContext context) => MapPage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}