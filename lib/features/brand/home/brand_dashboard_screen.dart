import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class BrandDashboardScreen extends StatefulWidget {
  const BrandDashboardScreen({super.key});

  @override
  State<BrandDashboardScreen> createState() => _BrandDashboardScreenState();
}

class _BrandDashboardScreenState extends State<BrandDashboardScreen>
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
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGreeting(),
                        const SizedBox(height: 24),
                        _buildMainMetrics(),
                        const SizedBox(height: 24),
                        _buildQuickActions(),
                        const SizedBox(height: 32),
                        _buildRecentCampaigns(),
                      ],
                    ),
                  ),
                ),
                _buildBottomNav(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeFor(0),
      child: SlideTransition(
        position: _slideFor(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AuraColors.obsidian,
                child: Icon(Icons.business_center, color: AuraColors.sage, size: 20),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications coming soon')),
                  );
                },
                icon: Icon(Icons.notifications_none, color: AuraColors.chrome),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return FadeTransition(
      opacity: _fadeFor(1),
      child: SlideTransition(
        position: _slideFor(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aura Essence',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 4,
                fontWeight: FontWeight.w600,
                color: AuraColors.sage.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Campaign Cockpit',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w200,
                color: AuraColors.chrome,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMetrics() {
    return FadeTransition(
      opacity: _fadeFor(2),
      child: SlideTransition(
        position: _slideFor(2),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AuraColors.obsidian.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MetricItem(label: 'TOTAL SPEND', value: '₹42,500', trend: '+12%'),
                  _MetricItem(label: 'ACTIVE DEALS', value: '08', trend: ''),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white10),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MetricItem(label: 'APPLICATIONS', value: '124', trend: '+24'),
                  _MetricItem(label: 'REACH EST.', value: '1.2M', trend: '+5%'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return FadeTransition(
      opacity: _fadeFor(3),
      child: SlideTransition(
        position: _slideFor(3),
        child: Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: Icons.add_circle_outline,
                label: 'New Campaign',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.addCampaign),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickAction(
                icon: Icons.search,
                label: 'Find Creators',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.creatorsList),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCampaigns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _fadeFor(4),
          child: SlideTransition(
            position: _slideFor(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ACTIVE CAMPAIGNS',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                    color: AuraColors.textPrimary.withOpacity(0.4),
                  ),
                ),
                Text(
                  'VIEW ALL',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: AuraColors.sage,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeTransition(
          opacity: _fadeFor(5),
          child: SlideTransition(
            position: _slideFor(5),
            child: _CampaignCard(
              title: 'Summer Glow 2026',
              budget: '₹15,000',
              applicants: 42,
              status: 'Active',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.manageCampaigns),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: _fadeFor(6),
          child: SlideTransition(
            position: _slideFor(6),
            child: _CampaignCard(
              title: 'Tech Unboxing Series',
              budget: '₹25,000',
              applicants: 18,
              status: 'Pending Review',
              isUrgent: true,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.manageCampaigns),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AuraColors.midnight,
        border: Border(top: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home_filled,
            label: 'Home',
            isActive: true,
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.brandDashboard),
          ),
          _BottomNavItem(
            icon: Icons.campaign_outlined,
            label: 'Campaigns',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.manageCampaigns),
          ),
          _BottomNavItem(
            icon: Icons.people_outline,
            label: 'Creators',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.creatorsList),
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Settings',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.brandSettings),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AuraColors.sage : AuraColors.chrome.withOpacity(0.4);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.label, required this.value, required this.trend});
  final String label, value, trend;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 2,
            color: AuraColors.textPrimary.withOpacity(0.4),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: AuraColors.chrome,
                fontWeight: FontWeight.w200,
              ),
            ),
            if (trend.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                trend,
                style: const TextStyle(
                  fontSize: 10,
                  color: AuraColors.sage,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AuraColors.sage.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AuraColors.sage.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AuraColors.sage, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1,
                color: AuraColors.chrome,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({
    required this.title,
    required this.budget,
    required this.applicants,
    required this.status,
    this.isUrgent = false,
    this.onTap,
  });

  final String title, budget, status;
  final int applicants;
  final bool isUrgent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isUrgent ? AuraColors.sage.withOpacity(0.3) : AuraColors.textPrimary.withOpacity(0.06)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: AuraColors.chrome, fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _Tag(label: budget),
                      const SizedBox(width: 8),
                      _Tag(label: '$applicants Applied'),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.chevron_right, color: AuraColors.chrome, size: 20),
                const SizedBox(height: 8),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: isUrgent ? AuraColors.sage : AuraColors.chrome.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AuraColors.midnight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.5), fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  _MeshPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rect = Offset.zero & size;

    // Deep midnight base
    canvas.drawRect(rect, paint..color = AuraColors.midnight);

    final p1 = Offset(
      size.width * (0.2 + 0.1 * math.sin(progress * 2 * math.pi)),
      size.height * (0.3 + 0.1 * math.cos(progress * 2 * math.pi)),
    );
    canvas.drawCircle(
      p1,
      size.width * 0.8,
      paint
        ..shader = RadialGradient(
          colors: [
            AuraColors.sage.withOpacity(0.05),
            AuraColors.sage.withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: p1, radius: size.width * 0.8)),
    );

    final p2 = Offset(
      size.width * (0.8 + 0.1 * math.cos(progress * 2 * math.pi)),
      size.height * (0.1 + 0.1 * math.sin(progress * 2 * math.pi)),
    );
    canvas.drawCircle(
      p2,
      size.width * 0.6,
      paint
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF7EB5D6).withOpacity(0.03),
            const Color(0xFF7EB5D6).withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: p2, radius: size.width * 0.6)),
    );
  }

  @override
  bool shouldRepaint(_MeshPainter oldDelegate) => oldDelegate.progress != progress;
}
