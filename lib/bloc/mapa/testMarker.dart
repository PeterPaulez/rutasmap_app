import 'package:flutter/material.dart';
import 'package:rutasmap_app/widgets/markerIniFin.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerFinPainter(
              'Mi casa esta por aquí y es una dirección muy larga, pero que muy muy larga',
              250003,
            ),
          ),
        ),
      ),
    );
  }
}
