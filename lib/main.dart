import 'package:flutter/material.dart';

import 'routing/app_router.dart';
import 'theme/aura_theme.dart';

void main() {
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

