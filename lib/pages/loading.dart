import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutasmap_app/helpers/helpers.dart';
import 'package:rutasmap_app/pages/accesoGps.dart';
import 'package:rutasmap_app/pages/mapa.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final bool gpsActivo = await Geolocator.isLocationServiceEnabled();
      if (gpsActivo) {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else {
            return Center(child: CircularProgressIndicator(strokeWidth: 0.5));
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    // Permiso GPS
    final permisoGranted = await Permission.location.isGranted;
    print('Permiso GPS: $permisoGranted');
    // GPS activo
    final gpsActivo = await Geolocator.isLocationServiceEnabled();
    print('GPS activo: $gpsActivo');

    await Future.delayed(Duration(milliseconds: 500));

    if (permisoGranted && gpsActivo) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if (!permisoGranted) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es necesario conceder permos de GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
