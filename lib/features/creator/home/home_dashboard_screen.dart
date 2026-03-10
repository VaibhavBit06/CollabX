import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late AnimationController _meshController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..forward();

    _meshController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _meshController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Animation<double> _fadeFor(int i) {
    final s = (i * 0.08).clamp(0.0, 0.7);
    final e = (s + 0.3).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _staggerController,
      curve: Interval(s, e, curve: Curves.easeOut),
    );
  }

  Animation<Offset> _slideFor(int i) {
    final s = (i * 0.08).clamp(0.0, 0.7);
    final e = (s + 0.3).clamp(0.0, 1.0);
    return Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _staggerController,
      curve: Interval(s, e, curve: Curves.easeOutCubic),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: Stack(
        children: [
          // Animated gradient mesh background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _meshController,
              builder: (context, child) => CustomPaint(
                painter: _MeshPainter(progress: _meshController.value),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                FadeTransition(
                  opacity: _fadeFor(0),
                  child: SlideTransition(
                    position: _slideFor(0),
                    child: _Header(
                      onTapSettings: () =>
                          Navigator.of(context).pushNamed(AppRoutes.settings),
                      onTapWallet: () =>
                          Navigator.of(context).pushNamed(AppRoutes.wallet),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Greeting card
                        FadeTransition(
                          opacity: _fadeFor(1),
                          child: SlideTransition(
                            position: _slideFor(1),
                            child: _GreetingCard(
                                pulseController: _pulseController),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Total Earned card
                        FadeTransition(
                          opacity: _fadeFor(2),
                          child: SlideTransition(
                            position: _slideFor(2),
                            child: _EarnedCard(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Metric tiles row
                        FadeTransition(
                          opacity: _fadeFor(3),
                          child: SlideTransition(
                            position: _slideFor(3),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: _MetricTile(
                                    label: 'Total Campaigns',
                                    value: MockWallet.campaignsCompleted,
                                    delta: '+2 new',
                                    icon: Icons.campaign_outlined,
                                    accentColor: const Color(0xFF7EB5D6),
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(AppRoutes.campaignBrief),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _MetricTile(
                                    label: 'My Following',
                                    value: '124K',
                                    delta: '+3.2%',
                                    icon: Icons.people_outline,
                                    accentColor: const Color(0xFFE8A87C),
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(AppRoutes.platformGrowth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Quick actions
                        FadeTransition(
                          opacity: _fadeFor(4),
                          child: SlideTransition(
                            position: _slideFor(4),
                            child: _QuickActionsRow(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Recent activity
                        FadeTransition(
                          opacity: _fadeFor(5),
                          child: SlideTransition(
                            position: _slideFor(5),
                            child: Text(
                              'RECENT ACTIVITY',
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w600,
                                color: AuraColors.textPrimary.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FadeTransition(
                          opacity: _fadeFor(6),
                          child: SlideTransition(
                            position: _slideFor(6),
                            child: _ActivityCard(
                              icon: Icons.verified,
                              iconColor: const Color(0xFF7EB5D6),
                              title: MockActivities.recent[0].title,
                              subtitle: MockActivities.recent[0].timeAgo,
                              trailing: 'VIEW',
                              onTap: () => Navigator.of(context)
                                  .pushNamed(AppRoutes.creatorCollaborations),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _fadeFor(7),
                          child: SlideTransition(
                            position: _slideFor(7),
                            child: _ActivityCard(
                              icon: Icons.payments_outlined,
                              iconColor: AuraColors.sage,
                              title: MockActivities.recent[1].title,
                              subtitle: MockActivities.recent[1].timeAgo,
                              trailing: MockActivities.recent[1].trailing,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(AppRoutes.wallet),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _fadeFor(8),
                          child: SlideTransition(
                            position: _slideFor(8),
                            child: _ActivityCard(
                              icon: Icons.trending_up,
                              iconColor: const Color(0xFFE8A87C),
                              title: MockActivities.recent[2].title,
                              subtitle: MockActivities.recent[2].timeAgo,
                              trailing: MockActivities.recent[2].trailing,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(AppRoutes.platformGrowth),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _BottomNav(
                  onHome: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.home),
                  onDiscover: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.brandMarketplace),
                  onCollabs: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.creatorCollaborations),
                  onProfile: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.profileBento),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Greeting Card ───
class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.pulseController});

  final AnimationController pulseController;

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AuraColors.sage.withOpacity(0.12),
            AuraColors.obsidian.withOpacity(0.8),
          ],
        ),
        border: Border.all(color: AuraColors.sage.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: pulseController,
                builder: (context, child) {
                  return Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AuraColors.sage
                          .withOpacity(0.5 + 0.5 * pulseController.value),
                      boxShadow: [
                        BoxShadow(
                          color: AuraColors.sage
                              .withOpacity(0.3 * pulseController.value),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              Text(
                _greeting.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600,
                  color: AuraColors.sage.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            MockUser.firstName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w200,
              color: AuraColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have 2 pending offers and 1 payment to review.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header ───
class _Header extends StatelessWidget {
  const _Header({required this.onTapSettings, required this.onTapWallet});

  final VoidCallback onTapSettings;
  final VoidCallback onTapWallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w200,
              color: AuraColors.textPrimary,
            ),
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications coming soon')),
                  );
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AuraColors.obsidian.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AuraColors.textPrimary.withOpacity(0.06)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.notifications_none,
                            color: AuraColors.textPrimary.withOpacity(0.7),
                            size: 18),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFF6B6B),
                            border: Border.all(
                                color: AuraColors.midnight, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onTapWallet,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AuraColors.sage.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: AuraColors.sage.withOpacity(0.25)),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AuraColors.sage,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onTapSettings,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AuraColors.obsidian,
                  child: const Icon(Icons.settings, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Earned Card ───
class _EarnedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.wallet),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AuraColors.sage.withOpacity(0.2),
              AuraColors.obsidian.withOpacity(0.9),
              AuraColors.midnight,
            ],
          ),
          border: Border.all(color: AuraColors.sage.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL EARNED',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: AuraColors.textPrimary.withOpacity(0.4),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AuraColors.sage.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_balance_wallet_outlined,
                          size: 10, color: AuraColors.sage.withOpacity(0.8)),
                      const SizedBox(width: 4),
                      Text(
                        'Lifetime',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AuraColors.sage.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              MockWallet.lifetimeEarnings,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w200,
                color: AuraColors.textPrimary,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            // Mini bar chart — visual sparkline
            Row(
              children: [
                for (int i = 0; i < 7; i++) ...[
                  Expanded(
                    child: Container(
                      height: [18.0, 24.0, 20.0, 32.0, 26.0, 34.0, 40.0][i],
                      decoration: BoxDecoration(
                        color: AuraColors.sage
                            .withOpacity(i == 6 ? 0.6 : 0.15 + i * 0.04),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  if (i < 6) const SizedBox(width: 4),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              MockWallet.monthlyEarnings,
              style: TextStyle(
                fontSize: 11,
                color: AuraColors.sage.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Metric Tile ───
class _MetricTile extends StatefulWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.delta,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  final String label;
  final String value;
  final String delta;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  State<_MetricTile> createState() => _MetricTileState();
}

class _MetricTileState extends State<_MetricTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.accentColor.withOpacity(0.08),
                AuraColors.obsidian.withOpacity(0.8),
              ],
            ),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.icon,
                        size: 16, color: widget.accentColor.withOpacity(0.8)),
                  ),
                  Text(
                    widget.delta,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AuraColors.sage.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.label.toUpperCase(),
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: AuraColors.textPrimary.withOpacity(0.35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quick Actions Row ───
class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: Icons.campaign_outlined,
            label: 'Campaigns',
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.campaignBrief),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.explore_outlined,
            label: 'Discover',
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.brandMarketplace),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Wallet',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.wallet),
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatefulWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<_QuickAction> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AuraColors.obsidian.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
          ),
          child: Column(
            children: [
              Icon(widget.icon,
                  size: 22, color: AuraColors.textPrimary.withOpacity(0.6)),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: AuraColors.textPrimary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Activity Card ───
class _ActivityCard extends StatefulWidget {
  const _ActivityCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String trailing;
  final VoidCallback onTap;

  @override
  State<_ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<_ActivityCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AuraColors.obsidian.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: widget.iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(widget.icon, color: widget.iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AuraColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.5,
                        color: AuraColors.textPrimary.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.trailing,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AuraColors.sage.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Gradient Mesh Background ───
class _MeshPainter extends CustomPainter {
  _MeshPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final cx1 = size.width * (0.25 + 0.15 * math.sin(progress * 2 * math.pi));
    final cy1 = size.height * (0.15 + 0.1 * math.cos(progress * 2 * math.pi));
    paint.shader = RadialGradient(colors: [
      AuraColors.sage.withOpacity(0.05),
      AuraColors.sage.withOpacity(0.0),
    ]).createShader(Rect.fromCircle(center: Offset(cx1, cy1), radius: 180));
    canvas.drawCircle(Offset(cx1, cy1), 180, paint);

    final cx2 =
        size.width * (0.75 + 0.1 * math.cos(progress * 2 * math.pi + 1.5));
    final cy2 =
        size.height * (0.5 + 0.12 * math.sin(progress * 2 * math.pi + 1));
    paint.shader = RadialGradient(colors: [
      const Color(0xFF4A7C6F).withOpacity(0.04),
      const Color(0xFF4A7C6F).withOpacity(0.0),
    ]).createShader(Rect.fromCircle(center: Offset(cx2, cy2), radius: 160));
    canvas.drawCircle(Offset(cx2, cy2), 160, paint);
  }

  @override
  bool shouldRepaint(covariant _MeshPainter old) => old.progress != progress;
}

// ─── Bottom Nav ───
class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.onHome,
    required this.onDiscover,
    required this.onCollabs,
    required this.onProfile,
  });

  final VoidCallback onHome;
  final VoidCallback onDiscover;
  final VoidCallback onCollabs;
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
              icon: Icons.home, label: 'Home', active: true, onTap: onHome),
          _NavItem(
              icon: Icons.explore,
              label: 'Discover',
              active: false,
              onTap: onDiscover),
          _NavItem(
              icon: Icons.handshake_outlined,
              label: 'Collabs',
              active: false,
              onTap: onCollabs),
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
