import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

  StreamSubscription<Position> _positionSubscription;

  void iniciarSeguimiento() {
    print('Ubication');
    this._positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      print('Position: $position');
      final positionLatLng = new LatLng(position.latitude, position.longitude);
      print('LatLng: $positionLatLng');
      add(OnUbicacionCambio(positionLatLng));
    });
  }

  void cancelarSeguimiento() {
    this._positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {
    print('Event: $event');
    print('state: ${state.ubicacion}');
    if (event is OnUbicacionCambio) {
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion,
      );
    }
    print('state: ${state.ubicacion}');
  }
}
