import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class PayoutMethodsScreen extends StatelessWidget {
  const PayoutMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            _Header(),
            Expanded(child: _Content()),
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
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.chevron_left),
          ),
          const Expanded(
            child: Text(
              'Payout Methods',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.wallet),
            icon: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AuraColors.sage,
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Management',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Linked Accounts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 16),
          _PayoutCard(
            title: MockPayoutMethods.all[0].type,
            subtitle: MockPayoutMethods.all[0].detail,
            defaultLabel: MockPayoutMethods.all[0].status,
          ),
          const SizedBox(height: 12),
          _PayoutCard(
            title: MockPayoutMethods.all[1].type,
            subtitle: MockPayoutMethods.all[1].detail,
            defaultLabel: MockPayoutMethods.all[1].status,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.obsidian.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
            ),
            child: Text(
              MockPayoutMethods.payoutNote,
              style: TextStyle(
                fontSize: 11,
                height: 1.5,
                color: AuraColors.textPrimary.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Add new payout method coming soon')),
                );
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text(
                'ADD NEW PAYOUT METHOD',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AuraColors.obsidian,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayoutCard extends StatelessWidget {
  const _PayoutCard({
    required this.title,
    required this.subtitle,
    required this.defaultLabel,
  });

  final String title;
  final String subtitle;
  final String defaultLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                color: AuraColors.textPrimary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.account_balance),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                defaultLabel.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 3,
                  color: AuraColors.sage,
                ),
              ),
              Text(
                'Edit',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  color: AuraColors.textPrimary.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
