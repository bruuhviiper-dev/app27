import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Baixa miniaturas do Picsum de uma lista de ids CANDIDATOS e monta um mosaico
/// rotulado (id embaixo de cada foto) para curadoria manual — só entram no app
/// os ids conferidos (paisagem/lifestyle apropriado, licença Unsplash).
///   dart run tool/curate_photos.dart
const _candidatos = [
  '1000','1001','1005','1006','1009','1010','1011','1012','1017','1022',
  '1026','1028','1030','1032','1034','1040','1046','1067','1068','1078',
  '1079','64','110','164','177','183','197','219','225','326',
  '334','431','447','494','646','669','823','884','977','1027',
];

Future<Uint8List?> _fetch(String url) async {
  final client = HttpClient();
  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode != 200) return null;
    final b = BytesBuilder();
    await for (final chunk in resp) {
      b.add(chunk);
    }
    return b.toBytes();
  } catch (_) {
    return null;
  } finally {
    client.close();
  }
}

Future<void> main() async {
  const cols = 8, cw = 165, ch = 255, tw = 155, th = 220;
  final rows = (_candidatos.length / cols).ceil();
  final canvas = img.Image(width: cols * cw, height: rows * ch);
  img.fill(canvas, color: img.ColorRgb8(18, 18, 24));
  for (var i = 0; i < _candidatos.length; i++) {
    final id = _candidatos[i];
    final bytes = await _fetch('https://picsum.photos/id/$id/$tw/$th');
    final col = i % cols, row = i ~/ cols;
    final x = col * cw + 5, y = row * ch + 5;
    if (bytes != null) {
      final im = img.decodeImage(bytes);
      if (im != null) {
        final rz = img.copyResize(im, width: tw, height: th);
        img.compositeImage(canvas, rz, dstX: x, dstY: y);
      }
    } else {
      stdout.writeln('falhou id $id');
    }
    img.drawString(canvas, 'id $id',
        font: img.arial24, x: x + 2, y: y + th + 4, color: img.ColorRgb8(255, 255, 120));
  }
  final out = File('tool/_montage.png');
  out.writeAsBytesSync(img.encodePng(canvas));
  stdout.writeln('mosaico: ${out.path}');
}
