import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/resource_list_card.dart';
import 'detail_screen.dart';

/// RF5. Pantalla Favoritos: usa ListView.separated (con divisores),
/// cumpliendo el requisito de scroll alternativo al ListView.builder
/// del Catalogo.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final favorites = appState.favoriteResources;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text('Favoritos',
                  style: TextStyle(color: AppColors.onBg, fontSize: 26, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: favorites.isEmpty
                  ? const EmptyState(
                      icon: Icons.favorite_border,
                      title: 'Aun no tienes favoritos',
                      message: 'Marca recursos con el corazon desde el Catalogo, la Galeria o el Detalle.',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      itemCount: favorites.length,
                      separatorBuilder: (_, __) => const Divider(color: AppColors.border, height: 20),
                      itemBuilder: (context, index) {
                        final resource = favorites[index];
                        return ResourceListCard(
                          resource: resource,
                          isFavorite: true,
                          isCompleted: appState.isCompleted(resource.id),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => DetailScreen(resourceId: resource.id)),
                          ),
                          onToggleFavorite: () => appState.removeFavorite(resource.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
