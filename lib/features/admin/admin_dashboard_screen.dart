import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/utils/mock_data.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: AuraColors.midnight,
        foregroundColor: AuraColors.chrome,
        elevation: 0,
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 14,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Monitor creators, campaigns, and payouts at a glance.',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AuraColors.chrome.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  _AdminMetricCard(
                    title: 'Creators',
                    primaryValue: MockAdmin.creatorsCount,
                    subtitle: MockAdmin.creatorsSubtitle,
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 16),
                  _AdminMetricCard(
                    title: 'Live Campaigns',
                    primaryValue: MockAdmin.liveCampaigns,
                    subtitle: MockAdmin.liveCampaignsSubtitle,
                    icon: Icons.campaign_outlined,
                  ),
                  SizedBox(height: 16),
                  _AdminMetricCard(
                    title: 'Payout Queue',
                    primaryValue: MockAdmin.payoutQueue,
                    subtitle: MockAdmin.payoutQueueSubtitle,
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminMetricCard extends StatelessWidget {
  const _AdminMetricCard({
    required this.title,
    required this.primaryValue,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String primaryValue;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AuraColors.sage,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AuraColors.chrome.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  primaryValue,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: AuraColors.chrome,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: AuraColors.chrome.withOpacity(0.6),
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

