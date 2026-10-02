import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'catalog_screen.dart';
import 'favorites_screen.dart';
import 'gallery_screen.dart';
import 'home_screen.dart';
import 'progress_screen.dart';

/// RF7. Navegacion basica.
///
/// Hosts the five tab screens (Inicio, Catalogo, Galeria, Favoritos,
/// Progreso) behind a single persistent BottomNavigationBar. Detalle is
/// pushed on top of this shell with Navigator.push, so the whole app uses
/// exactly one navigation mechanism: the imperative Navigator API.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _index,
          children: [
            HomeScreen(onNavigateToTab: _goToTab),
            const CatalogScreen(),
            const GalleryScreen(),
            const FavoritesScreen(),
            const ProgressScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _goToTab,
        backgroundColor: AppColors.bg,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Catalogo'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Galeria'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up_rounded), label: 'Progreso'),
        ],
      ),
    );
  }
}
