import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 12),
            const _SettingsHeader(),
            const SizedBox(height: 8),
            const Expanded(
              child: _SettingsContent(),
            ),
            const _BottomNav(),
          ],
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AuraColors.sage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AuraColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionLabel('ACCOUNT'),
          _SettingsCard(
            children: <Widget>[
              _SettingsRow(
                icon: Icons.person_outline,
                label: 'Personal Details',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.personalDetails);
                },
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.shield_outlined,
                label: 'Account Security',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.accountSecurity);
                },
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.account_balance_wallet_outlined,
                label: 'My Wallet',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.wallet);
                },
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.payments,
                label: 'Payout Methods',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.payoutMethods);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionLabel('PREFERENCES'),
          _SettingsCard(
            children: <Widget>[
              _SettingsRow(
                icon: Icons.palette_outlined,
                label: 'App Theme',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AuraColors.isDark ? 'Midnight' : 'Aurora',
                      style: TextStyle(
                        fontSize: 12,
                        color: AuraColors.textPrimary.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      color: AuraColors.textPrimary.withOpacity(0.2),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.themeSelection);
                },
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.lock_outline,
                label: 'Privacy',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.privacySettings);
                },
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.notifications_none,
                label: 'Notifications',
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.notificationSettings);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionLabel('SUPPORT'),
          _SettingsCard(
            children: <Widget>[
              _SettingsRow(
                icon: Icons.help_outline,
                label: 'Help Center',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.helpSupport);
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          _LogoutButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.authWelcome,
                (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'VERSION 2.4.0 (PLATINUM)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              fontWeight: FontWeight.w300,
              color: AuraColors.textPrimary.withOpacity(0.1),
            ),
          ),
          const SizedBox(height: 96),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 3,
          fontWeight: FontWeight.w600,
          color: AuraColors.textPrimary.withOpacity(0.3),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AuraColors.obsidian.withOpacity(0.4),
        border: Border.all(color: AuraColors.borderSubtle),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: AuraColors.sage,
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AuraColors.chrome,
                  ),
                ),
              ],
            ),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: AuraColors.textPrimary.withOpacity(0.2),
                ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white.withOpacity(0.05),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.logout,
          color: Color(0xFFFB7185),
        ),
        label: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFB7185),
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: const Color(0xFF450A0A).withOpacity(0.4),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: AuraColors.borderSubtle,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            active: false,
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          _NavItem(
            icon: Icons.explore,
            label: 'Discover',
            active: false,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.brandMarketplace),
          ),
          _NavItem(
            icon: Icons.handshake_outlined,
            label: 'Collabs',
            active: false,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.creatorCollaborations),
          ),
          _NavItem(
            icon: Icons.account_circle,
            label: 'Profile',
            active: false,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.profileBento),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color =
        active ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.4);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 2,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
