import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/resource_grid_card.dart';
import 'detail_screen.dart';

/// RF3. Pantalla Galeria: coleccion visual en cuadricula con
/// GridView.builder + SliverGridDelegateWithFixedCrossAxisCount.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final resources = appState.resources;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text('Galeria',
                  style: TextStyle(color: AppColors.onBg, fontSize: 26, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                itemCount: resources.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final resource = resources[index];
                  return ResourceGridCard(
                    resource: resource,
                    isFavorite: appState.isFavorite(resource.id),
                    isCompleted: appState.isCompleted(resource.id),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => DetailScreen(resourceId: resource.id)),
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
