part of 'helpers.dart';

void calculandoAlerta(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Espere por favor'),
        content: Text('Calculando la ruta'),
      ),
    );
  } else {
    showCupertinoDialog(
      builder: (context) => CupertinoAlertDialog(
        title: Text('Espere por favor'),
        content: Text('Calculando la ruta'),
      ),
      context: context,
    );
  }
}
