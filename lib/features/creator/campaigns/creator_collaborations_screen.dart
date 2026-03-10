import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

// ─── Data models for collaboration entries ───
class _CollabEntry {
  const _CollabEntry({
    required this.brand,
    required this.campaign,
    required this.offer,
    required this.statusLabel,
    required this.statusColor,
    required this.icon,
    required this.iconColor,
    required this.filter,
    this.primaryLabel = 'VIEW DETAILS',
    this.hasChatAction = false,
  });

  final String brand;
  final String campaign;
  final String offer;
  final String statusLabel;
  final Color statusColor;
  final IconData icon;
  final Color iconColor;
  final String filter; // 'New' | 'Active' | 'Completed'
  final String primaryLabel;
  final bool hasChatAction;
}

const _kEntries = <_CollabEntry>[
  _CollabEntry(
    brand: 'Nykaa',
    campaign: 'Summer Glow Collection',
    offer: '₹37,500',
    statusLabel: 'New Offer',
    statusColor: Color(0xFF7EB5D6),
    icon: Icons.spa_outlined,
    iconColor: Color(0xFFE8A87C),
    filter: 'New',
    primaryLabel: 'VIEW DETAILS',
  ),
  _CollabEntry(
    brand: 'Mamaearth',
    campaign: 'Clean Beauty Campaign',
    offer: '₹26,600',
    statusLabel: 'In Review',
    statusColor: Color(0xFFE8C07A),
    icon: Icons.diamond_outlined,
    iconColor: Color(0xFFB8A9C9),
    filter: 'Active',
    primaryLabel: 'CONTINUE CHAT',
    hasChatAction: true,
  ),
  _CollabEntry(
    brand: 'MakeMyTrip',
    campaign: 'Luxury Travel Diaries',
    offer: '₹50,000',
    statusLabel: 'Accepted',
    statusColor: AuraColors.sage,
    icon: Icons.flight_outlined,
    iconColor: Color(0xFF7EB5D6),
    filter: 'Active',
    primaryLabel: 'VIEW DETAILS',
  ),
  _CollabEntry(
    brand: 'Zara Official',
    campaign: 'Summer Glow 2026',
    offer: '₹15,000',
    statusLabel: 'Completed',
    statusColor: AuraColors.sage,
    icon: Icons.checkroom_outlined,
    iconColor: AuraColors.sage,
    filter: 'Completed',
    primaryLabel: 'VIEW DETAILS',
  ),
  _CollabEntry(
    brand: 'FitLife',
    campaign: 'Yoga Essentials',
    offer: '₹8,000',
    statusLabel: 'Completed',
    statusColor: AuraColors.sage,
    icon: Icons.fitness_center,
    iconColor: AuraColors.sage,
    filter: 'Completed',
    primaryLabel: 'VIEW DETAILS',
  ),
];

class CreatorCollaborationsScreen extends StatefulWidget {
  const CreatorCollaborationsScreen({super.key});

  @override
  State<CreatorCollaborationsScreen> createState() =>
      _CreatorCollaborationsScreenState();
}

class _CreatorCollaborationsScreenState
    extends State<CreatorCollaborationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;

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

  List<_CollabEntry> get _filtered {
    return _kEntries.where((e) => e.filter == 'Active' || e.filter == 'Completed').toList();
  }

  int get _activeCount => _kEntries.where((e) => e.filter == 'Active').length;
  int get _completedCount => _kEntries.where((e) => e.filter == 'Completed').length;
  String get _totalEarnings => '₹1,37,100'; // Mock total

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // ── Header ──
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
                        'Collabs',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w200,
                          color: AuraColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed(AppRoutes.settings),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AuraColors.obsidian,
                          child: Icon(Icons.settings, size: 18, color: AuraColors.chrome),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Stats strip ──
            FadeTransition(
              opacity: _fadeFor(1),
              child: SlideTransition(
                position: _slideFor(1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AuraColors.obsidian.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AuraColors.textPrimary.withOpacity(0.05)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                            value: '$_activeCount',
                            label: 'Active',
                            color: AuraColors.sage),
                        _vDivider(),
                        _StatItem(
                            value: '$_completedCount',
                            label: 'Complete',
                            color: const Color(0xFF7EB5D6)),
                        _vDivider(),
                        _StatItem(
                            value: _totalEarnings,
                            label: 'Earnings',
                            color: AuraColors.sage),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Collab cards ──
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No approved collaborations yet',
                        style: TextStyle(
                          color: AuraColors.textPrimary.withOpacity(0.3),
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final entry = filtered[index];
                        return FadeTransition(
                          opacity: _fadeFor(3 + index),
                          child: SlideTransition(
                            position: _slideFor(3 + index),
                            child: _CollabCard(
                              entry: entry,
                              onPrimaryTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.creatorCollabDetails,
                                  arguments: {
                                    'brandName': entry.brand,
                                    'campaignTitle': entry.campaign,
                                    'status': entry.statusLabel,
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // ── Bottom Nav ──
            _BottomNav(
              onHome: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.home),
              onDiscover: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.brandMarketplace),
              onProfile: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.profileBento),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vDivider() => Container(
      width: 1, height: 24, color: AuraColors.textPrimary.withOpacity(0.06));
}

// ─── Stat Item ───
class _StatItem extends StatelessWidget {
  const _StatItem({
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

class _CollabCard extends StatefulWidget {
  const _CollabCard({
    required this.entry,
    required this.onPrimaryTap,
  });

  final _CollabEntry entry;
  final VoidCallback onPrimaryTap;

  @override
  State<_CollabCard> createState() => _CollabCardState();
}

class _CollabCardState extends State<_CollabCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
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
                e.iconColor.withOpacity(0.05),
                AuraColors.obsidian.withOpacity(0.8),
              ],
            ),
            border: Border.all(
                color: AuraColors.textPrimary.withOpacity(0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Brand + status row
              Row(
                children: <Widget>[
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: e.iconColor.withOpacity(0.1),
                    ),
                    child: Icon(e.icon, size: 20, color: e.iconColor),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          e.brand,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AuraColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${e.campaign} • ${e.offer}',
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
                      color: e.statusColor.withOpacity(0.1),
                      border: Border.all(
                          color: e.statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      e.statusLabel.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                        color: e.statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Compact details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        e.offer,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                          color: AuraColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right, color: AuraColors.sage.withOpacity(0.5)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Bottom Nav (4 items, no Inbox) ───
class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.onHome,
    required this.onDiscover,
    required this.onProfile,
  });

  final VoidCallback onHome;
  final VoidCallback onDiscover;
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
              icon: Icons.handshake_outlined,
              label: 'Collabs',
              active: true,
              onTap: () {}),
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
