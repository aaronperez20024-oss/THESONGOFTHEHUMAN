import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/vibe_repository.dart';
import '../models/models.dart';
import '../state/player_controller.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';
import '../widgets/common_widgets.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ProfileCard(),
          const SizedBox(height: 16),
          _buildFilterPills(),
          const SizedBox(height: 14),
          _buildToolbar(),
          const SizedBox(height: 16),
          const _LikesSpotlight(),
          const SizedBox(height: 20),
          _buildLibraryList(),
          const SizedBox(height: 24),
          const _ExperienceSection(),
        ],
      ),
    );
  }

  Widget _buildFilterPills() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: VibeRepository.libraryFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final active = i == _filterIndex;
          final isOffline = VibeRepository.libraryFilters[i] == 'Descargados';
          return GestureDetector(
            onTap: () => setState(() => _filterIndex = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: active
                    ? VibeColors.onSurface
                    : VibeColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(VibeRadius.full),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  if (isOffline) ...[
                    Icon(
                      Icons.download_done,
                      size: 14,
                      color: active ? VibeColors.surface : VibeColors.secondary,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    VibeRepository.libraryFilters[i],
                    style: VibeText.labelMd(
                      color: active
                          ? VibeColors.surface
                          : VibeColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                VibeColors.primaryContainer,
                VibeColors.secondaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(VibeRadius.full),
            boxShadow: [
              BoxShadow(color: VibeColors.glowViolet, blurRadius: 18),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.add,
                size: 18,
                color: VibeColors.onPrimaryContainer,
              ),
              const SizedBox(width: 6),
              Text(
                'Nueva playlist',
                style: VibeText.labelMd(
                  color: VibeColors.onPrimaryContainer,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const Spacer(),
        _miniCircle(Icons.search),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: VibeColors.surfaceContainer,
            borderRadius: BorderRadius.circular(VibeRadius.full),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.swap_vert,
                size: 16,
                color: VibeColors.secondary,
              ),
              const SizedBox(width: 4),
              Text('Recientes', style: VibeText.labelMd()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniCircle(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: VibeColors.surfaceContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: VibeColors.onSurfaceVariant),
    );
  }

  Widget _buildLibraryList() {
    final items = VibeRepository.library;
    return Column(
      children: List.generate(items.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: _LibraryItem(item: items[i], index: i),
        );
      }),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainer.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(VibeRadius.lg),
        border: Border.all(color: VibeColors.edgeSubtle),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      VibeColors.primary,
                      VibeColors.tertiaryContainer,
                      VibeColors.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(color: VibeColors.glowViolet, blurRadius: 16),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipOval(
                      child: Image.network(
                        VibeRepository.profileImage,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 64,
                          height: 64,
                          color: VibeColors.surfaceContainerHighest,
                          child: const Icon(Icons.person, size: 32),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Alex Rivera',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: VibeText.headlineSm(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              VibeRadius.full,
                            ),
                            color: VibeColors.secondary.withValues(alpha: 0.15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.workspace_premium,
                                size: 12,
                                color: VibeColors.secondary,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Hi-Fi Lossless',
                                style: VibeText.labelSm(
                                  color: VibeColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Explorador sónico • Nivel 14 Audiophile',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: VibeText.bodySm(
                        color: VibeColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const EqualizerBars(height: 12),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Escuchando Synthwave & Retrowave',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: VibeText.labelSm(
                              color: VibeColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: VibeColors.surfaceContainerHigh.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.tune,
                  size: 20,
                  color: VibeColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: VibeColors.surfaceContainerLowest.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(VibeRadius.md),
            ),
            child: Row(
              children: [
                _stat('482', 'CANCIONES', VibeColors.primary),
                _stat('34', 'PLAYLISTS', VibeColors.secondary),
                _stat('18', 'ARTISTAS', VibeColors.tertiary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: VibeText.headlineSm(
              color: color,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: VibeText.labelSm(
              color: VibeColors.onSurfaceVariant,
            ).copyWith(letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}

class _LikesSpotlight extends StatelessWidget {
  const _LikesSpotlight();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PlayerController>().playFromList(
        VibeRepository.trending.first,
        VibeRepository.trending,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: VibeColors.likeCardGradient,
          borderRadius: BorderRadius.circular(VibeRadius.lg),
          boxShadow: [
            BoxShadow(
              color: VibeColors.glowViolet,
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [VibeColors.primary, VibeColors.tertiary],
                ),
                borderRadius: BorderRadius.circular(VibeRadius.md),
              ),
              child: const Icon(
                Icons.favorite,
                color: VibeColors.onPrimary,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.push_pin,
                        size: 14,
                        color: VibeColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Tus me gusta',
                        style: VibeText.headlineSm(
                          color: const Color(0xFF23005C),
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '328 canciones guardadas • Auto-sync',
                    style: VibeText.bodySm(color: const Color(0xFFE9DDFF)),
                  ),
                ],
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF23005C),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: VibeColors.primaryContainer,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryItem extends StatelessWidget {
  final Playlist item;
  final int index;
  const _LibraryItem({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final isArtist = item.kind == PlaylistKind.artist;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(VibeRadius.md),
      ),
      child: Row(
        children: [
          CoverArt(url: item.coverUrl, size: 56, circle: isArtist),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: VibeText.labelLg().copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isArtist) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified,
                        size: 15,
                        color: VibeColors.secondary,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    if (item.isOffline) ...[
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: VibeColors.secondary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 10,
                          color: VibeColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: VibeText.bodySm(
                          color: item.subtitle.contains('Curada por Vibe')
                              ? VibeColors.secondary
                              : VibeColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (item.isFollowing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: VibeColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(VibeRadius.full),
              ),
              child: Text('Siguiendo', style: VibeText.labelSm()),
            )
          else
            const Icon(Icons.more_vert, size: 20, color: VibeColors.outline),
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'TU EXPERIENCIA VIBE',
                style: VibeText.labelMd(
                  color: VibeColors.onSurfaceVariant,
                ).copyWith(letterSpacing: 1),
              ),
            ),
            Text(
              'Actualizado hoy',
              style: VibeText.labelSm(color: VibeColors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _experienceCard(
                icon: Icons.auto_awesome,
                iconBg: VibeColors.tertiaryContainer,
                iconFg: VibeColors.onTertiary,
                title: 'Vibe Wrapped',
                subtitle: 'Tu año en 34,210 minutos',
                subtitleColor: VibeColors.tertiary,
                action: 'Revivir ahora',
                actionColor: VibeColors.onSurface,
                gradient: VibeColors.wrappedGradient,
                isArrow: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _experienceCard(
                icon: Icons.cloud_done,
                iconBg: VibeColors.secondaryContainer,
                iconFg: VibeColors.onSecondaryContainer,
                title: 'Bóveda Offline',
                subtitle: '2.4 GB • Calidad Hi-Res Flac',
                subtitleColor: VibeColors.onSurfaceVariant,
                action: 'Gestionar archivos',
                actionColor: VibeColors.secondary,
                gradient: const LinearGradient(
                  colors: [Color(0xFF292932), Color(0xFF1F1F27)],
                ),
                isArrow: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _experienceCard({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String title,
    required String subtitle,
    required Color subtitleColor,
    required String action,
    required Color actionColor,
    required Gradient gradient,
    required bool isArrow,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(VibeRadius.lg),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: iconFg),
          ),
          const SizedBox(height: 10),
          Text(title, style: VibeText.headlineSm().copyWith(fontSize: 17)),
          const SizedBox(height: 4),
          Text(subtitle, style: VibeText.bodySm(color: subtitleColor)),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(action, style: VibeText.labelSm(color: actionColor)),
              const SizedBox(width: 4),
              Icon(
                isArrow ? Icons.arrow_forward : Icons.chevron_right,
                size: 14,
                color: actionColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
