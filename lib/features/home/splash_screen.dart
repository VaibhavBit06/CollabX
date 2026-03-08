import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/services/auth_service.dart';
import 'package:aura_influencer_portfolio/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    _decideNavigation();
  }

  Future<void> _decideNavigation() async {
    const Duration minSplashDuration = Duration(milliseconds: 2200);
    final Stopwatch stopwatch = Stopwatch()..start();

    // Ask the auth layer who (if anyone) is currently signed in.
    final user = await AuthService.instance.getCurrentUser();

    final Duration elapsed = stopwatch.elapsed;
    if (elapsed < minSplashDuration) {
      await Future<void>.delayed(minSplashDuration - elapsed);
    }
    if (!mounted) return;

    if (user == null) {
      // Not logged in → onboarding / welcome.
      Navigator.of(context).pushReplacementNamed(AppRoutes.authWelcome);
    } else if (user.role == UserRole.admin) {
      // Admin role → admin dashboard.
      Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
    } else {
      // Default signed‑in path → creator home dashboard.
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: Stack(
        children: <Widget>[
          const _StudioBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                const Spacer(),
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _AuraLogoGlow(animation: _controller),
                      const SizedBox(height: 24),
                      const _AuraWordmark(),
                    ],
                  ),
                ),
                const Spacer(),
                const _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudioBackground extends StatelessWidget {
  const _StudioBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.2,
          colors: <Color>[
            AuraColors.obsidian,
            AuraColors.midnight,
          ],
        ),
      ),
    );
  }
}

class _AuraLogoGlow extends StatelessWidget {
  const _AuraLogoGlow({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final double size = 96;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double t = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ).value;
            return Container(
              width: size * (1.6 + 0.1 * t),
              height: size * (1.6 + 0.1 * t),
              decoration: BoxDecoration(
                color: AuraColors.chrome.withOpacity(0.04 + 0.02 * t),
                borderRadius: BorderRadius.circular(999),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AuraColors.chrome.withOpacity(0.08),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),
            );
          },
        ),
        Icon(
          Icons.blur_on,
          size: size,
          color: const Color(0xFFE5E7EB),
        ),
      ],
    );
  }
}

class _AuraWordmark extends StatelessWidget {
  const _AuraWordmark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFF3F4F6),
                Color(0xFF9CA3AF),
                Color(0xFFFFFFFF),
                Color(0xFF9CA3AF),
                Color(0xFFD1D5DB),
              ],
              stops: <double>[0.0, 0.45, 0.5, 0.55, 1.0],
            ).createShader(bounds);
          },
          child: Text(
            'CollabX',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              letterSpacing: 8,
              fontSize: 36,
              color: AuraColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 1,
          color: AuraColors.chrome.withOpacity(0.2),
        ),
        const SizedBox(height: 10),
        Text(
          'INFLUENCER MARKETPLACE',
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 5,
            fontWeight: FontWeight.w300,
            color: AuraColors.sage.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Powered by CollabX',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              fontWeight: FontWeight.w200,
              color: AuraColors.textPrimary.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _dot(0.2),
              const SizedBox(width: 6),
              _dot(0.4),
              const SizedBox(width: 6),
              _dot(0.2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(double opacity) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: AuraColors.chrome.withOpacity(opacity),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
