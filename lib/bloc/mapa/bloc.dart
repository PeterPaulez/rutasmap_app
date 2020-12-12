import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutasmap_app/themes/uberMap.dart';

part 'event.dart';
part 'state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  // Controller del MAPA
  GoogleMapController _mapController;

  // PolyLines
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId('mi_ruta'),
    color: Colors.transparent, // inicializado en transparent y false
    width: 4,
  );

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
    if (event is OnMapaListo) {
      // Crear por primera vez el mapa
      print('Mapa Listo');
      yield state.copyWith(mapaListo: true);
    } else if (event is OnUbicacionCambiando) {
      // Solo el stream de la emision, no todo el stream completo (yield)
      yield* this._onUbicacionCambiando(event);
    } else if (event is OnMarcarRecorrido) {
      // Solo el stream de la emision, no todo el stream completo (yield)
      yield* this._onMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      // Si queremos hacerlo automático para no esperar a que se mueva la persona
      yield* this._onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      // Cambiamos la ubicación central del mapa
      //print('Mapa se mueve: ${event.centroMapa}');
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    }
  }

  // Atención con el type del EVENT
  Stream<MapaState> _onUbicacionCambiando(OnUbicacionCambiando event) async* {
    print('Nueva Ubicación para MAPA_ BLOC ${event.ubicacion}');

    // Se va pintando la ruta y se va reenfocando la camara.
    if (state.seguirUbicacion) {
      this.moverCamara(event.ubicacion);
    }

    List<LatLng> points = [...this._miRuta.points, event.ubicacion];
    // copyWith de GoogleMaps
    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;
    yield state.copyWith(polylines: currentPolylines);
  }

  // Atención con el type del EVENT
  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    if (state.dibujarRecorrido) {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
    } else {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;
    yield state.copyWith(
      dibujarRecorrido: !state.dibujarRecorrido,
      polylines: currentPolylines,
    );
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    if (!state.seguirUbicacion) {
      // Le movemos a la ultima ubicación de nuestro polyline
      this.moverCamara(this._miRuta.points[this._miRuta.points.length - 1]);
    }

    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }
}
