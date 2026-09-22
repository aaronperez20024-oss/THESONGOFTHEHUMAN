import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/vibe_theme.dart';
import 'state/player_controller.dart';
import 'widgets/root_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0D0D15),
    ),
  );
  runApp(const VibeApp());
}

class VibeApp extends StatefulWidget {
  const VibeApp({super.key});

  @override
  State<VibeApp> createState() => _VibeAppState();
}

class _VibeAppState extends State<VibeApp> {
  late final PlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PlayerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibe',
      debugShowCheckedModeBanner: false,
      theme: VibeTheme.dark,
      home: RootShell(controller: _controller),
    );
  }
}
