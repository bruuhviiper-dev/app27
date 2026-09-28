import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/models.dart';
import '../l10n/lang.dart';
import '../screens/create_screen.dart';
import '../services/app_state.dart';
import 'share_helper.dart';

/// Cartão de uma frase, com favoritar, editar, copiar e compartilhar.
class VerseTile extends StatelessWidget {
  const VerseTile({super.key, required this.verse});

  final Verse verse;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final fav = state.isFavorite(verse.id);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 6, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(verse.text,
                style: GoogleFonts.lora(fontSize: 16, height: 1.5)),
            if (verse.reference.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(verse.reference,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: scheme.primary)),
            ],
            Row(
              children: [
                IconButton(
                  tooltip: Lang.t('Favoritar', 'Favorite', 'Favorito'),
                  icon: Icon(fav ? Icons.favorite : Icons.favorite_border,
                      color: fav ? const Color(0xFFE11D48) : null),
                  onPressed: () =>
                      context.read<AppState>().toggleFavorite(verse),
                ),
                IconButton(
                  tooltip: Lang.t('Editar', 'Edit', 'Editar'),
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () => _edit(context, verse.text),
                ),
                IconButton(
                  tooltip: Lang.t('Criar imagem', 'Create image', 'Crear imagen'),
                  icon: const Icon(Icons.image_rounded),
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                          builder: (_) => CreateScreen(initialText: verse.text))),
                ),
                IconButton(
                  tooltip: Lang.t('Copiar', 'Copy', 'Copiar'),
                  icon: const Icon(Icons.copy_rounded),
                  onPressed: () async {
                    await ShareHelper.copy(verse.shareText);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Lang.t('Copiado!', 'Copied!', '¡Copiado!'))),
                      );
                    }
                  },
                ),
                const Spacer(),
                IconButton(
                  tooltip: Lang.t('Compartilhar', 'Share', 'Compartir'),
                  icon: const Icon(Icons.share_rounded),
                  onPressed: () => ShareHelper.share(verse.shareText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Editar a frase antes de copiar/compartilhar (autonomia do usuário).
  void _edit(BuildContext context, String initial) {
    final c = TextEditingController(text: initial);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => Padding(
        // Teclado empurra o conteudo pra cima...
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        // ...e o SafeArea garante espaco pra barra de navegacao (edge-to-edge).
        child: SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(Lang.t('Editar frase', 'Edit caption', 'Editar frase'),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ),
            TextField(
              controller: c,
              maxLines: 5,
              minLines: 3,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await ShareHelper.copy(c.text.trim());
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: Text(Lang.t('Copiar', 'Copy', 'Copiar')),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ShareHelper.share(c.text.trim());
                    },
                    icon: const Icon(Icons.share_rounded),
                    label: Text(Lang.t('Compartilhar', 'Share', 'Compartir')),
                  ),
                ),
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }
}
