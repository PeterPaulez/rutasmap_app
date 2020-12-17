import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutasmap_app/helpers/deBouncer.dart';
import 'package:rutasmap_app/models/drivingResponse.dart';
import 'package:rutasmap_app/models/revereseQueryResponse.dart';
import 'package:rutasmap_app/models/searchResponse.dart';

class TrafficService {
  // Creaamos un SingleTon
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500));
  final StreamController<SearchResponse> _sugerenciasStreamController =
      new StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream =>
      this._sugerenciasStreamController.stream;

  final String baseUrl = 'https://api.mapbox.com';
  final String apiKey =
      'pk.eyJ1IjoicGVkcm9wYWJsb2FwYXJpY2lvIiwiYSI6ImNraWxrOWEwZTA1d3AydnFzaG5ycWo4NnQifQ.VWD1TT1VCiBx_AYR6Q0nYw';

  Future<DrivingResponse> getCoordenadasIniFin(
      LatLng inicio, LatLng destino) async {
    final coordenadasString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url =
        '${this.baseUrl}/directions/v5/mapbox/driving/$coordenadasString';
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

  Future<SearchResponse> getResultadosBusqueda(
      String busqueda, LatLng proximidad) async {
    if (busqueda == '') return SearchResponse(features: []);
    final url = '${this.baseUrl}/geocoding/v5/mapbox.places/$busqueda.json';
    print(url);

    try {
      final answer = await this._dio.get(
        url,
        queryParameters: {
          'autocomplete': 'true',
          'proximity': '${proximidad.longitude},${proximidad.latitude}',
          'access_token': this.apiKey,
          'language': 'es',
        },
      );

      // No es un json, es un string por eso es importante el MODELO
      final data = answer.data;
      final searchResponse = searchResponseFromJson(data);

      return searchResponse;
    } catch (e) {
      // Devolvemos una respuesta válida pero vacia
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultadosBusqueda(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ReverseQueryResponse> getCoordenadasInfo(LatLng destinoCoords) async {
    final url =
        '${this.baseUrl}/geocoding/v5/mapbox.places/${destinoCoords.longitude},${destinoCoords.latitude}.json';
    print(url);

    try {
      final answer = await this._dio.get(
        url,
        queryParameters: {
          'access_token': this.apiKey,
          'language': 'es',
        },
      );

      // No es un json, es un string por eso es importante el MODELO
      final data = answer.data;
      final reverseResponse = reverseQueryResponseFromJson(data);

      return reverseResponse;
    } catch (e) {
      // Devolvemos una respuesta válida pero vacia
      return ReverseQueryResponse(features: []);
    }
  }

  void dispose() {
    _sugerenciasStreamController?.close();
  }
}
