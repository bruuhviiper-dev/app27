import 'dart:io';
import 'package:image/image.dart' as img;

/// Gera o ícone do app "Frases para Fotos": gradiente roxo→rosa + câmera branca
/// com um balão de fala (legenda) na lente. Saídas em assets/icon/.
///   dart run tool/gen_icon.dart
const int S = 1024;

img.ColorRgba8 _lerp(List<int> a, List<int> b, double t) => img.ColorRgba8(
      (a[0] + (b[0] - a[0]) * t).round(),
      (a[1] + (b[1] - a[1]) * t).round(),
      (a[2] + (b[2] - a[2]) * t).round(),
      255,
    );

void _gradientDiagonal(img.Image im, List<int> c1, List<int> c2) {
  final maxd = (im.width + im.height - 2).toDouble();
  for (var y = 0; y < im.height; y++) {
    for (var x = 0; x < im.width; x++) {
      final t = (x + y) / maxd;
      im.setPixel(x, y, _lerp(c1, c2, t));
    }
  }
}

void _roundedRect(img.Image im, num x1, num y1, num x2, num y2, num r,
    img.Color color) {
  img.fillRect(im,
      x1: (x1 + r).round(), y1: y1.round(), x2: (x2 - r).round(), y2: y2.round(), color: color);
  img.fillRect(im,
      x1: x1.round(), y1: (y1 + r).round(), x2: x2.round(), y2: (y2 - r).round(), color: color);
  img.fillCircle(im, x: (x1 + r).round(), y: (y1 + r).round(), radius: r.round(), color: color);
  img.fillCircle(im, x: (x2 - r).round(), y: (y1 + r).round(), radius: r.round(), color: color);
  img.fillCircle(im, x: (x1 + r).round(), y: (y2 - r).round(), radius: r.round(), color: color);
  img.fillCircle(im, x: (x2 - r).round(), y: (y2 - r).round(), radius: r.round(), color: color);
}

/// Desenha a câmera centrada em (cx,cy). scale=1.0 => ~520px de largura.
void _drawCamera(img.Image im, double cx, double cy, double scale) {
  final white = img.ColorRgba8(255, 255, 255, 255);
  final ring = img.ColorRgba8(43, 33, 64, 255); // roxo escuro
  final flash = img.ColorRgba8(255, 209, 91, 255); // amarelo

  final bw = 520 * scale; // largura do corpo
  final bh = 320 * scale; // altura do corpo
  final x1 = cx - bw / 2, x2 = cx + bw / 2;
  final y1 = cy - bh / 2 + 20 * scale, y2 = cy + bh / 2 + 20 * scale;

  // saliência do visor (topo)
  _roundedRect(im, cx - 90 * scale, y1 - 55 * scale, cx - 10 * scale + 90 * scale,
      y1 + 30 * scale, 24 * scale, white);
  // corpo
  _roundedRect(im, x1, y1, x2, y2, 60 * scale, white);
  // flash
  img.fillCircle(im,
      x: (x2 - 60 * scale).round(),
      y: (y1 + 55 * scale).round(),
      radius: (20 * scale).round(),
      color: flash);
  // lente: anel escuro + balão de fala (legenda)
  final lensR = 118 * scale;
  img.fillCircle(im, x: cx.round(), y: (cy + 35 * scale).round(), radius: lensR.round(), color: ring);
  // balão de fala branco dentro da lente
  final by = cy + 20 * scale;
  _roundedRect(im, cx - 72 * scale, by - 46 * scale, cx + 72 * scale, by + 40 * scale,
      30 * scale, white);
  // rabinho do balão
  img.fillPolygon(im, vertices: [
    img.Point(cx - 20 * scale, by + 34 * scale),
    img.Point(cx + 24 * scale, by + 34 * scale),
    img.Point(cx - 10 * scale, by + 78 * scale),
  ], color: white);
  // "..." dentro do balão (três pontos roxos)
  for (var i = -1; i <= 1; i++) {
    img.fillCircle(im,
        x: (cx + i * 40 * scale).round(),
        y: (by - 2 * scale).round(),
        radius: (11 * scale).round(),
        color: ring);
  }
}

void main() {
  // fundo (gradiente) — usado no icon.png e no bg.png adaptativo
  final bg = img.Image(width: S, height: S);
  _gradientDiagonal(bg, [122, 59, 255], [255, 78, 138]); // roxo -> rosa

  // ícone legado (full-bleed): gradiente + câmera
  final icon = img.Image.from(bg);
  _drawCamera(icon, S / 2, S / 2, 1.05);
  File('assets/icon/icon.png').writeAsBytesSync(img.encodePng(icon));

  // background adaptativo (só o gradiente)
  File('assets/icon/bg.png').writeAsBytesSync(img.encodePng(bg));

  // foreground adaptativo (transparente + câmera menor, dentro da zona segura)
  final fg = img.Image(width: S, height: S, numChannels: 4);
  _drawCamera(fg, S / 2, S / 2, 0.82);
  File('assets/icon/icon_fg.png').writeAsBytesSync(img.encodePng(fg));

  stdout.writeln('Ícones gerados em assets/icon/ (icon.png, bg.png, icon_fg.png).');
}
