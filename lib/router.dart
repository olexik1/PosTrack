import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/screens/letter_sent_screen.dart';
import 'package:mail_tracking_service/screens/login_screen.dart';
import 'package:mail_tracking_service/screens/register_screen.dart';
import 'package:mail_tracking_service/screens/forgot_password_screen.dart';

// Навігація по різних сторінках застосунку
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/register', builder: (c, s) => const RegisterScreen()),
    GoRoute(path: '/forgot-pass', builder: (c, s) => const ForgotPasswordScreen()),
    GoRoute(path: '/letter-sent', builder: (c, s) => const LetterSentScreen()),
  ],
);

