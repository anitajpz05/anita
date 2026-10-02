import 'package:flutter/material.dart';

import '../models/resource.dart';
import '../theme/app_theme.dart';
import 'resource_icons.dart';

/// Horizontal card used in Catalogo and Favoritos (ListView.builder /
/// ListView.separated). Tapping opens Detalle; the heart button toggles
/// favorite without leaving the list.
class ResourceListCard extends StatelessWidget {
  final Resource resource;
  final bool isFavorite;
  final bool isCompleted;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const ResourceListCard({
    super.key,
    required this.resource,
    required this.isFavorite,
    required this.isCompleted,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final palette = paletteFor(resource.category);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: palette.solid,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(iconForType(resource.type), color: Colors.white, size: 24),
                ),
                if (isCompleted)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          resource.category,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: palette.light, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Text(' · ', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
                      Flexible(
                        child: Text(
                          resource.author,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 12, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text('${resource.durationMinutes} min',
                          style: const TextStyle(color: AppColors.textTertiary, fontSize: 11)),
                      const SizedBox(width: 10),
                      Text(resource.level.label,
                          style: const TextStyle(color: AppColors.textTertiary, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onToggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppColors.favorite : AppColors.textTertiary,
                size: 20,
              ),
              tooltip: isFavorite ? 'Quitar de favoritos' : 'Marcar favorito',
            ),
          ],
        ),
      ),
    );
  }
}
