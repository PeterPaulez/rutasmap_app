part of 'all.dart';

class BtnUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            BlocProvider.of<MapaBloc>(context).moverCamara(
                BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion);
          },
          icon: Icon(Icons.my_location, color: Colors.black87),
        ),
      ),
    );
  }
}
