part of 'all.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Botón icono regresar
        Positioned(
          top: 70,
          left: 20,
          child: CircleAvatar(
            maxRadius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                print('Echo back');
              },
            ),
          ),
        ),

        // Icono ubicación para arrastrar
        Center(
          child: Transform.translate(
            offset: Offset(0, -14),
            child: Icon(Icons.location_on, size: 50),
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
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
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
