import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool canceloSearch;
  final bool manualSearch;
  final LatLng position;
  final String nombreDestino;
  final String descripcion;

  SearchResult({
    @required this.canceloSearch,
    this.manualSearch,
    this.position,
    this.nombreDestino,
    this.descripcion,
  });
}
