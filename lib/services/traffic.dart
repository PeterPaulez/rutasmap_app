import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutasmap_app/models/drivingResponse.dart';

class TrafficService {
  // Creaamos un SingleTon
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final String baseUrl = 'https://api.mapbox.com/directions/v5';
  final String apiKey =
      'pk.eyJ1IjoicGVkcm9wYWJsb2FwYXJpY2lvIiwiYSI6ImNraWxrOWEwZTA1d3AydnFzaG5ycWo4NnQifQ.VWD1TT1VCiBx_AYR6Q0nYw';

  Future<DrivingResponse> getCoordenadasIniFin(
      LatLng inicio, LatLng destino) async {
    print('INI: $inicio');
    print('DEST: $destino');

    final coordenadasString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this.baseUrl}/mapbox/driving/$coordenadasString';
    final answer = await this._dio.get(
      url,
      queryParameters: {
        'alternatives': 'true',
        'geometries': 'polyline6',
        'steps': 'false',
        'access_token': this.apiKey,
        'language': 'es',
      },
    );

    final data = DrivingResponse.fromJson(answer.data);
    return data;
  }
}
