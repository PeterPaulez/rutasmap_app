import 'package:flutter/material.dart';

/*
Con el custom painter podermo dibujar lo que queramos.
Todo funcina como capa encima de otra en el canvas:
Lo primero estará en el fondo y lo último estara arriba del todo.
*/
class MarkerInicioPainter extends CustomPainter {
  final int minutos;
  MarkerInicioPainter(this.minutos);

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

    // Sombra
    final Path path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(
      path,
      Colors.black87,
      10,
      false,
    );

    // Caja Blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Caja Negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    // Dibujar Tiempo
    TextPainter textPainter;
    textPainter = _drawTest('$minutos', 30);
    textPainter.paint(canvas, Offset(40, 35));
    textPainter = _drawTest('Min', 20);
    textPainter.paint(canvas, Offset(40, 65));

    // Dibujar Ubicación
    textPainter = _drawTest(
      'Mi Ubicación',
      22,
      color: Colors.black,
      minWidth: 0,
      maxWidth: size.width - 130,
    );
    textPainter.paint(canvas, Offset(130, 50));
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;

  TextPainter _drawTest(
    String text,
    double size, {
    Color color = Colors.white,
    double maxWidth = 70,
    double minWidth = 70,
  }) {
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
      text: text,
    );
    final textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      maxWidth: maxWidth,
      minWidth: minWidth,
    );

    return textPainter;
  }
}
