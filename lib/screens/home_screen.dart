import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/quick_access_card.dart';
import '../widgets/stat_card.dart';

/// RF1. Pantalla Inicio.
class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigateToTab;

  const HomeScreen({super.key, required this.onNavigateToTab});

  String _lifecycleMessage(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return 'La app esta activa y visible';
      case AppLifecycleState.inactive:
        return 'La app esta visible pero no recibe foco';
      case AppLifecycleState.paused:
        return 'La app esta en segundo plano';
      case AppLifecycleState.detached:
        return 'La app se desprendio de la vista nativa';
      case AppLifecycleState.hidden:
        return 'La app esta oculta';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final state = appState.lastLifecycleState;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BIENVENIDO A',
              style: TextStyle(color: AppColors.onBg, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
            const SizedBox(height: 6),
            const Text(
              'ExRE',
              style: TextStyle(color: AppColors.onBg, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Explora, filtra y da seguimiento a tus recursos de estudio de Flutter y Android.',
              style: TextStyle(color: AppColors.onBgMuted, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.show_chart_rounded, color: AppColors.primaryLight, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estado del ciclo de vida',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                        const SizedBox(height: 2),
                        Text(
                          '${state.name} · ${_lifecycleMessage(state)}',
                          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: StatCard(value: '${appState.totalCount}', label: 'Disponibles')),
                const SizedBox(width: 12),
                Expanded(child: StatCard(value: '${appState.favoriteCount}', label: 'Favoritos')),
                const SizedBox(width: 12),
                Expanded(child: StatCard(value: '${appState.completedCount}', label: 'Completados')),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Accesos rapidos',
                style: TextStyle(color: AppColors.onBg, fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: QuickAccessCard(
                    label: 'Catalogo',
                    icon: Icons.menu_book_rounded,
                    color: const Color(0xFF0EA5E9),
                    onTap: () => onNavigateToTab(1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: QuickAccessCard(
                    label: 'Galeria',
                    icon: Icons.grid_view_rounded,
                    color: paletteFor('Slivers').solid,
                    onTap: () => onNavigateToTab(2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: QuickAccessCard(
                    label: 'Favoritos',
                    icon: Icons.favorite_rounded,
                    color: AppColors.favorite,
                    onTap: () => onNavigateToTab(3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: QuickAccessCard(
                    label: 'Progreso',
                    icon: Icons.trending_up_rounded,
                    color: AppColors.success,
                    onTap: () => onNavigateToTab(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
