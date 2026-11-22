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
import 'package:mail_tracking_service/screens/parcel_form_screen.dart';
import 'package:mail_tracking_service/widgets/app_snack_bar.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:provider/provider.dart';

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
        GoRoute(
          path: '/parcels/new',
          builder: (c, s) => ParcelFormScreen(
            onSubmit: (v) {
              c.read<ParcelProvider>().addFromForm(v);
              ScaffoldMessenger.of(c)
                ..hideCurrentSnackBar()
                ..showSnackBar(AppSnackBar.success('Посилку додано'));
              c.go('/parcels');
            },
          ),
        ),
        GoRoute(path: '/parcels/:id', builder: (c, s) {
          final strId = s.pathParameters['id'];
          final intId = strId != null ? int.tryParse(strId) : null;

          return ParcelDetailsScreen(
            previousDetailsRoute: '/parcels',
            parcelId: intId
          );
        }),
        GoRoute(
          path: '/parcels/:id/edit',
          builder: (c, s) {
            final id = s.pathParameters['id']!;
            final parcel = c.read<ParcelProvider>().byId(id);
            if (parcel == null) {
              return const Center(child: Text('Посилку не знайдено'));
            }
            return ParcelFormScreen(
              initial: parcel,
              onSubmit: (v) {
                c.read<ParcelProvider>().updateFromForm(id, v);
                ScaffoldMessenger.of(c)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(AppSnackBar.success('Зміни збережено'));
                c.go('/parcels/$id');
              },
            );
          },
        ),
        GoRoute(path: '/help', builder: (c, s) => const HelpScreen()),
        GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
        GoRoute(path: '/profile/change-password', builder: (c, s) => const ChangePasswordScreen()),
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