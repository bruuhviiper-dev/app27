import 'dart:ui' show PlatformDispatcher;

/// Idioma ativo do app: 'pt' (padrão), 'en' ou 'es'.
///
/// Detectado do aparelho no arranque (main). Só PT/EN/ES são suportados;
/// qualquer outro idioma do sistema cai em português.
///
/// Estratégia "brecha da Elementare": em EN/ES o app mostra conteúdo + UI
/// nativos (não tradução de máquina) e esconde a divulgação dos apps PT.
class Lang {
  Lang._();

  static String code = 'pt';

  static void initFromDevice() {
    final l = PlatformDispatcher.instance.locale.languageCode.toLowerCase();
    if (l == 'en') {
      code = 'en';
    } else if (l == 'es') {
      code = 'es';
    } else {
      code = 'pt';
    }
  }

  static bool get isPt => code == 'pt';
  static bool get isEn => code == 'en';
  static bool get isEs => code == 'es';

  /// Seleciona a string pelo idioma ativo, com fallback para português.
  static String t(String pt, String en, String es) {
    switch (code) {
      case 'en':
        return en;
      case 'es':
        return es;
      default:
        return pt;
    }
  }
}
