import 'package:flutter/material.dart';
import 'package:rutasmap_app/models/searchResult.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  // Estas 3 líneas de código lo hacemos porque el field es FINAL, así podemos cambiarlo
  @override
  final String searchFieldLabel;
  SearchDestination() : this.searchFieldLabel = 'Buscar ...';

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
