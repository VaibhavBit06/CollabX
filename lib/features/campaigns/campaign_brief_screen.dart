import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/utils/mock_data.dart';

class CampaignBriefScreen extends StatelessWidget {
  const CampaignBriefScreen({super.key});

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
            icon:
                Icon(Icons.arrow_back_ios_new, color: AuraColors.chrome),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saved to bookmarks!')),
              );
            },
            icon: Icon(Icons.bookmark_border, color: AuraColors.chrome),
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AuraColors.obsidian,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: <Color>[Colors.grey, AuraColors.textPrimary.withOpacity(0.7)],
                  ),
                  border: Border.all(
                    color: AuraColors.textPrimary.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    MockCampaignBrief.label,
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 3,
                      color: AuraColors.sage,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    MockCampaignBrief.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: MockCampaignBrief.tags.map((t) => _Tag(text: t)).toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            MockCampaignBrief.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const <Widget>[
              Expanded(
                child: _InfoTile(
                  label: 'Budget Range',
                  value: MockCampaignBrief.budgetRange,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _InfoTile(
                  label: 'Timeline',
                  value: MockCampaignBrief.timeline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  MockCampaignBrief.interest,
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AuraColors.textPrimary.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Interest submitted!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuraColors.obsidian,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    'EXPRESS INTEREST',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 3,
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.2)),
        color: AuraColors.textPrimary.withOpacity(0.04),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 1.5,
          color: AuraColors.textPrimary.withOpacity(0.8),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            color: AuraColors.sage.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
