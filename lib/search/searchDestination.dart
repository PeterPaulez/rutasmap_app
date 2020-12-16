import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:rutasmap_app/models/searchResponse.dart';
import 'package:rutasmap_app/models/searchResult.dart';
import 'package:rutasmap_app/services/traffic.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  // Estas 3 líneas de código lo hacemos porque el field es FINAL, así podemos cambiarlo
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;
  final List<SearchResult> historial;

  SearchDestination(this.proximidad, this.historial)
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
    // Implement buildResults
    return _costruirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
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
          ),
          ...this
              .historial
              .map(
                (result) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text(result.nombreDestino),
                  subtitle: Text(result.nombreDestino),
                  onTap: () {
                    this.close(context, result);
                  },
                ),
              )
              .toList(),
        ],
      );
    }
    return _costruirResultadosSugerencias();
  }

  Widget _costruirResultadosSugerencias() {
    if (this.query == '') {
      return Container();
    }
    this
        ._trafficService
        .getSugerenciasPorQuery(this.query.trim(), this.proximidad);

    return StreamBuilder(
      /*
      future: this
          ._trafficService
          .getResultadosBusqueda(this.query.trim(), this.proximidad),
        
      */
      stream: this._trafficService.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final lugares = snapshot.data.features;
        if (lugares.length == 0) {
          return ListTile(title: Text('No hay resultados con ${this.query}'));
        }
        return ListView.separated(
          itemCount: lugares.length,
          separatorBuilder: (_, int index) => Divider(),
          itemBuilder: (_, int index) {
            final lugar = lugares[index];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs),
              subtitle: Text(lugar.placeNameEs),
              onTap: () {
                this.close(
                  context,
                  SearchResult(
                    canceloSearch: false,
                    manualSearch: false,
                    position: LatLng(lugar.center[1], lugar.center[0]),
                    nombreDestino: lugar.textEs,
                    descripcion: lugar.placeNameEs,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
