import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel_provider.dart';
import 'package:mail_tracking_service/router.dart';
import 'package:mail_tracking_service/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:mail_tracking_service/secrets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mail_tracking_service/models/auth_provider.dart';
import 'package:mail_tracking_service/services/auth_repository.dart';

Future<void> main() async {
    await SentryFlutter.init(
        (options) {
          options.dsn = sentryDsn;
          options.tracesSampleRate = 1.0;
      },
      appRunner: () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

        await FirebaseAnalytics.instance.logEvent(
          name: 'test_analytics',
          parameters: {
            'debug_mode': 1,
          },
        );

        await FirebaseAuth.instance.authStateChanges().first;

        setupAnalyticsTracking();

        WidgetsFlutterBinding.ensureInitialized();
        await initializeDateFormatting('uk', null);

        runApp(const MyApp());
      }
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ParcelProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AppAuthProvider(AuthRepository()),
          ),
        ],
      child: MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
