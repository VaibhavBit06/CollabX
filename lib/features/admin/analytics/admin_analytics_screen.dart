import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Analytics & Reporting', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('Platform-wide stats and growth metrics.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _StatCard(label: 'Total Creators', value: '1,284', delta: '+12.4%', icon: Icons.people_outline, color: AuraColors.sage)),
                    const SizedBox(width: 12),
                    Expanded(child: _StatCard(label: 'Total Brands', value: '342', delta: '+8.2%', icon: Icons.business_outlined, color: const Color(0xFF7EB5D6))),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _StatCard(label: 'Active Campaigns', value: '86', delta: '+24', icon: Icons.campaign_outlined, color: const Color(0xFFE8A87C))),
                    const SizedBox(width: 12),
                    Expanded(child: _StatCard(label: 'Completed', value: '432', delta: '94% rate', icon: Icons.check_circle_outline, color: AuraColors.sage)),
                  ],
                ),
                const SizedBox(height: 24),
                _RevenueCard(),
                const SizedBox(height: 24),
                _GrowthCard(),
                const SizedBox(height: 24),
                _TopPerformersCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.delta, required this.icon, required this.color});
  final String label, value, delta;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.08), AuraColors.obsidian.withOpacity(0.8)],
        ),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 16, color: color.withOpacity(0.8)),
              ),
              Text(delta, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AuraColors.sage.withOpacity(0.8))),
            ],
          ),
          const SizedBox(height: 14),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
          const SizedBox(height: 2),
          Text(label.toUpperCase(), style: TextStyle(fontSize: 9, letterSpacing: 2, color: AuraColors.chrome.withOpacity(0.35))),
        ],
      ),
    );
  }
}

class _RevenueCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PLATFORM REVENUE', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.4))),
          const SizedBox(height: 12),
          Text('₹18,42,500', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
          const SizedBox(height: 4),
          Text('Total transaction volume this month', style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.4))),
          const SizedBox(height: 16),
          // Mini bar chart
          Row(
            children: [
              for (int i = 0; i < 7; i++) ...[
                Expanded(
                  child: Container(
                    height: [28.0, 20.0, 34.0, 24.0, 38.0, 30.0, 42.0][i],
                    decoration: BoxDecoration(
                      color: AuraColors.sage.withOpacity(i == 6 ? 0.6 : 0.15 + i * 0.04),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                if (i < 6) const SizedBox(width: 4),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final d in ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'])
                Expanded(child: Center(child: Text(d, style: TextStyle(fontSize: 8, color: AuraColors.chrome.withOpacity(0.25))))),
            ],
          ),
        ],
      ),
    );
  }
}

class _GrowthCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('USER GROWTH', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.4))),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _GrowthMetric(label: 'New Creators', value: '+124', period: 'This month')),
              const SizedBox(width: 16),
              Expanded(child: _GrowthMetric(label: 'New Brands', value: '+38', period: 'This month')),
              const SizedBox(width: 16),
              Expanded(child: _GrowthMetric(label: 'Campaigns', value: '+22', period: 'This month')),
            ],
          ),
        ],
      ),
    );
  }
}

class _GrowthMetric extends StatelessWidget {
  const _GrowthMetric({required this.label, required this.value, required this.period});
  final String label, value, period;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: AuraColors.sage)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: AuraColors.chrome, fontWeight: FontWeight.w400)),
        Text(period, style: TextStyle(fontSize: 9, color: AuraColors.chrome.withOpacity(0.3))),
      ],
    );
  }
}

class _TopPerformersCard extends StatelessWidget {
  final List<Map<String, String>> _top = const [
    {'name': 'Zara Khan', 'handle': '@zarafashion', 'campaigns': '31', 'earnings': '₹9,45,000'},
    {'name': 'Arjun Mehta', 'handle': '@arjunlens', 'campaigns': '22', 'earnings': '₹6,80,400'},
    {'name': 'Sohail Khan', 'handle': '@sohailcreates', 'campaigns': '14', 'earnings': '₹4,02,850'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TOP CREATORS', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.4))),
          const SizedBox(height: 12),
          ..._top.asMap().entries.map((entry) {
            final i = entry.key;
            final c = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AuraColors.midnight.withOpacity(0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: [AuraColors.sage, const Color(0xFF7EB5D6), const Color(0xFFE8A87C)][i].withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('${i + 1}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: [AuraColors.sage, const Color(0xFF7EB5D6), const Color(0xFFE8A87C)][i]))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c['name']!, style: TextStyle(fontSize: 13, color: AuraColors.chrome, fontWeight: FontWeight.w400)),
                        Text('${c['handle']}  •  ${c['campaigns']} campaigns', style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.35))),
                      ],
                    ),
                  ),
                  Text(c['earnings']!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AuraColors.sage)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
