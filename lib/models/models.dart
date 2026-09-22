import 'package:flutter/material.dart';

/// Una pista de música en la app Vibe.
@immutable
class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverUrl;
  final Duration duration;
  final String genre;
  final bool isHiRes;
  final bool hasDolbyAtmos;
  final String? lyrics;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.duration,
    this.genre = 'Pop',
    this.isHiRes = false,
    this.hasDolbyAtmos = false,
    this.lyrics,
  });

  String get durationLabel {
    final m = duration.inMinutes;
    final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

/// Colección de pistas: playlist, álbum o mix.
@immutable
class Playlist {
  final String id;
  final String title;
  final String subtitle;
  final String curator;
  final String coverUrl;
  final int trackCount;
  final PlaylistKind kind;
  final bool isOffline;
  final bool isFollowing;
  final List<Color> accentColors;
  final String? badge;

  const Playlist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.trackCount,
    this.curator = 'Vibe',
    this.kind = PlaylistKind.playlist,
    this.isOffline = false,
    this.isFollowing = false,
    this.accentColors = const [Color(0xFFA078FF), Color(0xFF4CD7F6)],
    this.badge,
  });
}

enum PlaylistKind { playlist, album, artist, mix, likes }

/// Un género o estado de ánimo para la cuadrícula de exploración.
@immutable
class Genre {
  final String id;
  final String name;
  final String coverUrl;
  final List<Color> gradient;

  const Genre({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.gradient,
  });
}
