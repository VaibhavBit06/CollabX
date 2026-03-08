import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/utils/mock_data.dart';

class AnalyticsOverviewScreen extends StatelessWidget {
  const AnalyticsOverviewScreen({super.key});

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _goEngagement(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.engagementRate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const _AnalyticsHeader(),
            const Expanded(child: _AnalyticsBody()),
            _AnalyticsBottomNav(
              onGrid: _goHome,
              onAnalytics: (_) {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AuraColors.chrome,
        foregroundColor: AuraColors.midnight,
        onPressed: () => _goEngagement(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AnalyticsHeader extends StatelessWidget {
  const _AnalyticsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(Icons.menu, color: AuraColors.sage),
          Column(
            children: <Widget>[
              Text(
                'Analytics',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500,
                  color: AuraColors.chrome,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Performance Overview',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: AuraColors.chrome,
                ),
              ),
            ],
          ),
          const Icon(Icons.notifications_none, color: AuraColors.sage),
        ],
      ),
    );
  }
}

class _AnalyticsBody extends StatelessWidget {
  const _AnalyticsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Weekly Reach',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                MockStats.totalReach,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                MockStats.audienceReachDelta,
                style: TextStyle(
                  color: AuraColors.sage,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.engagementRate),
                  child: _StatCard(
                    icon: Icons.insights,
                    label: 'Engagement',
                    value: MockStats.engagementRate,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.platformGrowth),
                  child: _StatCard(
                    icon: Icons.person_add,
                    label: 'New Fans',
                    value: MockStats.newFans,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Audience Insights',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.platformGrowth),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: AuraColors.obsidian.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
              ),
              child: const Center(
                child: Text(
                  'Geography and platform breakdown\n(Tap to see platform growth)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: AuraColors.sage),
          const SizedBox(height: 12),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsBottomNav extends StatelessWidget {
  const _AnalyticsBottomNav({
    required this.onGrid,
    required this.onAnalytics,
  });

  final void Function(BuildContext) onGrid;
  final void Function(BuildContext) onAnalytics;

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
            active: false,
            onTap: () => onGrid(context),
          ),
          _NavItem(
            icon: Icons.analytics,
            label: 'Discover',
            active: true,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.forum_outlined,
            label: 'Inbox',
            active: false,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.dealsInbox),
          ),
          _NavItem(
            icon: Icons.account_circle_outlined,
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
          Icon(icon, color: color, size: 24),
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
