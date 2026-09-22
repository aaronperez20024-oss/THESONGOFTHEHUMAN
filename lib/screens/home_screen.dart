import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/vibe_repository.dart';
import '../models/models.dart';
import '../state/player_controller.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _GreetingHeader(),
          const SizedBox(height: 16),
          const _MoodChips(),
          const SizedBox(height: 24),
          const _RecentlyPlayed(),
          const SizedBox(height: 28),
          const _MadeForYou(),
          const SizedBox(height: 28),
          const _FeaturedRelease(),
          const SizedBox(height: 28),
          const _TrendingList(),
        ],
      ),
    );
  }
}

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SESIÓN NOCTURNA',
                    style: VibeText.labelMd(
                      color: VibeColors.primary,
                    ).copyWith(letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 4),
                  Text('Buenas noches, Alex', style: VibeText.headlineLg()),
                ],
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: VibeColors.surfaceContainerHigh,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.history,
                    color: VibeColors.secondary,
                    size: 20,
                  ),
                  Positioned(
                    top: 9,
                    right: 9,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: VibeColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MoodChips extends StatelessWidget {
  const _MoodChips();

  static const _icons = [
    Icons.bolt,
    Icons.bedtime_outlined,
    Icons.fitness_center,
    Icons.celebration_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: VibeRepository.moods.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final active = i == 0;
          return VibeChip(
            label: VibeRepository.moods[i],
            active: active,
            glow: active,
            icon: _icons[i],
            onTap: () {},
          );
        },
      ),
    );
  }
}

class _RecentlyPlayed extends StatelessWidget {
  const _RecentlyPlayed();

  @override
  Widget build(BuildContext context) {
    final items = VibeRepository.recent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Escuchado recientemente',
          actionLabel: 'Ver todo',
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, i) => _RecentTile(item: items[i]),
        ),
      ],
    );
  }
}

class _RecentTile extends StatelessWidget {
  final Playlist item;
  const _RecentTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _playFirst(context),
      child: GlassCard(
        radius: VibeRadius.md,
        opacity: 0.55,
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            CoverArt(url: item.coverUrl, size: 46),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.labelMd().copyWith(
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

  void _playFirst(BuildContext context) {
    final player = context.read<PlayerController>();
    final song = VibeRepository.trending.first;
    player.playFromList(song, VibeRepository.trending);
  }
}

class _MadeForYou extends StatelessWidget {
  const _MadeForYou();

  @override
  Widget build(BuildContext context) {
    final items = VibeRepository.madeForYou;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hecho para ti', style: VibeText.headlineSm()),
                  const SizedBox(height: 2),
                  Text(
                    'Recomendaciones basadas en tu historial',
                    style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: VibeColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: VibeColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: VibeColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) => _MixCard(item: items[i]),
          ),
        ),
      ],
    );
  }
}

class _MixCard extends StatelessWidget {
  final Playlist item;
  const _MixCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(VibeRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.accentColors.first.withValues(alpha: 0.25),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CoverArt(
                    url: item.coverUrl,
                    size: 200,
                    radius: VibeRadius.md,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () =>
                          context.read<PlayerController>().togglePlay(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.accentColors.first,
                          boxShadow: [
                            BoxShadow(
                              color: item.accentColors.first.withValues(
                                alpha: 0.6,
                              ),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                item.badge?.toUpperCase() ?? '',
                style: VibeText.labelSm(
                  color: item.accentColors.first,
                ).copyWith(letterSpacing: 1),
              ),
              const SizedBox(height: 2),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: VibeText.headlineSm(
                  color: VibeColors.onSurface,
                ).copyWith(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                item.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: VibeColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(VibeRadius.full),
                    ),
                    child: Text(
                      '${item.trackCount} canciones',
                      style: VibeText.labelSm(
                        color: VibeColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: VibeColors.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturedRelease extends StatelessWidget {
  const _FeaturedRelease();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Lanzamiento destacado',
                style: VibeText.headlineSm(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: VibeColors.tertiaryContainer.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(VibeRadius.full),
              ),
              child: Text(
                'EXCLUSIVO',
                style: VibeText.labelSm(
                  color: VibeColors.tertiary,
                ).copyWith(letterSpacing: 1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(VibeRadius.lg),
          child: SizedBox(
            height: 260,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  VibeRepository.featuredCover,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: VibeColors.surfaceContainerHigh),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        VibeColors.surface.withValues(alpha: 0.85),
                        VibeColors.surface,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: VibeColors.secondary.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                VibeRadius.full,
                              ),
                            ),
                            child: Text(
                              'NUEVO SINGLE',
                              style: VibeText.labelSm(
                                color: VibeColors.secondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '• Calidad Master Studio',
                            style: VibeText.bodySm(
                              color: VibeColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Illusion',
                        style: VibeText.headlineMd().copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Dua Lipa — Radical Optimism',
                        style: VibeText.bodyMd(
                          color: VibeColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  context.read<PlayerController>().playFromList(
                                    VibeRepository.trending.first,
                                    VibeRepository.trending,
                                  ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: VibeColors.brandGradient,
                                  borderRadius: BorderRadius.circular(
                                    VibeRadius.full,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: VibeColors.glowViolet,
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Escuchar ahora',
                                      style: VibeText.labelLg(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _RoundAction(icon: Icons.add),
                          const SizedBox(width: 8),
                          _RoundAction(icon: Icons.share_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  const _RoundAction({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainerHighest.withValues(alpha: 0.8),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: VibeColors.onSurface, size: 22),
    );
  }
}

class _TrendingList extends StatelessWidget {
  const _TrendingList();

  @override
  Widget build(BuildContext context) {
    final songs = VibeRepository.trending;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Listas populares hoy', style: VibeText.headlineSm()),
                  const SizedBox(height: 2),
                  Text(
                    'Las canciones más reproducidas en tiempo real',
                    style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(
              'Ver ranking',
              style: VibeText.labelMd(color: VibeColors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassCard(
          radius: VibeRadius.lg,
          opacity: 0.4,
          padding: const EdgeInsets.all(6),
          child: Column(
            children: List.generate(
              songs.length,
              (i) => _TrendingRow(song: songs[i], rank: i + 1),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrendingRow extends StatelessWidget {
  final Song song;
  final int rank;
  const _TrendingRow({required this.song, required this.rank});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerController>();
    final isCurrent = player.current.id == song.id;
    return GestureDetector(
      onTap: () => context.read<PlayerController>().playFromList(
        song,
        VibeRepository.trending,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: isCurrent
              ? VibeColors.surfaceContainerHigh.withValues(alpha: 0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(VibeRadius.md),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              child: isCurrent
                  ? const Center(child: EqualizerBars(height: 16))
                  : Text(
                      '$rank',
                      textAlign: TextAlign.center,
                      style: VibeText.labelMd(
                        color: VibeColors.onSurfaceVariant,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
            ),
            const SizedBox(width: 8),
            CoverArt(url: song.coverUrl, size: 46),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.labelLg(
                      color: isCurrent
                          ? VibeColors.secondary
                          : VibeColors.onSurface,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${song.artist} • ${song.album}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () =>
                  context.read<PlayerController>().toggleSongLike(song.id),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  player.isSongLiked(song.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 20,
                  color: player.isSongLiked(song.id)
                      ? VibeColors.secondary
                      : VibeColors.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(
              width: 36,
              height: 36,
              child: Icon(
                Icons.more_vert,
                size: 20,
                color: VibeColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
