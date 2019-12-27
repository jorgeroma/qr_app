import 'package:flutter/material.dart';
import 'dart:io';

import 'package:qr_app/src/models/scan_model.dart';
import 'package:qr_app/src/bloc/scans_bloc.dart';
import 'package:qr_app/src/utils/utils.dart' as utils;

import 'direcciones_page.dart';
import 'package:qr_app/src/pages/mapa_page.dart';

import 'package:barcode_scan/barcode_scan.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              // scansBloc.borrarScanTODOS();
              if(currentIndex==0){
                scansBloc.borrarScanTODOStipo('geo');
              }else{
                scansBloc.borrarScanTODOStipo('http');
              }
            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: ()=>_scannQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scannQR(BuildContext context) async {

    // http://twitter.com/jorge_ro_ma
    // geo:36.777144753627375,-4.0955454822089905

    String futureString;
    
    try{
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString = e.toString();
    }

    print('Future String: $futureString');

    if(futureString != null){
      print('Tenemos informacion');

      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750));
        utils.abrirScan(scan, context);
      }else{
        utils.abrirScan(scan, context);
      }

    }

  }

  Widget _callPage(int pagActual){
    switch(pagActual){
      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default: return MapasPage();
    }
  }

  Widget _crearNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        ),
      ],
    );
  }
}