part of 'all.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ponemos un blocbuilder porque etamos leyendo la propiedad de seguirUbicacion
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 1),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<MapaBloc>(context).add(OnSeguirUbicacion());
              },
              icon: (state.seguirUbicacion)
                  ? Icon(Icons.directions_run, color: Colors.black87)
                  : Icon(Icons.accessibility_new, color: Colors.black87),
            ),
          ),
        );
      },
    );
  }
}
