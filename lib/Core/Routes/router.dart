import 'package:app_26/Features/Home/Infraestructure/Presentation/Screens/home_screen.dart';
import 'package:app_26/Features/Splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/splash",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
