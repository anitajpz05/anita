import 'package:flutter/material.dart';

import '../models/resource.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/resource_icons.dart';

/// RF4. Pantalla Detalle.
///
/// Pushed with Navigator.push from Catalogo, Galeria and Favoritos. Reads
/// live favorite/completed state from [AppState] so toggling here is
/// reflected everywhere else as soon as this screen pops.
class DetailScreen extends StatefulWidget {
  final String resourceId;

  const DetailScreen({super.key, required this.resourceId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late AppState _appState;
  bool _dependenciesReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appState = AppScope.of(context);
    if (!_dependenciesReady) {
      _dependenciesReady = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _appState.openResource(widget.resourceId);
      });
    }
  }

  @override
  void dispose() {
    _appState.closeResource();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final resource = appState.resourceById(widget.resourceId);
    final palette = paletteFor(resource.category);
    final isFavorite = appState.isFavorite(resource.id);
    final isCompleted = appState.isCompleted(resource.id);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Hero(
                palette: palette,
                resource: resource,
                isFavorite: isFavorite,
                onBack: () => Navigator.of(context).pop(),
                onToggleFavorite: () => appState.toggleFavorite(resource.id),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.category.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.onBgMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      resource.title,
                      style: const TextStyle(
                        color: AppColors.onBg,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 14, color: AppColors.onBgSubtle),
                        const SizedBox(width: 6),
                        Text(resource.author,
                            style: const TextStyle(color: AppColors.onBgMuted, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _MetaChip(icon: Icons.timer_outlined, label: '${resource.durationMinutes} min'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MetaChip(icon: Icons.signal_cellular_alt, label: resource.level.label),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MetaChip(icon: iconForType(resource.type), label: resource.type.label),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Descripcion',
                        style: TextStyle(color: AppColors.onBg, fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(resource.description,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
                    const SizedBox(height: 20),
                    const Text('Contenido',
                        style: TextStyle(color: AppColors.onBg, fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.link, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              resource.content,
                              style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => appState.toggleFavorite(resource.id),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        label: Text(isFavorite ? 'Quitar de favoritos' : 'Marcar favorito'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => appState.toggleCompleted(resource.id),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white54),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        icon: Icon(isCompleted ? Icons.replay : Icons.check),
                        label: Text(isCompleted ? 'Marcar como pendiente' : 'Marcar completado'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Volver al listado anterior',
                            style: TextStyle(color: AppColors.textSecondary)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final CategoryPalette palette;
  final Resource resource;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onToggleFavorite;

  const _Hero({
    required this.palette,
    required this.resource,
    required this.isFavorite,
    required this.onBack,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: palette.solid,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CircleButton(icon: Icons.arrow_back, onTap: onBack),
              _CircleButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                onTap: onToggleFavorite,
                iconColor: isFavorite ? AppColors.favorite : Colors.white,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.24)),
            ),
            child: Icon(iconForType(resource.type), color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const _CircleButton({required this.icon, required this.onTap, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
