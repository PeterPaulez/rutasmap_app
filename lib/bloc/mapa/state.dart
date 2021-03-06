part of 'bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    this.seguirUbicacion = false,
    this.ubicacionCentral,
    Map<String, Polyline> polylines,
    Map<String, Marker> markers,
  })  : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map();

  /* PolyLines EJEMPLO
  final Map<String, Polyline> polylines={
    'mi_ruta': {
      id: 'mi_ruta', points: [[lat,long],[lat,long],[lat,long]], color: black, width: 3
    },
    'mi_ruta_casa': {
      id: 'mi_ruta_casa', points: [[lat,long],[lat,long],[lat,long]], color: black, width: 3
    }
  };*/

  MapaState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    LatLng ubicacionCentral,
    Map<String, Polyline> polylines,
    Map<String, Marker> markers,
  }) =>
      MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
          seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
          ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
          polylines: polylines ?? this.polylines,
          markers: markers ?? this.markers);
}
