part of 'all.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Botón icono regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context)
                      .add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),

        // Icono ubicación para arrastrar
        Center(
          child: Transform.translate(
            offset: Offset(0, -14),
            child: BounceInDown(
              from: 200,
              child: Icon(Icons.location_on, size: 50),
            ),
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: Text(
                'Confirmar destino',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () => this.calcularDestino(context),
            ),
          ),
        )
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlerta(context);

    final trafficService = new TrafficService();
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = BlocProvider.of<MapaBloc>(context).state.ubicacionCentral;

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

    BlocProvider.of<MapaBloc>(context).add(
        OnCrearRutaIniFin(rutaPolyline, distance, duration, nombreDestino));

    Navigator.of(context).pop();
    BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
  }
}
