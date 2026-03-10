import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class WeeklySnapshotScreen extends StatelessWidget {
  const WeeklySnapshotScreen({super.key});

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
            'Weekly Snapshot',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share coming soon')),
              );
            },
            icon: Icon(Icons.share, color: AuraColors.chrome),
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
            'Total Reach',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              color: AuraColors.sage.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                MockStats.weeklyReach,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                MockStats.weeklyReachDelta,
                style: TextStyle(
                  fontSize: 13,
                  color: AuraColors.sage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            MockStats.weeklyDateRange,
            style: TextStyle(
              fontSize: 10,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 24),
          const _BarChartPlaceholder(),
          const SizedBox(height: 24),
          Text(
            'Top Performing Content',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          _TopContentRow(
            title: MockSnapshot.topContent1,
            reach: MockSnapshot.topContent1Reach,
          ),
          _TopContentRow(
            title: MockSnapshot.topContent2,
            reach: MockSnapshot.topContent2Reach,
          ),
        ],
      ),
    );
  }
}

class _BarChartPlaceholder extends StatelessWidget {
  const _BarChartPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
      ),
      child: const Center(
        child: Text(
          'Weekly bars for each day\n(as per design)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

class _TopContentRow extends StatelessWidget {
  const _TopContentRow({
    required this.title,
    required this.reach,
  });

  final String title;
  final String reach;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AuraColors.textPrimary.withOpacity(0.1),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                reach,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'REACH',
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: AuraColors.sage.withOpacity(0.7),
                ),
              ),
            ],
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
