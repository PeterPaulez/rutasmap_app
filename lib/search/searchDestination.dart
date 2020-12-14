import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:rutasmap_app/models/searchResult.dart';
import 'package:rutasmap_app/services/traffic.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  // Estas 3 líneas de código lo hacemos porque el field es FINAL, así podemos cambiarlo
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;

  SearchDestination(this.proximidad)
      : this.searchFieldLabel = 'Buscar ...',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      // Este null esta ok porque es una acción para irse del search
      onPressed: () => this.close(context, SearchResult(canceloSearch: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    this
        ._trafficService
        .getResultadosBusqueda(this.query.trim(), this.proximidad);
    // Implement buildResults
    return Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement buildSuggestions
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Colocar ubicación manualmente'),
          onTap: () {
            // Retornar algo en el null
            this.close(
              context,
              SearchResult(
                canceloSearch: false,
                manualSearch: true,
              ),
            );
          },
        )
      ],
    );
  }
}
