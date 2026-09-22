import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/player_controller.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';
import '../widgets/common_widgets.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerController>();

    return Container(
      color: VibeColors.canvas,
      child: Stack(
        children: [
          AmbientGlow(
            color: VibeColors.primary,
            size: 300,
            alignment: Alignment.topLeft,
          ),
          const AmbientGlow(
            color: VibeColors.secondaryContainer,
            size: 320,
            alignment: Alignment(1.2, -0.2),
          ),
          const AmbientGlow(
            color: VibeColors.tertiaryContainer,
            size: 340,
            alignment: Alignment(-0.4, 1.3),
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 180),
              child: Column(
                children: [
                  _buildSubHeader(),
                  const SizedBox(height: 12),
                  _buildArtwork(context),
                  const SizedBox(height: 20),
                  _buildTrackInfo(player),
                  const SizedBox(height: 8),
                  _buildScrubber(player),
                  const SizedBox(height: 12),
                  _buildControls(player),
                  const SizedBox(height: 16),
                  _buildUtilityBar(),
                  const SizedBox(height: 20),
                  _buildLyrics(player),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader() {
    return Row(
      children: [
        _circleBtn(Icons.keyboard_arrow_down),
        Expanded(
          child: Column(
            children: [
              Text(
                'REPRODUCIENDO DESDE',
                style: VibeText.labelSm(
                  color: VibeColors.onSurfaceVariant,
                ).copyWith(letterSpacing: 1.4),
              ),
              const SizedBox(height: 2),
              Text(
                'Synthwave Night',
                style: VibeText.labelMd(
                  color: VibeColors.primary,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        _circleBtn(Icons.more_horiz),
      ],
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainer.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: VibeColors.onSurface, size: 22),
    );
  }

  Widget _buildArtwork(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final size = c.maxWidth;
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Underglow multi-cromático
              Container(
                width: size - 32,
                height: size - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(VibeRadius.lg),
                  gradient: VibeColors.playerGlowGradient,
                ),
              ),
              Container(
                width: size - 32,
                height: size - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(VibeRadius.lg),
                  gradient: VibeColors.playerGlowGradient,
                  boxShadow: [
                    BoxShadow(
                      color: VibeColors.primaryContainer.withValues(alpha: 0.4),
                      blurRadius: 40,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
              // Portada
              ClipRRect(
                borderRadius: BorderRadius.circular(VibeRadius.lg),
                child: Image.network(
                  context.watch<PlayerController>().current.coverUrl,
                  width: size - 40,
                  height: size - 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: size - 40,
                    height: size - 40,
                    color: VibeColors.surfaceContainerHighest,
                    child: const Icon(
                      Icons.music_note,
                      color: VibeColors.onSurfaceVariant,
                      size: 60,
                    ),
                  ),
                ),
              ),
              // Insignia LIVE STEREO
              Positioned(
                bottom: 28,
                left: 28,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: VibeColors.surfaceContainerLowest.withValues(
                      alpha: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(VibeRadius.full),
                  ),
                  child: Row(
                    children: [
                      const EqualizerBars(height: 12),
                      const SizedBox(width: 6),
                      Text(
                        'LIVE STEREO',
                        style: VibeText.labelSm(
                          color: VibeColors.onSurface,
                        ).copyWith(letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrackInfo(PlayerController player) {
    final song = player.current;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: VibeText.headlineLg().copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                song.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: VibeText.bodyMd(color: VibeColors.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  if (song.isHiRes)
                    _badge(
                      'Hi-Res Lossless 24-bit/96kHz',
                      VibeColors.secondary,
                      Icons.graphic_eq,
                    ),
                  if (song.hasDolbyAtmos)
                    _badge('Dolby Atmos', VibeColors.primary, null),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: player.toggleLike,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: VibeColors.surfaceContainer.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              player.isLiked ? Icons.favorite : Icons.favorite_border,
              color: player.isLiked
                  ? VibeColors.tertiaryContainer
                  : VibeColors.onSurfaceVariant,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  Widget _badge(String text, Color color, IconData? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(VibeRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: VibeText.labelSm(
              color: color,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildScrubber(PlayerController player) {
    return Column(
      children: [
        VibeScrubber(progress: player.progress, onSeek: player.seek),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              player.positionLabel,
              style: VibeText.labelMd(
                color: VibeColors.onSurfaceVariant,
              ).copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              player.remainingLabel,
              style: VibeText.labelMd(
                color: VibeColors.onSurfaceVariant,
              ).copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControls(PlayerController player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ctrlToggle(Icons.shuffle, player.isShuffle, player.toggleShuffle),
        _skipBtn(Icons.skip_previous_rounded, player.playPrevious),
        PrimaryPlayButton(
          isPlaying: player.isPlaying,
          onTap: player.togglePlay,
          size: 68,
        ),
        _skipBtn(Icons.skip_next_rounded, player.playNext),
        _ctrlToggle(Icons.repeat, player.isRepeat, player.toggleRepeat),
      ],
    );
  }

  Widget _ctrlToggle(IconData icon, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: active ? VibeColors.primary : VibeColors.onSurfaceVariant,
              size: 24,
            ),
            if (active)
              Positioned(
                bottom: 6,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: VibeColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _skipBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 52,
        height: 52,
        child: Icon(icon, color: VibeColors.onSurface, size: 38),
      ),
    );
  }

  Widget _buildUtilityBar() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: VibeColors.surfaceContainerHigh.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(VibeRadius.full),
          ),
          child: Row(
            children: [
              const Icon(Icons.airplay, size: 18, color: VibeColors.secondary),
              const SizedBox(width: 8),
              Text(
                'AirPlay · Altavoces salón',
                style: VibeText.labelMd(
                  color: VibeColors.secondary,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const Spacer(),
        _circleIcon(Icons.share_outlined),
        const SizedBox(width: 8),
        _circleIcon(Icons.queue_music),
      ],
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: VibeColors.surfaceContainerHigh.withValues(alpha: 0.8),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: VibeColors.onSurface),
    );
  }

  Widget _buildLyrics(PlayerController player) {
    final lines = player.current.lyrics?.split('\n') ?? [];
    return GlassCard(
      radius: VibeRadius.lg,
      opacity: 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lyrics_outlined,
                color: VibeColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Letras en directo',
                  style: VibeText.labelLg().copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: player.toggleLyrics,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: VibeColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(VibeRadius.full),
                  ),
                  child: Text(
                    player.lyricsExpanded ? 'CONTRAER' : 'EXPANDIR',
                    style: VibeText.labelSm(
                      color: VibeColors.primary,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < lines.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _lyricLine(lines[i], i),
            ),
        ],
      ),
    );
  }

  Widget _lyricLine(String line, int index) {
    // La línea "activa" (índice 1) se muestra con gradiente destacado
    if (index == 1) {
      return ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
          colors: [
            VibeColors.secondary,
            VibeColors.primary,
            VibeColors.tertiary,
          ],
        ).createShader(rect),
        blendMode: BlendMode.srcIn,
        child: Text(
          line,
          style: VibeText.headlineSm(
            color: Colors.white,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      );
    }
    final opacity = index == 0
        ? 0.5
        : index == 2
        ? 0.6
        : 0.3;
    return Text(
      line,
      style: VibeText.bodyMd(
        color: VibeColors.onSurfaceVariant.withValues(alpha: opacity),
      ),
    );
  }
}
