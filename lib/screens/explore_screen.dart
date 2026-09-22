import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/vibe_repository.dart';
import '../models/models.dart';
import '../state/player_controller.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';
import '../widgets/common_widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _filterIndex = 0;
  bool _listening = false;

  void _startListening() {
    setState(() => _listening = true);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _listening = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 14),
          _buildFilterPills(),
          const SizedBox(height: 16),
          _buildTrends(),
          const SizedBox(height: 24),
          _buildGenres(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Column(
      children: [
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: VibeColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(VibeRadius.full),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: VibeColors.outline, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  style: VibeText.bodyMd(),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: '¿Qué quieres escuchar hoy?',
                    hintStyle: VibeText.bodyMd(color: VibeColors.outline),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _startListening,
                child: const Icon(
                  Icons.mic_none,
                  color: VibeColors.onSurfaceVariant,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _startListening,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: VibeColors.secondaryContainer.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.graphic_eq,
                    color: VibeColors.secondary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_listening) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: VibeColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(VibeRadius.md),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: VibeColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Escuchando entorno para identificar pista...',
                    style: VibeText.labelMd(),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _listening = false),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: VibeColors.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilterPills() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: VibeRepository.filterPills.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final active = i == _filterIndex;
          return VibeChip(
            label: VibeRepository.filterPills[i],
            active: active,
            activeColor: VibeColors.onSurface,
            activeTextColor: VibeColors.surface,
            onTap: () => setState(() => _filterIndex = i),
          );
        },
      ),
    );
  }

  Widget _buildTrends() {
    final trends = VibeRepository.trends;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.local_fire_department,
              color: VibeColors.tertiary,
              size: 20,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text('Tendencias ahora', style: VibeText.headlineSm()),
            ),
            Text(
              'Ver todo',
              style: VibeText.labelSm(color: VibeColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: trends.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) =>
                _TrendCard(item: trends[i], badgeColor: _trendColor(i)),
          ),
        ),
      ],
    );
  }

  Color _trendColor(int i) =>
      [VibeColors.tertiary, VibeColors.secondary, VibeColors.primary][i % 3];

  Widget _buildGenres() {
    final genres = VibeRepository.genres;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explorar por géneros y estados de ánimo',
          style: VibeText.headlineSm(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: genres.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, i) => _GenreCard(genre: genres[i]),
        ),
      ],
    );
  }
}

class _TrendCard extends StatelessWidget {
  final Playlist item;
  final Color badgeColor;
  const _TrendCard({required this.item, required this.badgeColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PlayerController>().playFromList(
        VibeRepository.trending.first,
        VibeRepository.trending,
      ),
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: VibeColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(VibeRadius.md),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CoverArt(url: item.coverUrl, size: 64),
                Positioned(
                  bottom: 3,
                  left: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: VibeColors.tertiaryContainer.withValues(
                        alpha: 0.85,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '#1',
                      style: VibeText.labelSm(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.badge?.toUpperCase() ?? '',
                    style: VibeText.labelSm(
                      color: badgeColor,
                    ).copyWith(letterSpacing: 1),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.labelLg().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
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

class _GenreCard extends StatelessWidget {
  final Genre genre;
  const _GenreCard({required this.genre});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(VibeRadius.md),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: genre.gradient,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 12,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  genre.name,
                  maxLines: 2,
                  style: VibeText.headlineSm(
                    color: Colors.white,
                  ).copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
            ),
            Positioned(
              bottom: -6,
              right: -6,
              child: RotatedThumb(url: genre.coverUrl, size: 62),
            ),
          ],
        ),
      ),
    );
  }
}
