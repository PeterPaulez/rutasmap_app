import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Lapicero Negro
    Paint paint = new Paint()..color = Colors.black;
    // Tambien => paint.color = Colors.black;

    // Dibujar circulo negro
    final double circuloNegroRadio = 20;
    canvas.drawCircle(
      Offset(circuloNegroRadio, size.height - circuloNegroRadio),
      circuloNegroRadio,
      paint,
    );

    // Dibujar Circulo Blanco
    final double circuloBlancoRadio = 7;
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(circuloNegroRadio, size.height - circuloNegroRadio),
      circuloBlancoRadio,
      paint,
    );
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}
