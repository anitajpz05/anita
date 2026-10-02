import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';
import '../widgets/resource_list_card.dart';
import 'detail_screen.dart';

/// RF2. Pantalla Catalogo: busqueda + filtro por categoria + lista
/// construida con ListView.builder (requisito obligatorio de la lista larga).
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final results = appState.filteredResources;
    final categories = [kAllCategoriesLabel, ...kCategories];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Catalogo',
                    style: TextStyle(color: AppColors.onBg, fontSize: 26, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: appState.setSearchQuery,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: AppColors.textTertiary, size: 20),
                  hintText: 'Buscar por titulo, categoria o autor',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryChip(
                    label: category,
                    selected: appState.selectedCategory == category,
                    onTap: () => appState.setCategory(category),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'RESULTADOS (${results.length})',
                  style: const TextStyle(
                    color: AppColors.onBgSubtle,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: results.isEmpty
                  ? const Center(
                      child: Text('No se encontraron recursos', style: TextStyle(color: AppColors.textSecondary)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final resource = results[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ResourceListCard(
                            resource: resource,
                            isFavorite: appState.isFavorite(resource.id),
                            isCompleted: appState.isCompleted(resource.id),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => DetailScreen(resourceId: resource.id)),
                            ),
                            onToggleFavorite: () => appState.toggleFavorite(resource.id),
                          ),
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
