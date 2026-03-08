import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class DealsInboxScreen extends StatefulWidget {
  const DealsInboxScreen({super.key});

  @override
  State<DealsInboxScreen> createState() => _DealsInboxScreenState();
}

class _DealsInboxScreenState extends State<DealsInboxScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;
  int _selectedFilter = 0;

  static const List<String> _filters = ['All', 'New', 'Active', 'Completed'];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  Animation<double> _fadeFor(int i) {
    final s = (i * 0.1).clamp(0.0, 0.7);
    final e = (s + 0.3).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _staggerController,
      curve: Interval(s, e, curve: Curves.easeOut),
    );
  }

  Animation<Offset> _slideFor(int i) {
    final s = (i * 0.1).clamp(0.0, 0.7);
    final e = (s + 0.3).clamp(0.0, 1.0);
    return Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _staggerController,
      curve: Interval(s, e, curve: Curves.easeOutCubic),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Header
            FadeTransition(
              opacity: _fadeFor(0),
              child: SlideTransition(
                position: _slideFor(0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w200,
                          color: AuraColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.settings),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AuraColors.obsidian,
                          child: Icon(Icons.settings, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Summary strip
            FadeTransition(
              opacity: _fadeFor(1),
              child: SlideTransition(
                position: _slideFor(1),
                child: _SummaryStrip(),
              ),
            ),
            const SizedBox(height: 12),
            // Filter chips
            FadeTransition(
              opacity: _fadeFor(2),
              child: SlideTransition(
                position: _slideFor(2),
                child: SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isActive = i == _selectedFilter;
                      return GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => _selectedFilter = i);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AuraColors.sage
                                : AuraColors.obsidian.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: isActive
                                  ? AuraColors.sage
                                  : AuraColors.textPrimary.withOpacity(0.08),
                            ),
                          ),
                          child: Text(
                            _filters[i],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isActive
                                  ? AuraColors.midnight
                                  : AuraColors.textPrimary.withOpacity(0.5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Deals list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  FadeTransition(
                    opacity: _fadeFor(3),
                    child: SlideTransition(
                      position: _slideFor(3),
                      child: _DealCard(
                        brand: MockDeals.inbox[0].brand,
                        subtitle: MockDeals.inbox[0].subtitle,
                        amount: MockDeals.inbox[0].amount,
                        statusLabel: MockDeals.inbox[0].statusLabel,
                        statusColor: const Color(0xFF7EB5D6),
                        brandIcon: Icons.spa_outlined,
                        brandIconColor: const Color(0xFFE8A87C),
                        onPrimaryTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.dealDetails),
                        primaryLabel: 'View Details',
                        onSecondaryTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.campaignBrief),
                        secondaryLabel: 'Campaign',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: _fadeFor(4),
                    child: SlideTransition(
                      position: _slideFor(4),
                      child: _DealCard(
                        brand: MockDeals.inbox[1].brand,
                        subtitle: MockDeals.inbox[1].subtitle,
                        amount: MockDeals.inbox[1].amount,
                        statusLabel: MockDeals.inbox[1].statusLabel,
                        statusColor: const Color(0xFFE8C07A),
                        brandIcon: Icons.diamond_outlined,
                        brandIconColor: const Color(0xFFB8A9C9),
                        onPrimaryTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.dealChat),
                        primaryLabel: 'Continue Chat',
                        onSecondaryTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.campaignBrief),
                        secondaryLabel: 'Campaign',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: _fadeFor(5),
                    child: SlideTransition(
                      position: _slideFor(5),
                      child: _DealCard(
                        brand: MockDeals.inbox[2].brand,
                        subtitle: MockDeals.inbox[2].subtitle,
                        amount: MockDeals.inbox[2].amount,
                        statusLabel: MockDeals.inbox[2].statusLabel,
                        statusColor: AuraColors.sage,
                        brandIcon: Icons.flight_outlined,
                        brandIconColor: const Color(0xFF7EB5D6),
                        onPrimaryTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.dealDetails),
                        primaryLabel: 'View Details',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom nav
            _BottomNav(
              onHome: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.home),
              onDiscover: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.brandMarketplace),
              onInbox: () {},
              onProfile: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.profileBento),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Summary Strip ───
class _SummaryStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: AuraColors.obsidian.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryStat(value: MockDeals.newCount, label: 'New', color: const Color(0xFF7EB5D6)),
            Container(width: 1, height: 28, color: AuraColors.textPrimary.withOpacity(0.06)),
            _SummaryStat(value: MockDeals.activeCount, label: 'Active', color: AuraColors.sage),
            Container(width: 1, height: 28, color: AuraColors.textPrimary.withOpacity(0.06)),
            _SummaryStat(value: MockDeals.totalValue, label: 'Total', color: const Color(0xFFE8A87C)),
          ],
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 8,
            letterSpacing: 2,
            color: AuraColors.textPrimary.withOpacity(0.35),
          ),
        ),
      ],
    );
  }
}

// ─── Deal Card ───
class _DealCard extends StatefulWidget {
  const _DealCard({
    required this.brand,
    required this.subtitle,
    required this.amount,
    required this.statusLabel,
    required this.statusColor,
    required this.brandIcon,
    required this.brandIconColor,
    required this.onPrimaryTap,
    required this.primaryLabel,
    this.onSecondaryTap,
    this.secondaryLabel,
  });

  final String brand;
  final String subtitle;
  final String amount;
  final String statusLabel;
  final Color statusColor;
  final IconData brandIcon;
  final Color brandIconColor;
  final VoidCallback onPrimaryTap;
  final String primaryLabel;
  final VoidCallback? onSecondaryTap;
  final String? secondaryLabel;

  @override
  State<_DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<_DealCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPrimaryTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.brandIconColor.withOpacity(0.05),
                AuraColors.obsidian.withOpacity(0.8),
              ],
            ),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: widget.brandIconColor.withOpacity(0.1),
                    ),
                    child: Icon(widget.brandIcon,
                        size: 20, color: widget.brandIconColor),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.brand,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AuraColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 11,
                            color: AuraColors.textPrimary.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: widget.statusColor.withOpacity(0.1),
                      border: Border.all(
                          color: widget.statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      widget.statusLabel.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                        color: widget.statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                  height: 1,
                  color: AuraColors.textPrimary.withOpacity(0.04)),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'OFFER',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 2,
                          color: AuraColors.textPrimary.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.amount,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w200,
                          color: AuraColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (widget.onSecondaryTap != null)
                    GestureDetector(
                      onTap: widget.onSecondaryTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AuraColors.textPrimary.withOpacity(0.08)),
                        ),
                        child: Text(
                          widget.secondaryLabel!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1.5,
                            color: AuraColors.textPrimary.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: widget.onPrimaryTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AuraColors.sage,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.primaryLabel.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                          color: AuraColors.midnight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Bottom Nav (standardized) ───
class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.onHome,
    required this.onDiscover,
    required this.onInbox,
    required this.onProfile,
  });

  final VoidCallback onHome;
  final VoidCallback onDiscover;
  final VoidCallback onInbox;
  final VoidCallback onProfile;

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
              onTap: onHome),
          _NavItem(
              icon: Icons.explore,
              label: 'Discover',
              active: false,
              onTap: onDiscover),
          _NavItem(
              icon: Icons.forum,
              label: 'Inbox',
              active: true,
              onTap: onInbox),
          _NavItem(
              icon: Icons.account_circle,
              label: 'Profile',
              active: false,
              onTap: onProfile),
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
