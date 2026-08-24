/// Fundos-foto GRÁTIS do editor de imagem (seção "Fotos" da tela Criar).
///
/// As imagens vêm do Lorem Picsum (fotos do Unsplash — licença livre para uso
/// comercial: https://unsplash.com/license). Os ids foram CURADOS manualmente
/// (conferidos um a um): paisagens/natureza + lifestyle com pessoas de
/// COSTAS/silhueta ou só mãos (nunca rosto identificável, nunca animais/marcas),
/// para não alterar a classificação do app nem esbarrar em direito de imagem.
///
/// São carregadas da internet e cacheadas no disco pelo `cached_network_image`.
/// Depois de abertas 1x, seguem disponíveis mesmo SEM internet.
class PhotoBackground {
  const PhotoBackground(this.id);

  /// Id estável da foto no Picsum.
  final String id;

  /// Imagem em alta para o fundo do cartão (story 9:16, com folga para os
  /// formatos quadrado/retrato via BoxFit.cover).
  String get full => 'https://picsum.photos/id/$id/1080/1920';

  /// Miniatura leve para o seletor.
  String get thumb => 'https://picsum.photos/id/$id/160/240';
}

/// Catálogo curado de fundos-foto (paisagens). Facilmente ampliável.
const photoBackgrounds = <PhotoBackground>[
  // ---- destaques "legenda pra foto" (pessoas de costas/silhueta ou mãos) ----
  PhotoBackground('1006'), // pessoa sentada na falésia (de costas)
  PhotoBackground('1011'), // pessoa em píer sobre a água (de costas)
  PhotoBackground('177'),  // trekker na neblina (de costas)
  PhotoBackground('447'),  // homem diante do lago (de costas)
  PhotoBackground('669'),  // mochileiro olhando o horizonte (de costas)
  PhotoBackground('1009'), // pessoa na praia (de costas)
  PhotoBackground('334'),  // silhueta com prancha ao pôr do sol
  PhotoBackground('823'),  // câmera vintage cobrindo o rosto (tema fotos)
  PhotoBackground('1010'), // mãos segurando um livro
  PhotoBackground('1012'), // lendo na natureza (de costas)
  PhotoBackground('225'),  // café sendo coado (mãos)
  PhotoBackground('326'),  // xícara de café nas mãos
  PhotoBackground('431'),  // cafés na mesa (lifestyle)
  PhotoBackground('183'),  // kombi / van de viagem
  // ---- paisagens ----
  PhotoBackground('1015'), // fiorde / penhasco
  PhotoBackground('1057'), // costa ao pôr do sol
  PhotoBackground('1037'), // nascer do sol entre árvores
  PhotoBackground('1018'), // montanhas verdes e estrada
  PhotoBackground('1039'), // cachoeira e vale verde
  PhotoBackground('1043'), // vale de Yosemite
  PhotoBackground('1045'), // montanha verde
  PhotoBackground('1051'), // cais de madeira no lago
  PhotoBackground('1036'), // montanhas nevadas
  PhotoBackground('1016'), // cânion no fim de tarde
  PhotoBackground('1064'), // neblina sobre as colinas
  PhotoBackground('1044'), // floresta com névoa
  PhotoBackground('1041'), // mar sereno / gelo
  PhotoBackground('1038'), // costa gelada
  PhotoBackground('1052'), // praia de rocha negra
  PhotoBackground('1055'), // lago calmo ao amanhecer
  PhotoBackground('1019'), // mar sob céu nublado
  PhotoBackground('1061'), // praia serena
  PhotoBackground('1023'), // campos vistos do alto
  // ---- ampliação (paisagens/natureza, licença Unsplash) ----
  PhotoBackground('1002'), // cidade à noite
  PhotoBackground('1003'), // folhas de outono
  PhotoBackground('1004'), // rua arborizada
  PhotoBackground('1008'), // arranha-céus
  PhotoBackground('1013'), // costa rochosa
  PhotoBackground('1014'), // mar e horizonte
  PhotoBackground('1020'), // rio na floresta
  PhotoBackground('1021'), // fachada / arquitetura
  PhotoBackground('1024'), // montanhas e lago
  PhotoBackground('1029'), // trilho na floresta
  PhotoBackground('1031'), // campo dourado
  PhotoBackground('1033'), // estrada no campo
  PhotoBackground('1035'), // montanha nevada
  PhotoBackground('1042'), // vale verde
  PhotoBackground('1047'), // rua antiga
  PhotoBackground('1048'), // cidade e ponte
  PhotoBackground('1049'), // praia tropical
  PhotoBackground('1050'), // cidade litorânea
  PhotoBackground('1053'), // pôr do sol no mar
  PhotoBackground('1054'), // ilha e mar
  PhotoBackground('1056'), // vale ensolarado
  PhotoBackground('1058'), // estrada e montanha
  PhotoBackground('1059'), // trilha na mata
  PhotoBackground('1060'), // cais e lago
  PhotoBackground('1062'), // outono dourado
  PhotoBackground('1063'), // neve e árvores
  PhotoBackground('1065'), // vista aérea da costa
  PhotoBackground('1066'), // colinas verdes
  PhotoBackground('1069'), // lago e montanhas
  PhotoBackground('1070'), // floresta densa
  PhotoBackground('1071'), // céu e nuvens
  PhotoBackground('1072'), // deserto ao entardecer
  PhotoBackground('1073'), // dunas
  PhotoBackground('1074'), // campo aberto
  PhotoBackground('1075'), // praia e falésias
  PhotoBackground('1076'), // horizonte urbano
  PhotoBackground('1077'), // lago espelhado
  PhotoBackground('1080'), // vinhedos
  PhotoBackground('1081'), // rua histórica
  PhotoBackground('1082'), // campo florido
  PhotoBackground('1083'), // montanha ao amanhecer
  PhotoBackground('1084'), // costa e farol
  // ---- paisagens extras (curadas via tool/curate_photos.dart) ----
  PhotoBackground('1000'), // costa / praia
  PhotoBackground('1001'), // duna / trilha na areia
  PhotoBackground('1022'), // aurora boreal
  PhotoBackground('1026'), // trilho ao pôr do sol
  PhotoBackground('1028'), // árvores na névoa
  PhotoBackground('1032'), // outono visto de cima
  PhotoBackground('1040'), // castelo entre montanhas
  PhotoBackground('1067'), // cidade vista da montanha
  PhotoBackground('1068'), // broto na praia (minimal)
  PhotoBackground('1078'), // prédios à noite
  PhotoBackground('1079'), // luz circular (abstrato)
  PhotoBackground('110'),  // campo ao pôr do sol
  PhotoBackground('164'),  // casas do canal
  PhotoBackground('197'),  // trilho entrando na mata
  PhotoBackground('884'),  // cogumelos (macro natureza)
];
