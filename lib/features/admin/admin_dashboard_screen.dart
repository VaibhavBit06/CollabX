import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/auth_service.dart';

// Admin sub-panels
import 'package:aura_influencer_portfolio/features/admin/creators/admin_creators_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/brands/admin_brands_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/campaigns/admin_campaigns_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/deliverables/admin_deliverables_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/payments/admin_payments_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/kyc/admin_kyc_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/disputes/admin_disputes_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/analytics/admin_analytics_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _meshController;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.dashboard_outlined, 'Overview'),
    _NavItem(Icons.people_outline, 'Creators'),
    _NavItem(Icons.business_outlined, 'Brands'),
    _NavItem(Icons.campaign_outlined, 'Campaigns'),
    _NavItem(Icons.assignment_outlined, 'Deliverables'),
    _NavItem(Icons.payments_outlined, 'Payments'),
    _NavItem(Icons.verified_user_outlined, 'KYC'),
    _NavItem(Icons.gavel_outlined, 'Disputes'),
    _NavItem(Icons.analytics_outlined, 'Analytics'),
  ];

  @override
  void initState() {
    super.initState();
    _meshController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _meshController.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    switch (_selectedIndex) {
      case 0: return const _OverviewPanel();
      case 1: return const AdminCreatorsScreen();
      case 2: return const AdminBrandsScreen();
      case 3: return const AdminCampaignsScreen();
      case 4: return const AdminDeliverablesScreen();
      case 5: return const AdminPaymentsScreen();
      case 6: return const AdminKycScreen();
      case 7: return const AdminDisputesScreen();
      case 8: return const AdminAnalyticsScreen();
      default: return const _OverviewPanel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: AuraColors.midnight,
      drawer: isWide ? null : _buildDrawer(),
      body: Stack(
        children: [
          // Mesh background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _meshController,
              builder: (context, _) => CustomPaint(
                painter: _MeshPainter(progress: _meshController.value),
              ),
            ),
          ),
          SafeArea(
            child: isWide ? _buildDesktopLayout() : _buildMobileLayout(),
          ),
        ],
      ),
    );
  }

  // ── Desktop: Sidebar + Content ──
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        _buildSidebar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _buildPanel(),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.6),
        border: Border(right: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Logo / Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: AuraColors.sage.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.shield, color: AuraColors.sage, size: 16),
                ),
                const SizedBox(width: 10),
                Text('CollabX', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: AuraColors.chrome, letterSpacing: 2)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('ADMIN CONSOLE', style: TextStyle(fontSize: 8, letterSpacing: 3, color: AuraColors.sage.withOpacity(0.5), fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
          // Nav items
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                final item = _navItems[index];
                final isActive = _selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: InkWell(
                    onTap: () => setState(() => _selectedIndex = index),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isActive ? AuraColors.sage.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: isActive ? Border.all(color: AuraColors.sage.withOpacity(0.15)) : null,
                      ),
                      child: Row(
                        children: [
                          Icon(item.icon, size: 18, color: isActive ? AuraColors.sage : AuraColors.chrome.withOpacity(0.4)),
                          const SizedBox(width: 12),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isActive ? FontWeight.w500 : FontWeight.w300,
                              color: isActive ? AuraColors.sage : AuraColors.chrome.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () async {
                await AuthService.instance.signOut();
                if (mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.authWelcome, (route) => false);
                }
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFF6B6B).withOpacity(0.15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, size: 16, color: Color(0xFFFF6B6B)),
                    const SizedBox(width: 8),
                    Text('Log Out', style: TextStyle(fontSize: 12, color: const Color(0xFFFF6B6B).withOpacity(0.8))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Mobile: Hamburger + Content ──
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMobileHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: _buildPanel(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: AuraColors.sage),
            ),
          ),
          Column(
            children: [
              Text('CollabX', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: AuraColors.chrome, letterSpacing: 2)),
              Text('ADMIN', style: TextStyle(fontSize: 8, letterSpacing: 3, color: AuraColors.sage.withOpacity(0.5), fontWeight: FontWeight.w600)),
            ],
          ),
          IconButton(
            onPressed: () async {
              await AuthService.instance.signOut();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.authWelcome, (route) => false);
              }
            },
            icon: Icon(Icons.logout, color: AuraColors.chrome.withOpacity(0.4), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AuraColors.obsidian,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: AuraColors.sage.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.shield, color: AuraColors.sage, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Text('Admin Console', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _navItems.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final item = _navItems[index];
                  final isActive = _selectedIndex == index;
                  return ListTile(
                    leading: Icon(item.icon, size: 20, color: isActive ? AuraColors.sage : AuraColors.chrome.withOpacity(0.4)),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isActive ? FontWeight.w500 : FontWeight.w300,
                        color: isActive ? AuraColors.sage : AuraColors.chrome.withOpacity(0.6),
                      ),
                    ),
                    selected: isActive,
                    selectedTileColor: AuraColors.sage.withOpacity(0.08),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Overview Panel ──
class _OverviewPanel extends StatelessWidget {
  const _OverviewPanel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
          const SizedBox(height: 4),
          Text('Welcome back, Admin. Here\'s the platform snapshot.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
          const SizedBox(height: 24),
          // Metrics row
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 500;
              if (isNarrow) {
                return Column(
                  children: [
                    Row(children: [
                      Expanded(child: _MetricCard(icon: Icons.people, label: 'Total Creators', value: '1,284', color: AuraColors.sage)),
                      const SizedBox(width: 10),
                      Expanded(child: _MetricCard(icon: Icons.business, label: 'Total Brands', value: '342', color: const Color(0xFF7EB5D6))),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: _MetricCard(icon: Icons.campaign, label: 'Live Campaigns', value: '86', color: const Color(0xFFE8A87C))),
                      const SizedBox(width: 10),
                      Expanded(child: _MetricCard(icon: Icons.account_balance, label: 'Escrow Balance', value: '₹2,44,100', color: AuraColors.sage)),
                    ]),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: _MetricCard(icon: Icons.people, label: 'Total Creators', value: '1,284', color: AuraColors.sage)),
                  const SizedBox(width: 10),
                  Expanded(child: _MetricCard(icon: Icons.business, label: 'Total Brands', value: '342', color: const Color(0xFF7EB5D6))),
                  const SizedBox(width: 10),
                  Expanded(child: _MetricCard(icon: Icons.campaign, label: 'Live Campaigns', value: '86', color: const Color(0xFFE8A87C))),
                  const SizedBox(width: 10),
                  Expanded(child: _MetricCard(icon: Icons.account_balance, label: 'Escrow Balance', value: '₹2,44,100', color: AuraColors.sage)),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          // Quick actions
          Text('QUICK ACTIONS', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.3))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _QuickActionChip(icon: Icons.assignment, label: '3 Pending Deliverables'),
              _QuickActionChip(icon: Icons.payments, label: '2 Payments Stuck'),
              _QuickActionChip(icon: Icons.verified_user, label: '3 KYC Pending'),
              _QuickActionChip(icon: Icons.gavel, label: '2 Open Disputes'),
            ],
          ),
          const SizedBox(height: 24),
          // Recent activity
          Text('RECENT PLATFORM ACTIVITY', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.3))),
          const SizedBox(height: 12),
          ..._recentActivities.map((a) => _ActivityTile(activity: a)),
        ],
      ),
    );
  }

  static final List<Map<String, dynamic>> _recentActivities = [
    {'icon': Icons.person_add, 'title': 'New creator registered', 'subtitle': 'Priya Sharma (@priyastyle)', 'time': '2m ago', 'color': AuraColors.sage},
    {'icon': Icons.campaign, 'title': 'Campaign published', 'subtitle': 'Summer Glow 2026 by Aura Essence', 'time': '15m ago', 'color': const Color(0xFF7EB5D6)},
    {'icon': Icons.payments, 'title': 'Payment received', 'subtitle': '₹37,500 from TechNova → escrow', 'time': '1h ago', 'color': AuraColors.sage},
    {'icon': Icons.check_circle, 'title': 'KYC approved', 'subtitle': 'Zara Khan (@zarafashion)', 'time': '2h ago', 'color': AuraColors.sage},
    {'icon': Icons.warning_amber, 'title': 'Dispute opened', 'subtitle': 'Aura Essence vs Sohail Khan', 'time': '3h ago', 'color': const Color(0xFFFF6B6B)},
  ];
}

// ── Sub Widgets ──

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon;
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.08), AuraColors.obsidian.withOpacity(0.6)],
        ),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
          const SizedBox(height: 2),
          Text(label.toUpperCase(), style: TextStyle(fontSize: 8, letterSpacing: 1.5, color: AuraColors.chrome.withOpacity(0.35))),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AuraColors.sage.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AuraColors.sage.withOpacity(0.7)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});
  final Map<String, dynamic> activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: (activity['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(activity['icon'] as IconData, size: 14, color: activity['color'] as Color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['title'], style: TextStyle(fontSize: 13, color: AuraColors.chrome, fontWeight: FontWeight.w400)),
                Text(activity['subtitle'], style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.35))),
              ],
            ),
          ),
          Text(activity['time'], style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.25))),
        ],
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
    canvas.drawRect(Offset.zero & size, paint..color = AuraColors.midnight);

    final p1 = Offset(
      size.width * (0.15 + 0.1 * math.sin(progress * 2 * math.pi)),
      size.height * (0.2 + 0.1 * math.cos(progress * 2 * math.pi)),
    );
    canvas.drawCircle(
      p1, size.width * 0.6,
      paint..shader = RadialGradient(
        colors: [AuraColors.sage.withOpacity(0.04), AuraColors.sage.withOpacity(0)],
      ).createShader(Rect.fromCircle(center: p1, radius: size.width * 0.6)),
    );

    final p2 = Offset(
      size.width * (0.85 + 0.08 * math.cos(progress * 2 * math.pi)),
      size.height * (0.7 + 0.08 * math.sin(progress * 2 * math.pi)),
    );
    canvas.drawCircle(
      p2, size.width * 0.5,
      paint..shader = RadialGradient(
        colors: [const Color(0xFF7EB5D6).withOpacity(0.03), const Color(0xFF7EB5D6).withOpacity(0)],
      ).createShader(Rect.fromCircle(center: p2, radius: size.width * 0.5)),
    );
  }

  @override
  bool shouldRepaint(_MeshPainter old) => old.progress != progress;
}
