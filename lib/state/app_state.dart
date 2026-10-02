import 'package:flutter/material.dart';

import '../data/sample_resources.dart';
import '../models/resource.dart';
import '../theme/app_theme.dart';

const String kAllCategoriesLabel = 'Todas';

/// A short, human readable record of one lifecycle transition, used to
/// feed the "Historial breve de eventos de ciclo de vida" (RF Estado y ciclo de vida).
class LifecycleEvent {
  final AppLifecycleState state;
  final TimeOfDay time;

  LifecycleEvent(this.state, this.time);

  String get label => '${state.name} a las ${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}';
}

/// Single source of truth for the whole app. Built only on top of
/// [ChangeNotifier], which ships with the Flutter SDK itself -- no external
/// state management package is used, per the project's scope constraints.
class AppState extends ChangeNotifier {
  AppState() {
    _recordEvent(AppLifecycleState.resumed);
  }

  final List<Resource> resources = List.unmodifiable(kSampleResources);

  final Set<String> _favoriteIds = {'r1', 'r13', 'r21'};
  final Set<String> _completedIds = {'r1', 'r5', 'r10', 'r14', 'r22'};

  String _selectedCategory = kAllCategoriesLabel;
  String _searchQuery = '';
  String? _openedResourceId;

  AppLifecycleState _lastLifecycleState = AppLifecycleState.resumed;
  final List<LifecycleEvent> _lifecycleHistory = [];

  // ---------------------------------------------------------------- getters
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String? get openedResourceId => _openedResourceId;
  AppLifecycleState get lastLifecycleState => _lastLifecycleState;
  List<LifecycleEvent> get lifecycleHistory => List.unmodifiable(_lifecycleHistory);

  bool isFavorite(String id) => _favoriteIds.contains(id);
  bool isCompleted(String id) => _completedIds.contains(id);

  Resource resourceById(String id) => resources.firstWhere((r) => r.id == id);

  List<Resource> get filteredResources {
    final query = _searchQuery.trim().toLowerCase();
    return resources.where((r) {
      final matchesCategory =
          _selectedCategory == kAllCategoriesLabel || r.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          r.title.toLowerCase().contains(query) ||
          r.category.toLowerCase().contains(query) ||
          r.author.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList(growable: false);
  }

  List<Resource> get favoriteResources =>
      resources.where((r) => _favoriteIds.contains(r.id)).toList(growable: false);

  List<Resource> get completedResources =>
      resources.where((r) => _completedIds.contains(r.id)).toList(growable: false);

  int get totalCount => resources.length;
  int get favoriteCount => _favoriteIds.length;
  int get completedCount => _completedIds.length;
  int get pendingCount => totalCount - completedCount;

  double get completionRatio => totalCount == 0 ? 0 : completedCount / totalCount;

  /// Per-category (completed, total) breakdown for the Progreso screen.
  List<MapEntry<String, (int, int)>> get categoryBreakdown {
    final entries = <MapEntry<String, (int, int)>>[];
    for (final category in kCategories) {
      final inCategory = resources.where((r) => r.category == category);
      final total = inCategory.length;
      if (total == 0) continue;
      final completed = inCategory.where((r) => _completedIds.contains(r.id)).length;
      entries.add(MapEntry(category, (completed, total)));
    }
    return entries;
  }

  // --------------------------------------------------------------- mutators
  void toggleFavorite(String id) {
    if (!_favoriteIds.add(id)) {
      _favoriteIds.remove(id);
    }
    notifyListeners();
  }

  void removeFavorite(String id) {
    if (_favoriteIds.remove(id)) {
      notifyListeners();
    }
  }

  void toggleCompleted(String id) {
    if (!_completedIds.add(id)) {
      _completedIds.remove(id);
    }
    notifyListeners();
  }

  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void openResource(String id) {
    _openedResourceId = id;
    notifyListeners();
  }

  void closeResource() {
    _openedResourceId = null;
    notifyListeners();
  }

  void recordLifecycleEvent(AppLifecycleState state) {
    _lastLifecycleState = state;
    _recordEvent(state);
    notifyListeners();
  }

  void _recordEvent(AppLifecycleState state) {
    final now = TimeOfDay.now();
    _lifecycleHistory.add(LifecycleEvent(state, now));
    if (_lifecycleHistory.length > 6) {
      _lifecycleHistory.removeAt(0);
    }
  }
}

/// Makes the single [AppState] instance reachable from any descendant via
/// `AppScope.of(context)`, and rebuilds dependents through [InheritedNotifier]
/// -- again, only SDK building blocks, no external package.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child}) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!.notifier!;
  }
}
