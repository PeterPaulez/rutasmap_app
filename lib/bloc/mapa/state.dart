part of 'bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final Map<String, Polyline> polylines;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = false,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  /* PolyLines EJEMPLO
  final Map<String, Polyline> polylines={
    'mi_ruta': {
      id: 'mi_ruta', points: [[lat,long],[lat,long],[lat,long]], color: black, width: 3
    },
    'mi_ruta_casa': {
      id: 'mi_ruta_casa', points: [[lat,long],[lat,long],[lat,long]], color: black, width: 3
    }
  };*/

  MapaState copyWith(
          {bool mapaListo,
          bool dibujarRecorrido,
          Map<String, Polyline> polylines}) =>
      MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
          polylines: polylines ?? this.polylines);
}
