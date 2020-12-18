import 'package:flutter/material.dart';

/*
Con el custom painter podemos dibujar lo que queramos.
Todo funcina como capas unas encima de otras en el canvas:
Lo primero estará en el fondo y lo último estara arriba del todo.
*/
class MarkerIniPainter extends CustomPainter {
  final int minutos;
  MarkerIniPainter(this.minutos);

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
  bool shouldRepaint(MarkerIniPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerIniPainter oldDelegate) => false;
}

class MarkerFinPainter extends CustomPainter {
  final String descripcion;
  final double metros;

  MarkerFinPainter(this.descripcion, this.metros);

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
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(
      path,
      Colors.black87,
      10,
      false,
    );

    // Caja Blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Caja Negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    // Dibujar Distancia
    TextPainter textPainter;
    double kilometros = this.metros / 1000;
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;
    textPainter = _drawTest('$kilometros', 22, maxWidth: 80);
    textPainter.paint(canvas, Offset(1, 37));
    textPainter = _drawTest('Km', 20, maxWidth: 80);
    textPainter.paint(canvas, Offset(1, 65));

    // Dibujar Descripción
    textPainter = _drawTest(
      this.descripcion,
      20,
      color: Colors.black,
      minWidth: 0,
      maxWidth: size.width - 100,
      textAlign: TextAlign.left,
    );
    textPainter.paint(canvas, Offset(85, 35));
  }

  @override
  bool shouldRepaint(MarkerFinPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerFinPainter oldDelegate) => false;
}

TextPainter _drawTest(
  String text,
  double size, {
  Color color = Colors.white,
  double maxWidth = 70,
  double minWidth = 70,
  TextAlign textAlign = TextAlign.center,
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
    textAlign: textAlign,
    maxLines: 2,
    ellipsis: '...',
  );
  textPainter.layout(
    maxWidth: maxWidth,
    minWidth: minWidth,
  );

  return textPainter;
}
