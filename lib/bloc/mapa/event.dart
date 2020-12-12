part of 'bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnMarcarRecorrido extends MapaEvent {}

class OnSeguirUbicacion extends MapaEvent {}

class OnUbicacionCambiando extends MapaEvent {
  final LatLng ubicacion;
  OnUbicacionCambiando(this.ubicacion);
}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;
  OnMovioMapa(this.centroMapa);
}
