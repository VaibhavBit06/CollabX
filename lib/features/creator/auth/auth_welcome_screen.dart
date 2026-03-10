import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AuthWelcomeScreen extends StatefulWidget {
  const AuthWelcomeScreen({super.key});

  @override
  State<AuthWelcomeScreen> createState() => _AuthWelcomeScreenState();
}

class _AuthWelcomeScreenState extends State<AuthWelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _goToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.signUp);
  }

  void _goToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF050505),
              AuraColors.sage.withOpacity(0.03),
              const Color(0xFF050505),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Header with close and accent
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AuraColors.textPrimary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AuraColors.sage.withOpacity(0.2),
                                AuraColors.sage.withOpacity(0.5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 56),
                    // Welcome text with emphasis
                    Text(
                      'Welcome to the',
                      style: TextStyle(
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.w200,
                        color: AuraColors.textPrimary.withOpacity(0.9),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          AuraColors.sage,
                          AuraColors.sage.withOpacity(0.7),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'inner circle.',
                        style: TextStyle(
                          fontSize: 36,
                          height: 1.1,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: AuraColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A curated space for the world\'s most influential voices.',
                      style: TextStyle(
                        color: AuraColors.chrome.withOpacity(0.5),
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Auth buttons with staggered animation
                    _AnimatedAuthButton(
                      delay: 200,
                      label: 'Continue with Google',
                      icon: Icons.g_mobiledata_rounded,
                      onTap: () => _goToSignUp(context),
                    ),
                    const SizedBox(height: 14),
                    _AnimatedAuthButton(
                      delay: 300,
                      label: 'Continue with Apple',
                      icon: Icons.apple,
                      onTap: () => _goToSignUp(context),
                    ),
                    const SizedBox(height: 14),
                    _AnimatedAuthButton(
                      delay: 400,
                      label: 'Email or Phone',
                      icon: Icons.alternate_email_rounded,
                      onTap: () => _goToSignUp(context),
                      isPrimary: true,
                    ),
                    const Spacer(),
                    // Footer with login link
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Are you a Brand?',
                                style: TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w300,
                                  color: AuraColors.textPrimary.withOpacity(0.4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(AppRoutes.brandSignUp),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AuraColors.sage.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AuraColors.sage.withOpacity(0.2),
                                    ),
                                  ),
                                  child: Text(
                                    'Join as Brand',
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600,
                                      color: AuraColors.sage,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already a member?',
                                style: TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w300,
                                  color: AuraColors.textPrimary.withOpacity(0.4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _goToLogin(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AuraColors.obsidian,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AuraColors.chrome.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600,
                                      color: AuraColors.chrome,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'By joining, you agree to our Terms of Access and Privacy Protocol.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.5,
                              height: 1.6,
                              color: AuraColors.textPrimary.withOpacity(0.25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedAuthButton extends StatefulWidget {
  const _AnimatedAuthButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.delay = 0,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final int delay;
  final bool isPrimary;

  @override
  State<_AnimatedAuthButton> createState() => _AnimatedAuthButtonState();
}

class _AnimatedAuthButtonState extends State<_AnimatedAuthButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: widget.isPrimary
                    ? AuraColors.sage.withOpacity(0.15)
                    : const Color.fromRGBO(18, 18, 20, 0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.isPrimary
                      ? AuraColors.sage.withOpacity(0.4)
                      : AuraColors.textPrimary.withOpacity(0.08),
                  width: widget.isPrimary ? 1.5 : 1,
                ),
                boxShadow: widget.isPrimary
                    ? [
                        BoxShadow(
                          color: AuraColors.sage.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    widget.icon,
                    size: 22,
                    color: widget.isPrimary
                        ? AuraColors.sage
                        : AuraColors.textPrimary.withOpacity(0.7),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.label.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.8,
                      fontWeight: widget.isPrimary ? FontWeight.w500 : FontWeight.w400,
                      color: widget.isPrimary
                          ? AuraColors.sage
                          : AuraColors.textPrimary.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
