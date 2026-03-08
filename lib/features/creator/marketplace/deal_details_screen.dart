import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class DealDetailsScreen extends StatelessWidget {
  const DealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            _Header(),
            Expanded(child: _Body()),
            _FooterActions(),
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
            'Deal Details',
            style: TextStyle(
              fontSize: 13,
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
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AuraColors.obsidian,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    MockDealDetail.campaignLabel,
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 2,
                      color: AuraColors.sage,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    MockDealDetail.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _Tag(text: MockDealDetail.tags[0]),
              const SizedBox(width: 6),
              _Tag(text: MockDealDetail.tags[1]),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'The Brief',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.sage,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
            ),
            child: const Text(
              MockDealDetail.brief,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Deliverables',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.sage,
            ),
          ),
          const SizedBox(height: 8),
          const _DeliverableRow(
            icon: Icons.videocam_outlined,
            title: MockDealDetail.deliverable1Title,
            subtitle: MockDealDetail.deliverable1Sub,
          ),
          const _DeliverableRow(
            icon: Icons.photo_camera_outlined,
            title: MockDealDetail.deliverable2Title,
            subtitle: MockDealDetail.deliverable2Sub,
          ),
          const SizedBox(height: 24),
          const Text(
            'Compensation',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.sage,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _CompRow(label: 'Creative Fee', value: MockDealDetail.creativeFee),
                _CompRow(
                  label: 'Usage Rights Extension',
                  value: MockDealDetail.usageRights,
                ),
                SizedBox(height: 8),
                Divider(color: AuraColors.textPrimary.withOpacity(0.24)),
                SizedBox(height: 8),
                Text(
                  'Total Payout',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 3,
                    color: AuraColors.sage,
                  ),
                ),
                Text(
                  MockDealDetail.totalPayout,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w200,
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

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
        color: AuraColors.textPrimary.withOpacity(0.05),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _DeliverableRow extends StatelessWidget {
  const _DeliverableRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AuraColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.chevron_right,
            color: AuraColors.textPrimary.withOpacity(0.38),
          ),
        ],
      ),
    );
  }
}

class _CompRow extends StatelessWidget {
  const _CompRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AuraColors.textPrimary.withOpacity(0.6),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterActions extends StatelessWidget {
  const _FooterActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            AuraColors.midnight.withOpacity(0.0),
            AuraColors.midnight.withOpacity(0.9),
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Negotiation flow coming soon')),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AuraColors.textPrimary,
                side: BorderSide(color: AuraColors.textPrimary.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'NEGOTIATE',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Offer Accepted')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AuraColors.textPrimary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'ACCEPT OFFER',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
