import 'package:flutter/material.dart';

import '../models/resource.dart';
import '../theme/app_theme.dart';
import 'resource_icons.dart';

/// Square-ish card used in the Galeria's GridView.builder, with favorite
/// and completed badges overlaid on the cover.
class ResourceGridCard extends StatelessWidget {
  final Resource resource;
  final bool isFavorite;
  final bool isCompleted;
  final VoidCallback onTap;

  const ResourceGridCard({
    super.key,
    required this.resource,
    required this.isFavorite,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = paletteFor(resource.category);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Stack(
                children: [
                  Container(
                    color: palette.solid,
                    alignment: Alignment.center,
                    child: Icon(iconForType(resource.type), color: Colors.white, size: 28),
                  ),
                  if (isCompleted)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: _Badge(color: AppColors.success, icon: Icons.check),
                    ),
                  if (isFavorite)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: _Badge(color: Colors.black.withValues(alpha: 0.4), icon: Icons.favorite),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    resource.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${resource.category} · ${resource.level.label}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
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

class _Badge extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _Badge({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }
}
