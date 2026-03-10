import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/auth_service.dart';
import 'package:aura_influencer_portfolio/shared/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
        title: Column(
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w200,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Sign in to continue',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AuraColors.chrome.withOpacity(0.5),
              ),
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AuraColors.sage.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AuraColors.sage,
              unselectedLabelColor: AuraColors.chrome.withOpacity(0.5),
              labelStyle: const TextStyle(
                fontSize: 12,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
              tabs: const <Tab>[
                Tab(text: 'PHONE'),
                Tab(text: 'EMAIL'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _PhoneLoginTab(),
          _EmailLoginTab(),
        ],
      ),
    );
  }
}

class _PhoneLoginTab extends StatefulWidget {
  @override
  State<_PhoneLoginTab> createState() => _PhoneLoginTabState();
}

class _PhoneLoginTabState extends State<_PhoneLoginTab> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;
  bool _loading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;
    setState(() {
      _loading = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _otpSent = true;
      _loading = false;
    });
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) return;
    setState(() {
      _loading = true;
    });
    try {
      await AuthService.instance.signInWithPhone(phone: _phoneController.text);
      if (!mounted) return;
      _routeByRole(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone login failed: ${e.toString().replaceAll('Exception: ', '')}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (!_otpSent) ...<Widget>[
            _Label('Phone Number'),
            const SizedBox(height: 8),
            _TextField(
              controller: _phoneController,
              hint: '+91 98765 43210',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            _PrimaryButton(
              label: 'Send OTP',
              loading: _loading,
              onPressed: _sendOtp,
            ),
          ] else ...<Widget>[
            _Label('Enter 6-digit OTP'),
            const SizedBox(height: 8),
            _TextField(
              controller: _otpController,
              hint: '000000',
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 24),
            _PrimaryButton(
              label: 'Verify & Login',
              loading: _loading,
              onPressed: _verifyOtp,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => setState(() {
                _otpSent = false;
                _otpController.clear();
              }),
              child: Text(
                'Change number',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: AuraColors.sage.withOpacity(0.8),
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Can't access number link
          _ForgotAccessWidget(
            icon: Icons.phone_disabled_outlined,
            text: "Can't access this number?",
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
          ),

          const SizedBox(height: 24),
          // Sign up link
          _AuthFooterLink(
            question: "Don't have an account?",
            actionText: 'Sign Up',
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.signUp),
          ),
        ],
      ),
    );
  }
}

class _EmailLoginTab extends StatefulWidget {
  @override
  State<_EmailLoginTab> createState() => _EmailLoginTabState();
}

class _EmailLoginTabState extends State<_EmailLoginTab> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    setState(() {
      _loading = true;
    });
    try {
      await AuthService.instance.signIn(email: email, password: password);
      if (!mounted) return;
      _routeByRole(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString().replaceAll('Exception: ', '').replaceAll('[firebase_auth/invalid-credential] ', '')}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Label('Email'),
          const SizedBox(height: 8),
          _TextField(
            controller: _emailController,
            hint: 'you@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _Label('Password'),
          const SizedBox(height: 8),
          _TextField(
            controller: _passwordController,
            hint: '••••••••',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          // Prominent forgot password
          _ForgotAccessWidget(
            icon: Icons.lock_reset_outlined,
            text: 'Forgot Password?',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
          ),
          const SizedBox(height: 24),
          _PrimaryButton(
            label: 'Login',
            loading: _loading,
            onPressed: _login,
          ),

          const SizedBox(height: 24),
          // Sign up link
          _AuthFooterLink(
            question: "Don't have an account?",
            actionText: 'Sign Up',
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.signUp),
          ),
          const SizedBox(height: 12),
          _AuthFooterLink(
            question: 'Are you a Brand?',
            actionText: 'Register here',
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.brandSignUp),
          ),
        ],
      ),
    );
  }
}

void _routeByRole(BuildContext context) {
  final user = AuthService.instance.currentUser;
  if (user == null) return;
  if (user.role == UserRole.admin) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.adminDashboard,
      (Route<dynamic> route) => false,
    );
  } else if (user.role == UserRole.brand) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.brandDashboard,
      (Route<dynamic> route) => false,
    );
  } else {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (Route<dynamic> route) => false,
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 10,
        letterSpacing: 2,
        fontWeight: FontWeight.w500,
        color: AuraColors.chrome.withOpacity(0.6),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AuraColors.chrome,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AuraColors.chrome.withOpacity(0.4),
          fontWeight: FontWeight.w200,
        ),
        filled: true,
        fillColor: AuraColors.obsidian.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AuraColors.sage),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuraColors.sage,
          foregroundColor: AuraColors.midnight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AuraColors.midnight,
                ),
              )
            : Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

// Prominent forgot password / can't access widget
class _ForgotAccessWidget extends StatelessWidget {
  const _ForgotAccessWidget({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: AuraColors.obsidian.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: AuraColors.sage.withOpacity(0.8),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w400,
                color: AuraColors.sage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Footer link for switching between login/signup
class _AuthFooterLink extends StatelessWidget {
  const _AuthFooterLink({
    required this.question,
    required this.actionText,
    required this.onTap,
  });

  final String question;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1,
            color: AuraColors.chrome.withOpacity(0.5),
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: AuraColors.sage,
              decoration: TextDecoration.underline,
              decorationColor: AuraColors.sage.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
