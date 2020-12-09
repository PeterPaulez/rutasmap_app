import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutasmap_app/bloc/mapa/bloc.dart';
import 'package:rutasmap_app/bloc/miUbicacion/bloc.dart';
import 'package:rutasmap_app/pages/accesoGps.dart';
import 'package:rutasmap_app/pages/loading.dart';
import 'package:rutasmap_app/pages/mapa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingPage(),
        //home: AccesoGpsPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'accesoGps': (_) => AccesoGpsPage(),
        },
      ),
    );
  }
}
