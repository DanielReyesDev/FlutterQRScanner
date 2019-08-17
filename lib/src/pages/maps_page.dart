import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/bloc/scans_bloc.dart';
import 'package:flutter_qr_scanner/src/models/scan.dart';


class MapsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Scan>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text("No info"),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container( color: Colors.red,),
            onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text(scans[i].value),
              subtitle: Text('ID: ${ scans[i].id }'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            )
          )
        );
      },
    );
  }
}