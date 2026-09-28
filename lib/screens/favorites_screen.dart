import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/lang.dart';
import '../services/app_state.dart';
import '../widgets/verse_tile.dart';

/// Frases favoritadas pelo usuário (salvas localmente).
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final favs = state.favoriteVerses;

    return Scaffold(
      appBar: AppBar(title: Text(Lang.t('Favoritos', 'Favorites', 'Favoritos'))),
      body: favs.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border_rounded,
                        size: 56,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.3)),
                    const SizedBox(height: 12),
                    Text(Lang.t('Nenhum favorito ainda', 'No favorites yet', 'Aún no hay favoritos'),
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(Lang.t('Toque no ♥ em uma mensagem para salvá-la aqui.',
                        'Tap the ♥ on a caption to save it here.',
                        'Toca el ♥ en una frase para guardarla aquí.'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6))),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              itemCount: favs.length,
              itemBuilder: (context, i) => VerseTile(verse: favs[i]),
            ),
    );
  }
}
