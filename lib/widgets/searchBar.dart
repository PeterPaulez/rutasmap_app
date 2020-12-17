part of 'all.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (!state.seleccionManual) {
          return FadeInDown(
            duration: Duration(microseconds: 300),
            child: buildSearchBar(context),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        width: width,
        //color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () async {
            final historial =
                BlocProvider.of<BusquedaBloc>(context).state.historial;
            final SearchResult resultado = await showSearch(
              context: context,
              delegate: SearchDestination(
                  BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion,
                  historial),
            );
            returnSearch(context, resultado);
            print(resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              '¿Dónde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void returnSearch(BuildContext context, SearchResult result) async {
    if (result.canceloSearch) return;
    if (result.manualSearch) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }

    // Es un click en uno de los lugares que salen en la busqueda:
    calculandoAlerta(context);
    final trafficService = new TrafficService();
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = result.position;

    // Obtener info del destino
    final reverseQueryResponse =
        await trafficService.getCoordenadasInfo(destino);
    final nombreDestino = reverseQueryResponse.features[0].placeName;

    final trafficResponse =
        await trafficService.getCoordenadasIniFin(inicio, destino);
    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;
    // Decodificar los puntos del geometry llamados polyline6
    final points = PolyCrypt.Polyline.Decode(
      encodedString: geometry,
      precision: 6,
    );

    // Los puntos estan como un double double, pero debería ser un listado de Polylines
    final pointsDedoded = points.decodedCoords;
    final List<LatLng> rutaPolyline =
        pointsDedoded.map((point) => LatLng(point[0], point[1])).toList();

    // Cerramos la alerta y mandamos evento al BLOC para dibujar la ruta
    Navigator.of(context).pop();
    BlocProvider.of<MapaBloc>(context).add(
        OnCrearRutaIniFin(rutaPolyline, distance, duration, nombreDestino));

    // Agregar el result al Historial
    BlocProvider.of<BusquedaBloc>(context).add(OnAgregarHistorial(result));
  }
}
