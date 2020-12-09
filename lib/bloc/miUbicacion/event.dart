part of 'bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

// NORMALMENTE a los events se les empieza con un ON
class OnUbicacionCambio extends MiUbicacionEvent {
  final LatLng ubicacion;
  OnUbicacionCambio(this.ubicacion);

  @override
  String toString() {
    return 'Instance of POSITION: ${this.ubicacion.longitude} // ${this.ubicacion.latitude} ';
  }
}
