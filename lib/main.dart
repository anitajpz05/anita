import 'package:flutter/material.dart';

import 'screens/main_shell.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ExreApp());
}

/// Root widget. Owns the single [AppState] instance and observes
/// [AppLifecycleState] changes (RF1 / Estado y ciclo de vida) so the whole
/// tree can react to resumed/inactive/paused/detached transitions.
class ExreApp extends StatefulWidget {
  const ExreApp({super.key});

  @override
  State<ExreApp> createState() => _ExreAppState();
}

class _ExreAppState extends State<ExreApp> with WidgetsBindingObserver {
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _appState.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appState.recordLifecycleEvent(state);
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _appState,
      child: MaterialApp(
        title: 'ExRE',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const MainShell(),
      ),
    );
  }
}
