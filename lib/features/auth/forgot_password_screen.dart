import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
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
              'Account Recovery',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'We\'ll help you get back in',
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
                Tab(text: 'EMAIL'),
                Tab(text: 'PHONE'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _EmailRecoveryTab(),
          _PhoneRecoveryTab(),
        ],
      ),
    );
  }
}

class _EmailRecoveryTab extends StatefulWidget {
  @override
  State<_EmailRecoveryTab> createState() => _EmailRecoveryTabState();
}

class _EmailRecoveryTabState extends State<_EmailRecoveryTab> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    setState(() {
      _loading = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _loading = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Icon header
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AuraColors.sage.withOpacity(0.2),
              ),
            ),
            child: Icon(
              Icons.email_outlined,
              size: 32,
              color: AuraColors.sage,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _sent ? 'Check your inbox' : 'Reset via Email',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: AuraColors.chrome,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _sent
                ? 'If an account exists for this email, you\'ll receive a password reset link shortly.'
                : 'Enter your email address and we\'ll send you a link to reset your password.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AuraColors.chrome.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 32),
          if (!_sent) ...<Widget>[
            _Label('EMAIL ADDRESS'),
            const SizedBox(height: 10),
            _TextField(
              controller: _emailController,
              hint: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.alternate_email_rounded,
            ),
            const SizedBox(height: 28),
            _PrimaryButton(
              label: 'Send Reset Link',
              loading: _loading,
              onPressed: _sendResetLink,
            ),
          ] else ...<Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AuraColors.sage.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AuraColors.sage.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AuraColors.sage,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Reset link sent successfully!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AuraColors.sage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _PrimaryButton(
              label: 'Back to Login',
              loading: false,
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            ),
          ],
          const SizedBox(height: 24),
          // Back to login link
          if (!_sent)
            Center(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'Back to Login',
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                    color: AuraColors.chrome.withOpacity(0.5),
                    decoration: TextDecoration.underline,
                    decorationColor: AuraColors.chrome.withOpacity(0.3),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PhoneRecoveryTab extends StatefulWidget {
  @override
  State<_PhoneRecoveryTab> createState() => _PhoneRecoveryTabState();
}

class _PhoneRecoveryTabState extends State<_PhoneRecoveryTab> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _loading = false;
  bool _otpSent = false;
  bool _verified = false;

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
      _loading = false;
      _otpSent = true;
    });
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) return;
    setState(() {
      _loading = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _loading = false;
      _verified = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Icon header
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AuraColors.sage.withOpacity(0.2),
              ),
            ),
            child: Icon(
              Icons.phone_android_rounded,
              size: 32,
              color: AuraColors.sage,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _verified
                ? 'Phone Verified'
                : _otpSent
                    ? 'Enter OTP'
                    : 'Reset via Phone',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: AuraColors.chrome,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _verified
                ? 'Your phone number has been verified. You can now set a new password.'
                : _otpSent
                    ? 'Enter the 6-digit code sent to your phone number.'
                    : 'Enter the phone number linked to your account to receive a verification code.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AuraColors.chrome.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 32),
          if (!_otpSent && !_verified) ...<Widget>[
            _Label('PHONE NUMBER'),
            const SizedBox(height: 10),
            _TextField(
              controller: _phoneController,
              hint: '+91 98765 43210',
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
            ),
            const SizedBox(height: 28),
            _PrimaryButton(
              label: 'Send OTP',
              loading: _loading,
              onPressed: _sendOtp,
            ),
          ] else if (_otpSent && !_verified) ...<Widget>[
            _Label('VERIFICATION CODE'),
            const SizedBox(height: 10),
            _TextField(
              controller: _otpController,
              hint: '000000',
              keyboardType: TextInputType.number,
              maxLength: 6,
              prefixIcon: Icons.pin_outlined,
            ),
            const SizedBox(height: 28),
            _PrimaryButton(
              label: 'Verify',
              loading: _loading,
              onPressed: _verifyOtp,
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () => setState(() {
                  _otpSent = false;
                  _otpController.clear();
                }),
                child: Text(
                  'Change phone number',
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                    color: AuraColors.sage.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ] else ...<Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AuraColors.sage.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AuraColors.sage.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AuraColors.sage,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Phone verified successfully!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AuraColors.sage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _PrimaryButton(
              label: 'Back to Login',
              loading: false,
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            ),
          ],
          const SizedBox(height: 24),
          // Help text
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
            ),
            child: Text(
              'No backend: Enter any phone number and any 6-digit OTP to simulate recovery.',
              style: TextStyle(
                fontSize: 10,
                height: 1.4,
                color: AuraColors.chrome.withOpacity(0.5),
              ),
            ),
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
    this.maxLength,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int? maxLength;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 20,
                color: AuraColors.chrome.withOpacity(0.4),
              )
            : null,
        filled: true,
        fillColor: AuraColors.obsidian.withOpacity(0.7),
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AuraColors.sage, width: 1.5),
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
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
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
