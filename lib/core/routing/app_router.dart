import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habittracker/core/services/auth_provider.dart';
import 'package:habittracker/features/auth/presentation/auth_screen.dart';
import 'package:habittracker/features/habits/presentation/screens/add_edit_habit_screen.dart';
import 'package:habittracker/features/home/presentation/main_wrapper_screen.dart';
import 'package:habittracker/features/onboarding/presentation/onboarding_screen.dart';
import 'package:habittracker/features/splash/presentation/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.isLoggedIn;
      final location = state.matchedLocation;
      final isPublicRoute = location == '/splash' ||
          location == '/onboarding' ||
          location == '/auth';

      if (!isLoggedIn && !isPublicRoute) return '/auth';

      if (isLoggedIn && (location == '/auth' || location == '/onboarding')) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainWrapperScreen(),
      ),
      GoRoute(
        path: '/habit/new',
        builder: (context, state) => const AddEditHabitScreen(),
      ),
      GoRoute(
        path: '/habit/:id',
        builder: (context, state) => AddEditHabitScreen(
          habitId: state.pathParameters['id'],
        ),
      ),
    ],
  );
});
