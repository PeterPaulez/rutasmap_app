import 'package:flutter/material.dart';
import 'package:rutasmap_app/pages/accesoGps.dart';
import 'package:rutasmap_app/pages/loading.dart';
import 'package:rutasmap_app/pages/mapa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoadingPage(),
      //home: AccesoGpsPage(),
      routes: {
        'mapa': (_) => MapaPage(),
        'loading': (_) => LoadingPage(),
        'accesoGps': (_) => AccesoGpsPage(),
      },
    );
  }
}
