import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/screens/letter_sent_screen.dart';
import 'package:mail_tracking_service/screens/login_screen.dart';
import 'package:mail_tracking_service/screens/register_screen.dart';
import 'package:mail_tracking_service/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:mail_tracking_service/widgets/main_shell.dart';
import 'package:mail_tracking_service/screens/home_screen.dart';
import 'package:mail_tracking_service/screens/profile_screen.dart';
import 'package:mail_tracking_service/screens/change_password_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

// Навігація по різних сторінках застосунку
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/register', builder: (c, s) => const RegisterScreen()),
    GoRoute(path: '/forgot-pass', builder: (c, s) => const ForgotPasswordScreen()),
    GoRoute(path: '/letter-sent', builder: (c, s) => const LetterSentScreen()),
    ShellRoute(
      builder: (c, s, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
        GoRoute(
          path: '/parcels',
          builder: (c, s) => const Center(child: Text('Мої посилки: скоро')),
        ),
        GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
        GoRoute(path: '/profile/change-password', builder: (c, s) => const ChangePasswordScreen()),
        GoRoute(
          path: '/help',
          builder: (c, s) => const Center(child: Text('Довідка: скоро')),
        ),
      ],
    ),
  ],
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