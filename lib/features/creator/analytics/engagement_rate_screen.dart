import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class EngagementRateScreen extends StatelessWidget {
  const EngagementRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            _Header(),
            Expanded(child: _Body()),
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
            icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
          ),
          const Text(
            'Engagement Rate',
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
            'Average Rate',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                MockStats.avgEngagementRate,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                MockStats.avgEngagementDelta,
                style: TextStyle(
                  color: AuraColors.sage,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
            ),
            child: const Center(
              child: Text(
                'Line chart for engagement vs niche\n(visual only in design)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Interactions Breakdown',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              Expanded(
                child: _MetricCard(
                  icon: Icons.favorite_border,
                  label: 'Likes',
                  value: MockStats.totalLikes,
                  delta: MockStats.likesDelta,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comments',
                  value: MockStats.totalComments,
                  delta: MockStats.commentsDelta,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.socialLinks),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE1306C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: const Color(0xFFE1306C).withOpacity(0.25)),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.camera_alt,
                      color: Color(0xFFE1306C), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Verify Instagram Account',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AuraColors.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Connect for deeper native analytics',
                          style: TextStyle(fontSize: 11, color: AuraColors.textPrimary.withOpacity(0.54)),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AuraColors.textPrimary.withOpacity(0.38)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.delta,
  });

  final IconData icon;
  final String label;
  final String value;
  final String delta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(icon, color: AuraColors.textPrimary.withOpacity(0.7)),
              Text(
                delta,
                style: TextStyle(
                  fontSize: 10,
                  color: AuraColors.sage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 2,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
