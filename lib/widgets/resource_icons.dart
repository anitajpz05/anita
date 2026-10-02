import 'package:flutter/material.dart';

import '../models/resource.dart';

IconData iconForType(ResourceType type) {
  switch (type) {
    case ResourceType.video:
      return Icons.play_arrow_rounded;
    case ResourceType.lectura:
      return Icons.menu_book_rounded;
    case ResourceType.practica:
      return Icons.science_rounded;
    case ResourceType.documento:
      return Icons.description_rounded;
  }
}
