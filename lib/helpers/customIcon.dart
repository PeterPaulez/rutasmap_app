part of 'helpers.dart';

Future<BitmapDescriptor> getAssetIconMarker() async {
  return await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(15, 15)),
    'assets/custom-pin.png',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final answer = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(responseType: ResponseType.bytes),
  );

  // Si queremos hacer la imagen que venga de una URL más pequeña, hay que liar una buena
  final bool imageDecrease = true;
  if (imageDecrease) {
    final bytes = answer.data;
    final imageCodec = await ui.instantiateImageCodec(bytes,
        targetHeight: 150, targetWidth: 150);
    final frame = await imageCodec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  } else {
    return BitmapDescriptor.fromBytes(answer.data);
  }
}

Future<BitmapDescriptor> getIniIconFromWidget(int segundos) async {
  // Empezamos a grabar lo que ocurre en el canvas
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);
  final minutos = (segundos / 60).floor();
  final markerIni = new MarkerIniPainter(minutos);
  markerIni.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}

Future<BitmapDescriptor> getFinIconFromWidget(
    double metros, String descripcion) async {
  // Empezamos a grabar lo que ocurre en el canvas
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);
  final markerIni = new MarkerFinPainter(descripcion, metros);
  markerIni.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}
