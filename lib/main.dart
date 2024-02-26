import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:jaldindi/Auth/auth_service.dart';
import 'package:jaldindi/Theme/theme_data.dart';
import 'package:upgrader/upgrader.dart';

import 'Internet/connectivity.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterConfig.loadEnvVariables();
  if (!kDebugMode) {
    if (!kIsWeb) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
    );
  }
  runApp(
    MaterialApp(
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.system,
      home: const MainPage(),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return !kDebugMode
        ? kIsWeb
            ? AuthService().handleAuthState()
            : UpgradeAlert(
                showReleaseNotes: false,
                showLater: false,
                showIgnore: false,
                canDismissDialog: false,
                upgrader: Upgrader(
                  durationUntilAlertAgain: const Duration(days: 1),
                ),
                child: checkTheConnectivity(),
              )
        : AuthService().handleAuthState();
  }
}
