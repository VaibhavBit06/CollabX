import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/auth_service.dart';

class BrandSettingsScreen extends StatelessWidget {
  const BrandSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 12),
            _buildHeader(context),
            const SizedBox(height: 8),
            const Expanded(
              child: _SettingsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new, color: AuraColors.sage),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brand Settings',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AuraColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your business presence',
                  style: TextStyle(
                    fontSize: 14,
                    color: AuraColors.chrome.withOpacity(0.5),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
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
          const _SectionLabel('BUSINESS PROFILE'),
          _SettingsCard(
            children: <Widget>[
              _SettingsRow(
                icon: Icons.business_outlined,
                label: 'Brand Profile',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.brandProfilePreview),
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.verified_user_outlined,
                label: 'Verification Status',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AuraColors.sage.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'VERIFIED',
                    style: TextStyle(color: AuraColors.sage, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionLabel('FINANCE'),
          _SettingsCard(
            children: <Widget>[
              _SettingsRow(
                icon: Icons.payments_outlined,
                label: 'Campaign Payments',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.transactionHistory),
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.history_outlined,
                label: 'Transaction History',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.transactionHistory),
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
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.themeSelection),
              ),
              const _Divider(),
              _SettingsRow(
                icon: Icons.notifications_none,
                label: 'Collaboration Alerts',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          _LogoutButton(
            onPressed: () async {
              await AuthService.instance.signOut();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.authWelcome,
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'PLATINUM BRAND PARTNER',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 3,
                fontWeight: FontWeight.w300,
                color: AuraColors.textPrimary.withOpacity(0.1),
              ),
            ),
          ),
          const SizedBox(height: 48),
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
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(children: children),
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
                Icon(icon, color: AuraColors.sage, size: 22),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AuraColors.chrome),
                ),
              ],
            ),
            trailing ?? Icon(Icons.chevron_right, color: AuraColors.textPrimary.withOpacity(0.2)),
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
        icon: const Icon(Icons.logout, color: Color(0xFFFB7185)),
        label: const Text(
          'Log Out',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFFB7185)),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor: const Color(0xFF450A0A).withOpacity(0.4),
        ),
      ),
    );
  }
}
