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
            final SearchResult resultado = await showSearch(
              context: context,
              delegate: SearchDestination(
                  BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion),
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

  void returnSearch(BuildContext context, SearchResult result) {
    if (result.canceloSearch) return;
    if (result.manualSearch) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }
}
