import 'package:app_26/Features/Auth/Infraestructure/Presentation/Screens/login_screen.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Screens/home_admin_screen.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Screens/home_screen.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Screens/memory_create_screen.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Screens/memory_screen.dart';
import 'package:app_26/Features/Questions/Infraestructure/Presentation/Screens/questions_screen.dart';
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
      path: "/login",
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/memory",
      builder: (context, state) => MemoryScreen(
        entity: state.extra as MemoryEntity,
      ),
    ),
    GoRoute(
      path: "/questions",
      builder: (context, state) => QuestionsScreen(
        userId: state.extra as String,
      ),
    ),
    GoRoute(
      path: "/homeAdmin",
      builder: (context, state) => const HomeAdminScreen(),
    ),
    GoRoute(
      path: "/memoryCreate",
      builder: (context, state) => MemoryCreateScreen(),
    ),
  ],
);
