import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class BrandMarketplaceScreen extends StatefulWidget {
  const BrandMarketplaceScreen({super.key});

  @override
  State<BrandMarketplaceScreen> createState() => _BrandMarketplaceScreenState();
}

class _BrandMarketplaceScreenState extends State<BrandMarketplaceScreen> {
  int _filterIndex = 0;
  static const List<String> _filters = <String>[
    'All',
    'Fashion',
    'Beauty',
    'Tech',
    'Travel',
    'Wellness',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const _Header(),
            const SizedBox(height: 16),
            _SearchBar(),
            const SizedBox(height: 16),
            _FilterRow(
              filters: _filters,
              selectedIndex: _filterIndex,
              onSelect: (int i) => setState(() => _filterIndex = i),
            ),
            const SizedBox(height: 16),
            const Expanded(child: _CampaignList()),
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
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DISCOVER',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 4,
                  color: AuraColors.sage.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Brand Campaigns',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                  color: AuraColors.textPrimary,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.wallet),
                icon: const Icon(Icons.account_balance_wallet_outlined,
                    color: AuraColors.sage),
              ),
              IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.settings),
                icon: Icon(Icons.tune, color: AuraColors.textPrimary.withOpacity(0.6)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.07)),
        ),
        child: TextField(
          style: TextStyle(fontSize: 14, color: AuraColors.textPrimary),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon:
                Icon(Icons.search, color: AuraColors.textPrimary.withOpacity(0.3)),
            hintText: 'Search brands or categories...',
            hintStyle:
                TextStyle(fontSize: 13, color: AuraColors.textPrimary.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.filters,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> filters;
  final int selectedIndex;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext ctx, int i) {
          final bool isSelected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AuraColors.sage : AuraColors.obsidian,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? AuraColors.sage
                      : AuraColors.textPrimary.withOpacity(0.1),
                ),
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? AuraColors.midnight
                      : AuraColors.textPrimary.withOpacity(0.6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CampaignList extends StatelessWidget {
  const _CampaignList();

  static const List<MockCampaign> _campaigns = MockCampaigns.all;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _campaigns.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext ctx, int i) =>
          _CampaignCard(campaign: _campaigns[i]),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({required this.campaign});
  final MockCampaign campaign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.campaignApply),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Brand avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AuraColors.sage.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AuraColors.sage.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.business_center,
                          color: AuraColors.sage, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          campaign.brand,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AuraColors.textPrimary,
                          ),
                        ),
                        Text(
                          campaign.category.toUpperCase(),
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
                Row(
                  children: <Widget>[
                    if (campaign.isHot)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color: const Color(0xFFFF6B35).withOpacity(0.4)),
                        ),
                        child: const Text(
                          '🔥 HOT',
                          style: TextStyle(
                              fontSize: 9,
                              letterSpacing: 1.5,
                              color: Color(0xFFFF6B35)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              campaign.tagline,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AuraColors.textPrimary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 14),
            // Niche chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: campaign.niches
                  .map(
                    (String n) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        border:
                            Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
                      ),
                      child: Text(
                        n,
                        style: TextStyle(
                          fontSize: 10,
                          color: AuraColors.textPrimary.withOpacity(0.5),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            Container(
              height: 1,
              color: AuraColors.textPrimary.withOpacity(0.06),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _InfoPill(
                    icon: Icons.payments_outlined, label: campaign.budget),
                _InfoPill(
                    icon: Icons.calendar_today_outlined,
                    label: 'By ${campaign.deadline}'),
                _InfoPill(
                    icon: Icons.people_outline,
                    label: '${campaign.minFollowers}+ followers'),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.campaignApply),
                child: const Text(
                  'APPLY NOW',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 12, color: AuraColors.textPrimary.withOpacity(0.4)),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AuraColors.textPrimary.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}



// ──────────────────────── Bottom Navigation ────────────────────────

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
            icon: Icons.home,
            label: 'Home',
            active: false,
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          _NavItem(
            icon: Icons.explore,
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
            icon: Icons.account_circle,
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
            style: TextStyle(fontSize: 9, letterSpacing: 2, color: color),
          ),
        ],
      ),
    );
  }
}
