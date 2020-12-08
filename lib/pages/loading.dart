import 'package:flutter/material.dart';
import 'package:rutasmap_app/helpers/helpers.dart';
import 'package:rutasmap_app/pages/accesoGps.dart';
import 'package:rutasmap_app/pages/mapa.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(strokeWidth: 0.5),
          );
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    // TODO: Permiso GPS
    // TODO: GPS esta actio

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.pushReplacement(
        context, navegarMapaFadeIn(context, AccesoGpsPage()));
    //Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
  }
}
