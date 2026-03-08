import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AccountSecurityScreen extends StatelessWidget {
  const AccountSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            _Header(),
            Expanded(child: _Content()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.85),
        border: Border(
          bottom: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.chevron_left),
          ),
          const Expanded(
            child: Text(
              'Account Security',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 24,
            backgroundColor: AuraColors.obsidian,
            child: Icon(Icons.shield, color: AuraColors.chrome),
          ),
          const SizedBox(height: 16),
          const Text(
            'Protect your influence',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your credentials and monitor active sessions to keep your profile secure.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: AuraColors.midnight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
            ),
            child: Column(
              children: <Widget>[
                _SecurityRow(
                  icon: Icons.smartphone,
                  title: 'Two-Factor Auth',
                  subtitle: 'Recommended',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('2FA Config coming soon')),
                    );
                  },
                ),
                Divider(height: 1, color: AuraColors.textPrimary.withOpacity(0.24)),
                _SecurityRow(
                  icon: Icons.lock_reset,
                  title: 'Change Password',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Change Password coming soon')),
                    );
                  },
                ),
                Divider(height: 1, color: AuraColors.textPrimary.withOpacity(0.24)),
                _SecurityRow(
                  icon: Icons.devices,
                  title: 'Login Activity',
                  trailingDot: true,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Login Activity coming soon')),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Security Status',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.check_circle, size: 16, color: AuraColors.sage),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Your account is currently protected by biometric passkeys on iOS.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AuraColors.textPrimary.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SecurityRow extends StatelessWidget {
  const _SecurityRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingDot = false,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool trailingDot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: AuraColors.textPrimary.withOpacity(0.7)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            color: AuraColors.sage.withOpacity(0.7),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                if (trailingDot)
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: const BoxDecoration(
                      color: AuraColors.sage,
                      shape: BoxShape.circle,
                    ),
                  ),
                Icon(
                  Icons.chevron_right,
                  color: AuraColors.textPrimary.withOpacity(0.3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
