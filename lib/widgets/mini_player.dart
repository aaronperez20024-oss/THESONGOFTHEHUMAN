import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/player_controller.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';

/// Barra de reproductor persistente (frosted glass) que se ancla encima
/// de la navegación inferior. Muestra la pista actual y controles rápidos.
class MiniPlayer extends StatelessWidget {
  final VoidCallback? onExpand;
  const MiniPlayer({super.key, this.onExpand});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerController>();
    final song = player.current;

    return GestureDetector(
      onTap: onExpand,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 6),
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: VibeColors.surfaceContainerHigh.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(VibeRadius.md),
          border: Border.all(color: VibeColors.edgeLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: VibeColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(VibeRadius.md),
                  ),
                  child: const Icon(
                    Icons.album,
                    color: VibeColors.primary,
                    size: 22,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 3,
                    decoration: const BoxDecoration(
                      color: VibeColors.secondary,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(VibeRadius.md),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.labelMd().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: player.toggleLike,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  player.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: player.isLiked
                      ? VibeColors.secondary
                      : VibeColors.onSurfaceVariant,
                  size: 22,
                ),
              ),
            ),
            GestureDetector(
              onTap: player.togglePlay,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: VibeColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: VibeColors.glowViolet, blurRadius: 14),
                  ],
                ),
                child: Icon(
                  player.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: VibeColors.onPrimary,
                  size: 22,
                ),
              ),
            ),
            GestureDetector(
              onTap: player.playNext,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.skip_next,
                  color: VibeColors.onSurfaceVariant,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
