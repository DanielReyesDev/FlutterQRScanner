import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/pages/addresses_page.dart';
import 'package:flutter_qr_scanner/src/pages/maps_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){},
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
    // https://www.google.com/
    // geo:40.63049872475465,-74.26961317500002

    String futureString = "";
    try {
      futureString = await new QRCodeReader().scan();
    } catch(e) {
      futureString = e.toString();
    }

    print(futureString);


    
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