import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/vibe_repository.dart';
import '../models/models.dart';

/// Estado global de la reproducción de Vibe.
/// Simula una reproducción real: avanza el progreso con un [Timer] y
/// permite controlar play/pausa, salto, aleatorio y repetición.
class PlayerController extends ChangeNotifier {
  Song _current = VibeRepository.nowPlaying;
  bool _isPlaying = true;
  bool _isShuffle = true;
  bool _isRepeat = false;
  bool _isLiked = true;
  Duration _position = const Duration(minutes: 2, seconds: 14);
  final Set<String> _likedIds = {'np1', 's1'};
  double _volume = 0.7;
  bool _lyricsExpanded = false;

  Timer? _ticker;

  Song get current => _current;
  bool get isPlaying => _isPlaying;
  bool get isShuffle => _isShuffle;
  bool get isRepeat => _isRepeat;
  bool get isLiked => _isLiked;
  bool get lyricsExpanded => _lyricsExpanded;
  Duration get position => _position;
  double get volume => _volume;

  double get progress {
    if (_current.duration.inMilliseconds == 0) return 0;
    return (_position.inMilliseconds / _current.duration.inMilliseconds).clamp(
      0.0,
      1.0,
    );
  }

  String get positionLabel => _fmt(_position);
  String get durationLabel => _fmt(_current.duration);
  String get remainingLabel => '-${_fmt(_current.duration - _position)}';

  PlayerController() {
    _startTicker();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPlaying) return;
      final next = _position + const Duration(seconds: 1);
      if (next >= _current.duration) {
        if (_isRepeat) {
          _position = Duration.zero;
        } else {
          playNext();
          return;
        }
      } else {
        _position = next;
      }
      notifyListeners();
    });
  }

  void togglePlay() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  void toggleLyrics() {
    _lyricsExpanded = !_lyricsExpanded;
    notifyListeners();
  }

  void toggleLike() {
    _isLiked = !_isLiked;
    if (_isLiked) {
      _likedIds.add(_current.id);
    } else {
      _likedIds.remove(_current.id);
    }
    notifyListeners();
  }

  bool isSongLiked(String id) => _likedIds.contains(id);

  void toggleSongLike(String id) {
    if (_likedIds.contains(id)) {
      _likedIds.remove(id);
    } else {
      _likedIds.add(id);
    }
    notifyListeners();
  }

  void setVolume(double v) {
    _volume = v.clamp(0.0, 1.0);
    notifyListeners();
  }

  void seek(double fraction) {
    final ms = (_current.duration.inMilliseconds * fraction.clamp(0.0, 1.0))
        .round();
    _position = Duration(milliseconds: ms);
    notifyListeners();
  }

  /// Carga una pista y comienza su reproducción.
  void play(Song song) {
    _current = song;
    _position = Duration.zero;
    _isPlaying = true;
    _isLiked = _likedIds.contains(song.id);
    notifyListeners();
  }

  /// Reproduce la lista de tendencias a partir de una pista.
  void playFromList(Song song, List<Song> list) {
    _queue = List<Song>.from(list);
    _queueIndex = _queue.indexWhere((s) => s.id == song.id);
    play(song);
  }

  List<Song> _queue = List<Song>.from(VibeRepository.trending);
  int _queueIndex = 0;

  void playNext() {
    if (_queue.isEmpty) return;
    if (_isShuffle) {
      _queueIndex = (DateTime.now().microsecond) % _queue.length;
    } else {
      _queueIndex = (_queueIndex + 1) % _queue.length;
    }
    play(_queue[_queueIndex]);
  }

  void playPrevious() {
    if (_queue.isEmpty) return;
    _queueIndex = (_queueIndex - 1 + _queue.length) % _queue.length;
    play(_queue[_queueIndex]);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
