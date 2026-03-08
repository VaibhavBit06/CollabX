import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
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
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w200,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Join the inner circle',
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
          _PhoneSignUpTab(),
          _EmailSignUpTab(),
        ],
      ),
    );
  }
}

class _PhoneSignUpTab extends StatefulWidget {
  @override
  State<_PhoneSignUpTab> createState() => _PhoneSignUpTabState();
}

class _PhoneSignUpTabState extends State<_PhoneSignUpTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    if (name.isEmpty || phone.isEmpty) return;
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

  Future<void> _verifyAndSignUp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) return;
    setState(() {
      _loading = true;
    });
    await AuthService.instance.signUpWithPhone(phone: _phoneController.text);
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
    Navigator.of(context).pushReplacementNamed(AppRoutes.creatorTypeSelection);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (!_otpSent) ...<Widget>[
            _Label('Full Name'),
            const SizedBox(height: 8),
            _TextField(
              controller: _nameController,
              hint: 'Your name',
            ),
            const SizedBox(height: 20),
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
              label: 'Verify & Sign Up',
              loading: _loading,
              onPressed: _verifyAndSignUp,
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
            ),
            child: Text(
              'No backend: any name, phone + any 6-digit OTP.\n'
              'Then → Creator Type → Basic Profile → Creator Home.',
              style: TextStyle(
                fontSize: 10,
                height: 1.4,
                color: AuraColors.chrome.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Login link
          _AuthFooterLink(
            question: 'Already have an account?',
            actionText: 'Log In',
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}

class _EmailSignUpTab extends StatefulWidget {
  @override
  State<_EmailSignUpTab> createState() => _EmailSignUpTabState();
}

class _EmailSignUpTabState extends State<_EmailSignUpTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) return;
    if (password != confirm) return;
    setState(() {
      _loading = true;
    });
    await AuthService.instance.signUp(email: email, password: password);
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
    Navigator.of(context).pushReplacementNamed(AppRoutes.creatorTypeSelection);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Label('Full Name'),
          const SizedBox(height: 8),
          _TextField(
            controller: _nameController,
            hint: 'Your name',
          ),
          const SizedBox(height: 20),
          _Label('Email Address'),
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
          const SizedBox(height: 20),
          _Label('Confirm Password'),
          const SizedBox(height: 8),
          _TextField(
            controller: _confirmController,
            hint: '••••••••',
            obscureText: true,
          ),
          const SizedBox(height: 24),
          _PrimaryButton(
            label: 'Sign Up',
            loading: _loading,
            onPressed: _signUp,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
            ),
            child: Text(
              'No backend: use any name, email, and matching passwords.\n'
              'Then → Creator Type → Basic Profile → Creator Home.',
              style: TextStyle(
                fontSize: 10,
                height: 1.4,
                color: AuraColors.chrome.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Login link
          _AuthFooterLink(
            question: 'Already have an account?',
            actionText: 'Log In',
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
          ),
        ],
      ),
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
