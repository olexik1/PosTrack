import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/screens/letter_sent_screen.dart';
import 'package:mail_tracking_service/screens/login_screen.dart';
import 'package:mail_tracking_service/screens/register_screen.dart';
import 'package:mail_tracking_service/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/main_shell.dart';
import 'package:mail_tracking_service/screens/home_screen.dart';
import 'package:mail_tracking_service/screens/profile_screen.dart';
import 'package:mail_tracking_service/screens/parcels_screen.dart';
import 'package:mail_tracking_service/screens/change_password_screen.dart';
import 'package:mail_tracking_service/screens/parcel_details_screen.dart';
import 'package:mail_tracking_service/screens/help_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mail_tracking_service/utils/go_router_refresh_stream.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

// Навігація по різних сторінках застосунку
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/register', builder: (c, s) => const RegisterScreen()),
    GoRoute(path: '/forgot-pass', builder: (c, s) => const ForgotPasswordScreen()),
    GoRoute(
      path: '/letter-sent',
      builder: (c, s) => LetterSentScreen(email: s.uri.queryParameters['email']),
    ),
    ShellRoute(
      builder: (c, s, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
        GoRoute(
          path: '/parcels',
          builder: (c, s) => const ParcelsScreen(),
        ),
        GoRoute(path: '/parcel-details', builder: (c, s) {
          final previousRoute = s.extra as String? ?? '/home';

          return ParcelDetailsScreen(
            previousDetailsRoute: previousRoute
          );
        }),
        GoRoute(path: '/help', builder: (c, s) => const HelpScreen()),
        GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
        GoRoute(path: '/profile/change-password', builder: (c, s) => const ChangePasswordScreen()),
        GoRoute(
          path: '/help',
          builder: (c, s) => const Center(child: Text('Довідка: скоро')),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final loggedIn = FirebaseAuth.instance.currentUser != null;
    final path = state.matchedLocation;
    const publicPaths = ['/login', '/register', '/forgot-pass', '/letter-sent'];

    if (!loggedIn && !publicPaths.contains(path)) return '/login';
    if (loggedIn && (path == '/login' || path == '/register')) return '/home';
    return null;
  },
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
);

String? _lastScreen;

void setupAnalyticsTracking() {
  router.routerDelegate.addListener(() {
    final currentPath =
    router.routerDelegate.currentConfiguration.uri.toString();

    if (currentPath == _lastScreen) return;

    _lastScreen = currentPath;

    analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': currentPath,
        'firebase_screen_class': currentPath,
        'debug_mode': 1,
      },
    );

    debugPrint('Analytics screen_view: $currentPath');
  });
}