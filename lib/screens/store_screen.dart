import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/app_theme.dart';
import '../l10n/lang.dart';
import '../services/app_state.dart';
import '../services/purchase_service.dart';
import '../services/store_products.dart';

/// Loja enxuta: o único produto é "Remover anúncios" (compra única). Todo o
/// resto do app — temas, editor, marca d'água, categorias — é grátis.
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  Future<void> _buy(BuildContext context, String id) async {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(Lang.t('Processando…', 'Processing…', 'Procesando…'))));
    final res = await PurchaseService.instance.buy(id);
    if (!context.mounted) return;
    final msg = res == PurchaseResult.success
        ? Lang.t('Tudo certo! Anúncios removidos. 🎉',
            'All set! Ads removed. 🎉',
            '¡Listo! Anuncios eliminados. 🎉')
        : Lang.t('Não foi possível concluir a compra.',
            'We couldn\'t complete the purchase.',
            'No pudimos completar la compra.');
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final price = PurchaseService.instance.priceOf(StoreProducts.removeAds.id);
    return Scaffold(
      appBar: AppBar(title: Text(Lang.t('Remover anúncios', 'Remove ads', 'Quitar anuncios'))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              // Card acompanha o tema escolhido (só o estado "removido" fica
              // verde, como sinal de concluído).
              gradient: AppTheme.gradient(state.adsRemoved
                  ? const [Color(0xFF11998E), Color(0xFF38EF7D)]
                  : state.palette.gradient),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.adsRemoved ? '✅' : '🚫',
                    style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 12),
                Text(
                    state.adsRemoved
                        ? Lang.t('Você já removeu os anúncios!',
                            'You\'ve already removed ads!',
                            '¡Ya has quitado los anuncios!')
                        : Lang.t('Use o app sem anúncios',
                            'Use the app without ads',
                            'Usa la app sin anuncios'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(
                    state.adsRemoved
                        ? Lang.t('Obrigado pelo apoio 💜 Aproveite tudo sem interrupções.',
                            'Thanks for the support 💜 Enjoy everything without interruptions.',
                            'Gracias por tu apoyo 💜 Disfruta todo sin interrupciones.')
                        : Lang.t('Pagamento único, para sempre. Sem assinaturas.',
                            'One-time payment, forever. No subscriptions.',
                            'Pago único, para siempre. Sin suscripciones.'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600)),
                if (!state.adsRemoved) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: state.accentColor,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => _buy(context, StoreProducts.removeAds.id),
                      child: Text(
                          price.isEmpty
                              ? Lang.t('Remover anúncios', 'Remove ads', 'Quitar anuncios')
                              : '${Lang.t('Remover anúncios', 'Remove ads', 'Quitar anuncios')}  •  $price',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _FreeBadge(),
        ],
      ),
    );
  }
}

/// Reforça que tudo o mais é grátis (evita a sensação de "app pago").
class _FreeBadge extends StatelessWidget {
  const _FreeBadge();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final items = [
      ('🎨', Lang.t('Todos os temas grátis', 'All themes free', 'Todos los temas gratis')),
      ('✍️', Lang.t('Editor completo, sem marca d\'água', 'Full editor, no watermark', 'Editor completo, sin marca de agua')),
      ('📂', Lang.t('Todas as categorias liberadas', 'All categories unlocked', 'Todas las categorías desbloqueadas')),
      ('🖼️', Lang.t('Fundos, texturas e fotos reais', 'Backgrounds, textures and real photos', 'Fondos, texturas y fotos reales')),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Lang.t('Tudo isto é grátis', 'All of this is free', 'Todo esto es gratis'),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  color: scheme.primary)),
          const SizedBox(height: 12),
          for (final it in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(it.$1, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
                  Text(it.$2,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
