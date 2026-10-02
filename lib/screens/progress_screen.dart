import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/resource_list_card.dart';
import 'detail_screen.dart';

/// RF6. Pantalla Progreso.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final ratio = appState.completionRatio;
    final percent = (ratio * 100).round();
    final breakdown = appState.categoryBreakdown;
    final completed = appState.completedResources;
    final lastEvent = appState.lifecycleHistory.isNotEmpty ? appState.lifecycleHistory.last : null;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text('Progreso',
                  style: TextStyle(color: AppColors.onBg, fontSize: 26, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  // ------------------------------------------------ Overall
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$percent%',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${appState.completedCount} completados',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                Text('${appState.pendingCount} pendientes',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.2),
                            valueColor: const AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ---------------------------------------------- Lifecycle
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
                        const Icon(Icons.history, size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Ultimo evento de ciclo de vida',
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                              const SizedBox(height: 2),
                              Text(
                                lastEvent?.label ?? 'Sin eventos registrados',
                                style: const TextStyle(
                                    color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ------------------------------------------------ By category
                  const Text('Resumen por categoria',
                      style: TextStyle(color: AppColors.onBg, fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 14),
                  ...breakdown.map((entry) {
                    final category = entry.key;
                    final (done, total) = entry.value;
                    final palette = paletteFor(category);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(color: palette.light, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(category,
                                      style: const TextStyle(
                                          color: AppColors.onBg, fontSize: 13, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Text('$done/$total',
                                  style: const TextStyle(color: AppColors.onBgMuted, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: total == 0 ? 0 : done / total,
                              minHeight: 6,
                              backgroundColor: AppColors.border,
                              valueColor: AlwaysStoppedAnimation(palette.light),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  // ------------------------------------------- Completed list
                  const Text('Recursos completados',
                      style: TextStyle(color: AppColors.onBg, fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  if (completed.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: EmptyState(
                        icon: Icons.check_circle_outline,
                        title: 'Todavia no completas recursos',
                        message: 'Marca un recurso como completado desde su pantalla de Detalle.',
                      ),
                    )
                  else
                    ...completed.map(
                      (resource) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ResourceListCard(
                          resource: resource,
                          isFavorite: appState.isFavorite(resource.id),
                          isCompleted: true,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => DetailScreen(resourceId: resource.id)),
                          ),
                          onToggleFavorite: () => appState.toggleFavorite(resource.id),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
