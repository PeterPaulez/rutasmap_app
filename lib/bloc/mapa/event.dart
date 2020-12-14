part of 'bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnMarcarRecorrido extends MapaEvent {}

class OnSeguirUbicacion extends MapaEvent {}

class OnCrearRutaIniFin extends MapaEvent {
  final List<LatLng> rutaPolyline;
  final double distance;
  final double duration;

  OnCrearRutaIniFin(this.rutaPolyline, this.distance, this.duration);
}

class OnUbicacionCambiando extends MapaEvent {
  final LatLng ubicacion;
  OnUbicacionCambiando(this.ubicacion);
}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;
  OnMovioMapa(this.centroMapa);
}
