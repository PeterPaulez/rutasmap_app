part of 'bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnUbicacionCambiando extends MapaEvent {
  final LatLng ubicacion;
  OnUbicacionCambiando(this.ubicacion);
}
