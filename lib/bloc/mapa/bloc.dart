import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _mapController;

  void initMapa(GoogleMapController controller) {
    // Medida de seguridad por si el mapa no esta creado
    if (!state.mapaListo) {
      this._mapController = controller;

      // TODO: cambiar estilo mapa

      add(OnMapaListo());
    }
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
