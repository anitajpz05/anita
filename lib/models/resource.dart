enum ResourceLevel { basico, intermedio, avanzado }

extension ResourceLevelX on ResourceLevel {
  String get label {
    switch (this) {
      case ResourceLevel.basico:
        return 'Basico';
      case ResourceLevel.intermedio:
        return 'Intermedio';
      case ResourceLevel.avanzado:
        return 'Avanzado';
    }
  }
}

enum ResourceType { video, lectura, practica, documento }

extension ResourceTypeX on ResourceType {
  String get label {
    switch (this) {
      case ResourceType.video:
        return 'Video';
      case ResourceType.lectura:
        return 'Lectura';
      case ResourceType.practica:
        return 'Practica';
      case ResourceType.documento:
        return 'Documento';
    }
  }
}

/// A single study resource shown across Catalogo, Galeria, Detalle,
/// Favoritos and Progreso. Favorite/completed state is NOT stored here:
/// it lives in [AppState] as sets of resource ids, per the project spec.
class Resource {
  final String id;
  final String title;
  final String category;
  final String author;
  final int durationMinutes;
  final ResourceLevel level;
  final String description;
  final ResourceType type;
  final String content;

  const Resource({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.durationMinutes,
    required this.level,
    required this.description,
    required this.type,
    required this.content,
  });
}
