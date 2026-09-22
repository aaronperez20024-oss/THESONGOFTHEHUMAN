import 'package:flutter/material.dart';
import '../models/models.dart';

/// Repositorio de contenido de demostración para Vibe.
/// Todas las portadas son imágenes remotas; la cuadrícula de géneros
/// usa gradientes de marca combinados con una miniatura (como en el diseño).
class VibeRepository {
  VibeRepository._();

  // ── Portadas reutilizables ───────────────────────────────────────
  static const _c1 = 'https://sspark.genspark.ai/i/QtSlx9d7QwNO24Zd?width=2560';
  static const _c2 = 'https://sspark.genspark.ai/i/sFQ3BBbduhi1ABQD?width=2560';
  static const _c3 = 'https://sspark.genspark.ai/i/PuEJkOdKXkirXCcZ?width=2560';
  static const _c4 = 'https://sspark.genspark.ai/i/58Mwi9OeANpRGBpe?width=2560';
  static const _c5 = 'https://sspark.genspark.ai/i/D7HjzSJ9VI0lT99h?width=2560';
  static const _c6 = 'https://sspark.genspark.ai/i/aWr8ChoKGEMEeRom?width=2560';
  static const _c7 = 'https://sspark.genspark.ai/i/ipXmb0ECz3XC25Pi?width=2560';
  static const _c8 = 'https://sspark.genspark.ai/i/Cb99mZXgtjhgL3Hd?width=2560';
  static const _c9 = 'https://sspark.genspark.ai/i/x7w4uBglWp43YaK5?width=2560';
  static const _c10 =
      'https://sspark.genspark.ai/i/dPxdBJdxPFTmy0ux?width=2560';
  static const _c11 =
      'https://sspark.genspark.ai/i/OkQDQSlc7wRD3GF6?width=2560';
  static const _c12 =
      'https://sspark.genspark.ai/i/aXkHEZjNwuxRunoP?width=2560';
  static const _c13 =
      'https://sspark.genspark.ai/i/HufVxkoiKpJWI7wK?width=2560';
  static const _c14 =
      'https://sspark.genspark.ai/i/9aoJnvUVkHzlSUPh?width=2560';
  static const _c15 =
      'https://sspark.genspark.ai/i/YsXkMMCS9cM6AmBW?width=2560';

  /// Retrato de usuario (productor con auriculares)
  static const profileImage = _c1;

  /// Lanzamiento destacado (hero)
  static const featuredCover = _c2;

  // ── Escuchado recientemente ──────────────────────────────────────
  static const List<Playlist> recent = [
    Playlist(
      id: 'r1',
      title: 'After Hours',
      subtitle: 'The Weeknd',
      coverUrl: _c3,
      trackCount: 14,
      kind: PlaylistKind.album,
      accentColors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
    ),
    Playlist(
      id: 'r2',
      title: 'Synthwave Dreams',
      subtitle: 'Vibe Collective',
      coverUrl: _c4,
      trackCount: 32,
      kind: PlaylistKind.playlist,
      accentColors: [Color(0xFF4CD7F6), Color(0xFFA078FF)],
    ),
    Playlist(
      id: 'r3',
      title: 'Chill Lofi Beats',
      subtitle: 'Study & Relax',
      coverUrl: _c5,
      trackCount: 120,
      kind: PlaylistKind.playlist,
    ),
    Playlist(
      id: 'r4',
      title: 'Top 50 España',
      subtitle: 'Tendencias',
      coverUrl: _c6,
      trackCount: 50,
      kind: PlaylistKind.playlist,
      accentColors: [Color(0xFFF751A1), Color(0xFFA078FF)],
    ),
    Playlist(
      id: 'r5',
      title: 'Cyberpunk Neon',
      subtitle: 'Bass Boosted',
      coverUrl: _c7,
      trackCount: 44,
      kind: PlaylistKind.playlist,
    ),
    Playlist(
      id: 'r6',
      title: 'Acoustic Morning',
      subtitle: 'Folk & Soul',
      coverUrl: _c8,
      trackCount: 28,
      kind: PlaylistKind.playlist,
    ),
  ];

  // ── Hecho para ti (mixes) ────────────────────────────────────────
  static const List<Playlist> madeForYou = [
    Playlist(
      id: 'm1',
      title: 'Daily Mix 1',
      subtitle: 'Fred again.., Bonobo, Moderat, Caribou y más joyas indie',
      coverUrl: _c9,
      trackCount: 50,
      kind: PlaylistKind.mix,
      badge: 'Mix Diario',
      accentColors: [Color(0xFF03B5D3), Color(0xFFA078FF)],
    ),
    Playlist(
      id: 'm2',
      title: 'Descubrimiento Semanal',
      subtitle: 'Tus nuevos favoritos seleccionados cada lunes para tus oídos',
      coverUrl: _c10,
      trackCount: 30,
      kind: PlaylistKind.mix,
      badge: 'Tu radar nuevo',
      accentColors: [Color(0xFFF751A1), Color(0xFFA078FF)],
    ),
    Playlist(
      id: 'm3',
      title: 'Radar de Novedades',
      subtitle: 'Sigue los lanzamientos frescos de los artistas que sigues',
      coverUrl: _c11,
      trackCount: 30,
      kind: PlaylistKind.mix,
      badge: 'Estrenos',
      accentColors: [Color(0xFF4CD7F6), Color(0xFF8B5CF6)],
    ),
  ];

  // ── Listas populares hoy ─────────────────────────────────────────
  static const List<Song> trending = [
    Song(
      id: 's1',
      title: 'Midnight City',
      artist: 'M83',
      album: 'Hurry Up, We\'re Dreaming',
      coverUrl: _c12,
      duration: Duration(minutes: 4, seconds: 3),
      genre: 'Synthwave',
      isHiRes: true,
    ),
    Song(
      id: 's2',
      title: 'Starboy',
      artist: 'The Weeknd, Daft Punk',
      album: 'Starboy',
      coverUrl: _c13,
      duration: Duration(minutes: 3, seconds: 50),
      genre: 'R&B',
      hasDolbyAtmos: true,
    ),
    Song(
      id: 's3',
      title: 'Greedy',
      artist: 'Tate McRae',
      album: 'Think Later',
      coverUrl: _c14,
      duration: Duration(minutes: 2, seconds: 11),
      genre: 'Pop',
    ),
    Song(
      id: 's4',
      title: 'Prada',
      artist: 'cassö, RAYE, D-Block Europe',
      album: 'Prada',
      coverUrl: _c15,
      duration: Duration(minutes: 3, seconds: 12),
      genre: 'Hip-Hop',
    ),
    Song(
      id: 's5',
      title: 'LALA',
      artist: 'Myke Towers',
      album: 'LALA',
      coverUrl: _c1,
      duration: Duration(minutes: 3, seconds: 0),
      genre: 'Reggaeton',
      isHiRes: true,
    ),
  ];

  // ── Pista actualmente en reproducción (pantalla Now Playing) ─────
  static const Song nowPlaying = Song(
    id: 'np1',
    title: 'Starboy (Remix)',
    artist: 'The Weeknd, Daft Punk',
    album: 'Synthwave Night',
    coverUrl: _c2,
    duration: Duration(minutes: 3, seconds: 50),
    genre: 'Synthwave',
    isHiRes: true,
    hasDolbyAtmos: true,
    lyrics:
        'House so empty, need a centerpiece\n'
        '"I\'m trying to put you in the worst mood, ah..."\n'
        'P1 cleaner than your church shoes, ah\n'
        'Milli point two just to hurt you, ah',
  );

  // ── Tendencias ahora (carrusel explorar) ─────────────────────────
  static const List<Playlist> trends = [
    Playlist(
      id: 't1',
      title: 'Viral 50 Global',
      subtitle: 'Los hits imparables hoy',
      coverUrl: _c3,
      trackCount: 50,
      badge: 'Playlist Oficial',
      accentColors: [Color(0xFFF751A1), Color(0xFF8B5CF6)],
    ),
    Playlist(
      id: 't2',
      title: 'Verano 2025',
      subtitle: 'Ritmos cálidos de club',
      coverUrl: _c4,
      trackCount: 60,
      badge: 'En Repetición',
      accentColors: [Color(0xFF4CD7F6), Color(0xFFF751A1)],
    ),
    Playlist(
      id: 't3',
      title: 'Radar Novedades',
      subtitle: 'Descubre antes que nadie',
      coverUrl: _c5,
      trackCount: 30,
      badge: 'Estrenos',
      accentColors: [Color(0xFFA078FF), Color(0xFF4CD7F6)],
    ),
  ];

  // ── Géneros y estados de ánimo ───────────────────────────────────
  static const List<Genre> genres = [
    Genre(
      id: 'g1',
      name: 'Reggaeton & Urbano',
      coverUrl: _c6,
      gradient: [Color(0xFFD97706), Color(0xFFE11D48), Color(0xFFF751A1)],
    ),
    Genre(
      id: 'g2',
      name: 'Electrónica & Dance',
      coverUrl: _c7,
      gradient: [Color(0xFF03B5D3), Color(0xFFA078FF), Color(0xFF340080)],
    ),
    Genre(
      id: 'g3',
      name: 'Chill & Relax',
      coverUrl: _c8,
      gradient: [Color(0xFF14B8A6), Color(0xFF0E7490), Color(0xFF1E1B4B)],
    ),
    Genre(
      id: 'g4',
      name: 'Hip-Hop & Trap',
      coverUrl: _c9,
      gradient: [Color(0xFF581C87), Color(0xFF0F172A), Color(0xFF0D0D15)],
    ),
    Genre(
      id: 'g5',
      name: 'Rock & Metal',
      coverUrl: _c10,
      gradient: [Color(0xFFB91C1C), Color(0xFF450A0A), Color(0xFF0D0D15)],
    ),
    Genre(
      id: 'g6',
      name: 'Podcasts & Charlas',
      coverUrl: _c11,
      gradient: [Color(0xFF059669), Color(0xFF134E4A), Color(0xFF172554)],
    ),
    Genre(
      id: 'g7',
      name: 'Enfoque & Estudio',
      coverUrl: _c12,
      gradient: [Color(0xFF0EA5E9), Color(0xFF4F46E5), Color(0xFF6B21A8)],
    ),
    Genre(
      id: 'g8',
      name: 'Para Entrenar',
      coverUrl: _c13,
      gradient: [Color(0xFFA3E635), Color(0xFFF59E0B), Color(0xFFEA580C)],
    ),
  ];

  static const List<String> filterPills = [
    'Todos',
    'Electrónica',
    'Hip-Hop',
    'Pop Urbano',
    'Rock',
    'Indie',
    'Lofi',
  ];

  static const List<String> libraryFilters = [
    'Todos',
    'Playlists',
    'Artistas',
    'Álbumes',
    'Descargados',
    'Podcasts',
  ];

  static const List<String> moods = [
    'Música para concentrarse',
    'Chillout',
    'Entrenamiento',
    'Fiesta Club',
  ];

  // ── Tu Biblioteca: elementos ─────────────────────────────────────
  static const List<Playlist> library = [
    Playlist(
      id: 'l1',
      title: 'Synthwave & Retrowave 80s',
      subtitle: 'Playlist • Por Alex Rivera • 84 canciones',
      coverUrl: _c14,
      trackCount: 84,
      curator: 'Alex Rivera',
      kind: PlaylistKind.playlist,
      isOffline: true,
      accentColors: [Color(0xFF4CD7F6), Color(0xFF8B5CF6)],
    ),
    Playlist(
      id: 'l2',
      title: 'Lofi Beats para Programar',
      subtitle: 'Curada por Vibe • 140 canciones',
      coverUrl: _c15,
      trackCount: 140,
      curator: 'Vibe',
      kind: PlaylistKind.playlist,
    ),
    Playlist(
      id: 'l3',
      title: 'Daft Punk',
      subtitle: 'Artista • 4.2M oyentes mensuales',
      coverUrl: _c1,
      trackCount: 0,
      curator: 'Daft Punk',
      kind: PlaylistKind.artist,
      isFollowing: true,
      accentColors: [Color(0xFFF751A1), Color(0xFFA078FF)],
    ),
    Playlist(
      id: 'l4',
      title: 'After Hours (Deluxe)',
      subtitle: 'Álbum • The Weeknd • 17 canciones',
      coverUrl: _c2,
      trackCount: 17,
      curator: 'The Weeknd',
      kind: PlaylistKind.album,
    ),
    Playlist(
      id: 'l5',
      title: 'Techno Bunker Underground',
      subtitle: 'Playlist • 62 canciones • 12.4k me gusta',
      coverUrl: _c3,
      trackCount: 62,
      curator: 'Vibe',
      kind: PlaylistKind.playlist,
      accentColors: [Color(0xFFEF4444), Color(0xFF1F1F27)],
    ),
  ];
}
