import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class PlatformGrowthScreen extends StatelessWidget {
  const PlatformGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const _Header(),
            const Expanded(child: _Body()),
            const _BottomNav(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon:
                Icon(Icons.arrow_back_ios_new, color: AuraColors.chrome),
          ),
          const Text(
            'Platform Growth',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: AuraColors.chrome),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Total Audience Reach',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              color: AuraColors.sage.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Text(
                MockStats.totalReach,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                MockStats.weeklyReachDelta,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.greenAccent.shade200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Distribution Split',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: AuraColors.obsidian,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 45,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE1306C),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(999),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 35,
                  child: Container(
                    color: const Color(0xFF00F2EA),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF0000),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            MockStats.platformSplit,
            style: TextStyle(
              fontSize: 10,
              color: AuraColors.textPrimary.withOpacity(0.7),
            ),
          ),
        ],
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
        color: AuraColors.midnight.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          _NavItem(
            icon: Icons.explore,
            label: 'Discover',
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.brandMarketplace),
          ),
          _NavItem(
            icon: Icons.handshake_outlined,
            label: 'Collabs',
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.creatorCollaborations),
          ),
          _NavItem(
            icon: Icons.account_circle,
            label: 'Profile',
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
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = AuraColors.textPrimary.withOpacity(0.4);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 9, letterSpacing: 2, color: color),
          ),
        ],
      ),
    );
  }
}
