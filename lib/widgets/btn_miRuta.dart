part of 'all.dart';

class BtnMiRuta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            BlocProvider.of<MapaBloc>(context).add(OnMarcarRecorrido());
          },
          icon: Icon(Icons.more_horiz, color: Colors.black87),
        ),
      ),
    );
  }
}
