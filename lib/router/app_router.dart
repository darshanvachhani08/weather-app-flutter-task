import 'package:go_router/go_router.dart';
import '../features/weather/presentation/pages/home_page.dart';
import '../features/weather/presentation/pages/map_page.dart';
import '../features/weather/presentation/pages/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String map = '/map';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: home, builder: (context, state) => const HomePage()),
      GoRoute(path: map, builder: (context, state) => const MapPage()),
    ],
  );
}
