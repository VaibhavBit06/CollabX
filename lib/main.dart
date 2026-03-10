import 'package:flutter/material.dart';
// Firebase disabled for local testing — uncomment when ready:
// import 'package:firebase_core/firebase_core.dart';

import 'routing/app_router.dart';
import 'theme/aura_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase disabled for local testing — uncomment when ready:
  // try {
  //   await Firebase.initializeApp();
  // } catch (e) {
  //   debugPrint('Firebase init error: $e');
  // }
  runApp(const AuraApp());
}

class AuraApp extends StatelessWidget {
  const AuraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeNotifier.instance,
      builder: (_, isDark, __) {
        return MaterialApp(
          title: 'Aura Marketplace',
          debugShowCheckedModeBanner: false,
          theme: AuraTheme.buildTheme(),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
