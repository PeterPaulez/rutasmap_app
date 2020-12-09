import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
  bool popupPermission = false;

  // Sobreescritura de funciones para detectar cuando la app esta en 2º plano
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('===> $state');
    if (state == AppLifecycleState.resumed && !popupPermission) {
      // Permission es un FUTURE y necesita await, devuelve un bool
      final bool locationGranted = await Permission.location.isGranted;
      print('Tenemos location: $locationGranted');
      if (locationGranted) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar esta APP'),
            MaterialButton(
              child: Text(
                'Solicitar Acceso',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                popupPermission = true;
                final status = await Permission.location.request();
                print(status);
                await this.accesoGps(status);
                popupPermission = false;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future accesoGps(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.undetermined:
        // Debería tener siempre status, puede ser que le salga el permiso y cierre la app
        break;
      case PermissionStatus.granted:
        // Si es un statefull hay acceso dentro del state al context sin necesidad alguna
        Navigator.pushReplacementNamed(context, 'loading');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
