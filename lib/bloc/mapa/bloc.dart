import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutasmap_app/themes/uberMap.dart';

part 'event.dart';
part 'state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _mapController;

  void initMapa(GoogleMapController controller) {
    // Medida de seguridad por si el mapa no esta creado
    if (!state.mapaListo) {
      this._mapController = controller;
      // Se podría cambiar el estilo con gente que lo hace por internete:
      // https://snazzymaps.com/style/90982/uber-2017
      // https://mapstyle.withgoogle.com/
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    print('StateBloc: $state');
    if (event is OnMapaListo) {
      // Crear por primera vez el mapa
      print('Mapa Listo');
      yield state.copyWith(mapaListo: true);
    }
  }
}
