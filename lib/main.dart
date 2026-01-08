import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:riveplayer/screens/rive_list_screen.dart';
import 'package:riveplayer/screens/rive_player_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rive Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const RiveListScreen()),
    GoRoute(
      path: '/player/:fileName',
      builder: (context, state) {
        final fileName = state.pathParameters['fileName'] ?? '';
        return RivePlayerScreen(fileName: fileName);
      },
    ),
  ],
  routerNeglect: kIsWeb,
);
