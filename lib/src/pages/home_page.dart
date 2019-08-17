import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/bloc/scans_bloc.dart';
import 'package:flutter_qr_scanner/src/models/scan.dart';
import 'package:flutter_qr_scanner/src/pages/addresses_page.dart';
import 'package:flutter_qr_scanner/src/pages/maps_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scan"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => scansBloc.deleteAll(),
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async {
    // 
    // geo:40.63049872475465,-74.26961317500002

    String futureString = "https://www.google.com/";

    // String futureString = "";
    // try {
    //   futureString = await new QRCodeReader().scan();
    // } catch(e) {
    //   futureString = e.toString();
    // }

    // print(futureString);


    if (futureString != null)  {
      print("We got information");
      final scan = Scan(value: futureString);
      scansBloc.addScan(scan);
    }


    
  }  

  Widget _callPage(int page) {
    switch(page){
      case 0: return MapsPage();
      case 1: return AddressesPage();
      default: MapsPage();
    }
  }

  Widget _createBottomNavigatorBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){setState(() {
        currentIndex = index;
      });},
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Maps")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text("Addresses")
        )
      ],
    );
  }
}