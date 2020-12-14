import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  // Creaamos un SingleTon
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  Future getCoordenadasIniFin(LatLng inicio, LatLng destino) async {
    print('INI: $inicio');
    print('DEST: $destino');
  }
}
