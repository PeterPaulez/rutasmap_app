import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutasmap_app/bloc/mapa/bloc.dart';
import 'package:rutasmap_app/bloc/miUbicacion/bloc.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (_, state) => crearMapa(state),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return Center(child: Text('Ubicando ...'));
    } else {
      final CameraPosition camaraPosition = CameraPosition(
        target: state.ubicacion,
        zoom: 16,
      );
      return GoogleMap(
        initialCameraPosition: camaraPosition,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        // Es la misma forma, porque coincide el primer parámetro
        onMapCreated: BlocProvider.of<MapaBloc>(context).initMapa,
        /*
        onMapCreated: (GoogleMapController controller) {
          BlocProvider.of<MapaBloc>(context).initMapa(controller);
        },
        */
      );
    }
  }
}
