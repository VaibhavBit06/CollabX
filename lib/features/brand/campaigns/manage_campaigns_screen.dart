import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/campaign_data.dart';

class ManageCampaignsScreen extends StatelessWidget {
  const ManageCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final campaigns = CampaignData.instance.campaigns;

    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
        title: Text(
          'MY CAMPAIGNS',
          style: TextStyle(fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: campaigns.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final c = campaigns[index];
          return _CampaignItem(
            title: c.title,
            status: c.statusLabel,
            applicants: c.visibleApplicants.length,
            budget: c.budget,
            isHighlight: c.statusLabel == 'PENDING REVIEW',
          );
        },
      ),
    );
  }
}

class _CampaignItem extends StatelessWidget {
  const _CampaignItem({
    required this.title,
    required this.status,
    required this.applicants,
    required this.budget,
    this.isHighlight = false,
  });

  final String title, status, budget;
  final int applicants;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isHighlight ? AuraColors.sage.withOpacity(0.3) : AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: isHighlight ? AuraColors.sage : AuraColors.chrome.withOpacity(0.4),
                ),
              ),
              Icon(Icons.more_horiz, color: AuraColors.chrome, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(color: AuraColors.chrome, fontSize: 18, fontWeight: FontWeight.w200, letterSpacing: 1),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _InfoCell(label: 'Applicants', value: applicants.toString()),
              const Spacer(),
              _InfoCell(label: 'Total Budget', value: budget),
              const Spacer(),
              _ActionButton(
                label: 'REVIEW PROPOSAL',
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.campaignApplicants,
                  arguments: {
                    'campaignTitle': title,
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(fontSize: 8, letterSpacing: 1, color: AuraColors.chrome.withOpacity(0.3), fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: AuraColors.chrome, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AuraColors.sage.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AuraColors.sage.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 10, letterSpacing: 1, color: AuraColors.sage, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
