import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/vibe_repository.dart';
import '../state/player_controller.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';
import '../screens/home_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/now_playing_screen.dart';
import '../screens/library_screen.dart';
import 'mini_player.dart';
import 'vibe_logo.dart';

/// Estructura raíz de Vibe: cabecera, cuerpo con pestañas, mini-reproductor
/// persistente y barra de navegación inferior.
class RootShell extends StatefulWidget {
  final PlayerController controller;
  const RootShell({super.key, required this.controller});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  static const _titles = ['Inicio', 'Explorar', 'Reproductor', 'Tu Biblioteca'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.controller,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0D15), VibeColors.canvas],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: IndexedStack(
                      index: _index,
                      children: const [
                        HomeScreen(),
                        ExploreScreen(),
                        NowPlayingScreen(),
                        LibraryScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: _buildBottom(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
        child: Row(
          children: [
            const VibeLogo(size: 34),
            const SizedBox(width: 10),
            Text(_titles[_index], style: VibeText.headlineMd()),
            const Spacer(),
            if (_index == 0 || _index == 1 || _index == 3)
              _headerIcon(Icons.notifications_none),
            if (_index == 2) _headerIcon(Icons.more_vert),
            const SizedBox(width: 10),
            ClipOval(
              child: Image.network(
                VibeRepository.profileImage,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 36,
                  height: 36,
                  color: VibeColors.surfaceContainerHigh,
                  child: const Icon(Icons.person, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 4),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Icon(icon, color: VibeColors.onSurface, size: 24),
    );
  }

  Widget _buildBottom() {
    return Container(
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainerLowest.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MiniPlayer(onExpand: () => setState(() => _index = 2)),
            _buildNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    const items = [
      (Icons.home_outlined, Icons.home, 'Inicio'),
      (Icons.explore_outlined, Icons.explore, 'Explorar'),
      (Icons.graphic_eq, Icons.graphic_eq, 'Reproductor'),
      (Icons.library_music_outlined, Icons.library_music, 'Tu Biblioteca'),
    ];
    return SizedBox(
      height: 62,
      child: Row(
        children: List.generate(items.length, (i) {
          final active = i == _index;
          final item = items[i];
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _index = i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    active ? item.$2 : item.$1,
                    size: 22,
                    color: active
                        ? VibeColors.primary
                        : VibeColors.onSurfaceVariant,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.$3,
                    style: VibeText.labelSm(
                      color: active
                          ? VibeColors.primary
                          : VibeColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
