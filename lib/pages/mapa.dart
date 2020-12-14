import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutasmap_app/bloc/mapa/bloc.dart';
import 'package:rutasmap_app/bloc/miUbicacion/bloc.dart';
import 'package:rutasmap_app/widgets/all.dart';

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
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, state) => crearMapa(state),
          ),
          Positioned(
            top: 10,
            child: SearchBar(),
          ),
          MarcadorManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return Center(child: Text('Ubicando ...'));
    } else {
      // Mandamos la ubicación cuando va cambiando el mapa
      BlocProvider.of<MapaBloc>(context)
          .add(OnUbicacionCambiando(state.ubicacion));

      final CameraPosition camaraPosition = CameraPosition(
        target: state.ubicacion,
        zoom: 16,
      );

      return BlocBuilder<MapaBloc, MapaState>(
        builder: (context, state) {
          return GoogleMap(
            initialCameraPosition: camaraPosition,
            //mapType: MapType.hybrid,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            // Se necesitan AL MENOS dos puntos para hacer una polyline en el mapa
            polylines: BlocProvider.of<MapaBloc>(context)
                .state
                .polylines
                .values
                .toSet(),
            // Cada vez que se mueve la camara, podemos lanzar un evento
            onCameraMove: (position) {
              BlocProvider.of<MapaBloc>(context)
                  .add(OnMovioMapa(position.target));
            },
            onCameraIdle: () {
              // Se podría poner en ONCAMERAMOVE solo una propiedad y el ADD en el iggle ...
              // de esta forma no logeariamos tanto ni emitiriamos tanto con yield solo ...
              // se emitiría al dejar de mover la camara
              print('La camara se queda quieta');
            },
            // Es la misma forma, porque coincide el primer parámetro
            onMapCreated: BlocProvider.of<MapaBloc>(context).initMapa,
            /*
        onMapCreated: (GoogleMapController controller) {
          BlocProvider.of<MapaBloc>(context).initMapa(controller);
        },
        */
          );
        },
      );
    }
  }
}
