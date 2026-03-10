import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class BrandProfilePreviewScreen extends StatelessWidget {
  const BrandProfilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBrandStats(),
                  const SizedBox(height: 32),
                  _SectionHeader(title: 'BIO'),
                  const SizedBox(height: 12),
                  Text(
                    'Leading sustainable fashion brand making high-end aesthetics accessible. We believe in minimal waste and maximal style.',
                    style: TextStyle(color: AuraColors.chrome, fontSize: 15, fontWeight: FontWeight.w300, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  _SectionHeader(title: 'CURRENT CAMPAIGNS'),
                  const SizedBox(height: 16),
                  _CampaignPreviewCard(title: 'Summer Glow 2026', niche: 'Fashion'),
                  _CampaignPreviewCard(title: 'Eco-Essentials', niche: 'Lifestyle'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      backgroundColor: AuraColors.midnight,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AuraColors.sage.withOpacity(0.3), AuraColors.midnight],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AuraColors.obsidian,
                    child: Icon(Icons.business, color: AuraColors.sage, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Lumina Fashion',
                    style: TextStyle(color: AuraColors.chrome, fontSize: 24, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    'lumina.fashion',
                    style: TextStyle(color: AuraColors.sage, fontSize: 12, letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            _StatItem(label: 'Campaigns', value: '12'),
            _StatItem(label: 'Collaborators', value: '148'),
            _StatItem(label: 'Reach', value: '1.2M'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
    const _StatItem({required this.label, required this.value});
    final String label, value;

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                Text(value, style: TextStyle(color: AuraColors.chrome, fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 10, letterSpacing: 1)),
            ],
        );
    }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AuraColors.chrome.withOpacity(0.4),
            fontSize: 10,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: AuraColors.textPrimary.withOpacity(0.05))),
      ],
    );
  }
}

class _CampaignPreviewCard extends StatelessWidget {
    const _CampaignPreviewCard({required this.title, required this.niche});
    final String title, niche;

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AuraColors.obsidian,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
            ),
            child: Row(
                children: [
                    Icon(Icons.campaign_outlined, color: AuraColors.sage, size: 24),
                    const SizedBox(width: 16),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(title, style: TextStyle(color: AuraColors.chrome, fontSize: 14)),
                            Text(niche, style: TextStyle(color: AuraColors.chrome.withOpacity(0.3), fontSize: 11)),
                        ],
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right, color: AuraColors.chrome.withOpacity(0.2)),
                ],
            ),
        );
    }
}
