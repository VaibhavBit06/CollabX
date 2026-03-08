import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

// ─── Data model for a social media post ───
class _SocialPost {
  _SocialPost({
    required this.caption,
    required this.platform,
    required this.likes,
    required this.comments,
    required this.timeAgo,
    required this.placeholderIcon,
    required this.accentColor,
    this.isPinned = false,
  });

  final String caption;
  final String platform; // 'Instagram', 'YouTube', etc.
  final String likes;
  final String comments;
  final String timeAgo;
  final IconData placeholderIcon;
  final Color accentColor;
  bool isPinned;
}

// ─── Bento tile shape definitions ───
enum _BentoShape { tall, wide, square }

// ─── Main Screen ───
class ProfileBentoScreen extends StatefulWidget {
  const ProfileBentoScreen({super.key});

  @override
  State<ProfileBentoScreen> createState() => _ProfileBentoScreenState();
}

class _ProfileBentoScreenState extends State<ProfileBentoScreen>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late AnimationController _meshController;
  late AnimationController _gradientRingController;

  bool _isAvailable = true;
  bool _isLoading = true;

  // Posts sourced from centralized mock data
  late final List<_SocialPost> _posts = MockProfile.posts
      .map((p) => _SocialPost(
            caption: p.caption,
            platform: 'Instagram',
            likes: p.likes,
            comments: p.comments,
            timeAgo: p.timeAgo,
            placeholderIcon: Icons.photo_outlined,
            accentColor: Color(p.color),
          ))
      .toList();

  final List<String> _nicheTags = MockProfile.nicheTags;

  // Bento layout pattern — repeats every 6 posts:
  // Row A: [tall] [square, square stacked]
  // Row B: [wide spanning full] or [square, square] [tall]
  // This creates the asymmetric bento look
  static const List<_BentoShape> _layoutPattern = [
    _BentoShape.tall,   // 0 — left tall
    _BentoShape.square,  // 1 — right top
    _BentoShape.square,  // 2 — right bottom
    _BentoShape.wide,    // 3 — full width wide
    _BentoShape.square,  // 4 — left top
    _BentoShape.square,  // 5 — left bottom
    _BentoShape.tall,    // 6 — right tall
    _BentoShape.wide,    // 7 — full width wide
  ];

  @override
  void initState() {
    super.initState();

    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _meshController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _gradientRingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _staggerController.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _meshController.dispose();
    _gradientRingController.dispose();
    super.dispose();
  }

  void _goHome(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);

  void _goDiscover(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(AppRoutes.brandMarketplace);

  void _goInbox(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(AppRoutes.dealsInbox);

  void _goSettings(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRoutes.settings);

  void _togglePin(int index) {
    HapticFeedback.mediumImpact();
    setState(() {
      _posts[index].isPinned = !_posts[index].isPinned;
    });
  }

  void _showPostPreview(_SocialPost post) {
    HapticFeedback.heavyImpact();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Preview',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => _FrostedPostPreview(post: post),
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  Animation<double> _fadeFor(int index) {
    final start = (index * 0.1).clamp(0.0, 0.7);
    final end = (start + 0.3).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _staggerController,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
  }

  Animation<Offset> _slideFor(int index) {
    final start = (index * 0.1).clamp(0.0, 0.7);
    final end = (start + 0.3).clamp(0.0, 1.0);
    return Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _staggerController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
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
              builder: (context, child) {
                return CustomPaint(
                  painter: _GradientMeshPainter(
                    progress: _meshController.value,
                  ),
                );
              },
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
                      onSettingsTap: () => _goSettings(context),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Bio block
                        FadeTransition(
                          opacity: _fadeFor(1),
                          child: SlideTransition(
                            position: _slideFor(1),
                            child: _buildBioBlock(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Niche tags
                        FadeTransition(
                          opacity: _fadeFor(2),
                          child: SlideTransition(
                            position: _slideFor(2),
                            child: _buildNicheTags(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Availability toggle
                        FadeTransition(
                          opacity: _fadeFor(3),
                          child: SlideTransition(
                            position: _slideFor(3),
                            child: _buildAvailabilityToggle(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Stats row
                        FadeTransition(
                          opacity: _fadeFor(4),
                          child: SlideTransition(
                            position: _slideFor(4),
                            child: _buildStatsRow(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Your Campaigns button
                        FadeTransition(
                          opacity: _fadeFor(5),
                          child: SlideTransition(
                            position: _slideFor(5),
                            child: _buildCampaignsButton(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Posts header
                        FadeTransition(
                          opacity: _fadeFor(6),
                          child: SlideTransition(
                            position: _slideFor(6),
                            child: _buildPostsHeader(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Bento grid
                        FadeTransition(
                          opacity: _fadeFor(7),
                          child: SlideTransition(
                            position: _slideFor(7),
                            child: _isLoading
                                ? _buildShimmerBento()
                                : _buildBentoGrid(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Booking CTA
                        FadeTransition(
                          opacity: _fadeFor(8),
                          child: SlideTransition(
                            position: _slideFor(8),
                            child: _buildBookingCTA(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _BottomNav(
                  onHome: () => _goHome(context),
                  onDiscover: () => _goDiscover(context),
                  onInbox: () => _goInbox(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Bio Block ──
  Widget _buildBioBlock() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.7),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        children: <Widget>[
          Stack(
            children: [
              AnimatedBuilder(
                animation: _gradientRingController,
                builder: (context, child) {
                  return Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        startAngle:
                            _gradientRingController.value * 2 * math.pi,
                        colors: [
                          AuraColors.sage,
                          AuraColors.sage.withOpacity(0.3),
                          AuraColors.textPrimary.withOpacity(0.2),
                          AuraColors.sage,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AuraColors.obsidian,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: ClipOval(
                        child: Container(
                          color: AuraColors.textPrimary.withOpacity(0.24),
                          child: Center(
                            child: Text(
                              'L',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w200,
                                color: AuraColors.chrome,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isAvailable ? Colors.green : Colors.orange,
                    border: Border.all(color: AuraColors.obsidian, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: (_isAvailable ? Colors.green : Colors.orange)
                            .withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  MockUser.fullName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 4),
                Text(
                  '${MockUser.handle} \u2022 ${MockUser.location}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AuraColors.sage.withOpacity(0.8),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  MockUser.bio,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AuraColors.textPrimary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Niche Tags ──
  Widget _buildNicheTags() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _nicheTags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AuraColors.sage.withOpacity(0.25)),
            ),
            child: Text(
              _nicheTags[index],
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: AuraColors.sage,
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Availability Toggle ──
  Widget _buildAvailabilityToggle() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _isAvailable = !_isAvailable);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: _isAvailable
              ? Colors.green.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isAvailable
                ? Colors.green.withOpacity(0.3)
                : Colors.orange.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isAvailable ? Colors.green : Colors.orange,
                boxShadow: [
                  BoxShadow(
                    color: (_isAvailable ? Colors.green : Colors.orange)
                        .withOpacity(0.5),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _isAvailable ? 'Open for Collabs' : 'Currently Booked',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _isAvailable
                      ? Colors.green.shade300
                      : Colors.orange.shade300,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isAvailable ? Icons.toggle_on : Icons.toggle_off,
                key: ValueKey(_isAvailable),
                size: 32,
                color: _isAvailable ? Colors.green : Colors.orange.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats Row ──
  Widget _buildStatsRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            height: 140,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AuraColors.sage,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'COMBINED REACH',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: AuraColors.midnight.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 8),
                _AnimatedCounter(
                  targetValue: 1200000,
                  suffix: '',
                  formatAsShort: true,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: AuraColors.midnight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Across 3 platforms',
                  style: TextStyle(
                    fontSize: 11,
                    color: AuraColors.midnight.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: <Widget>[
              _AnimatedSocialTile(
                icon: Icons.camera_alt,
                targetValue: 340000,
                delay: 200,
              ),
              const SizedBox(height: 12),
              _AnimatedSocialTile(
                icon: Icons.music_note,
                targetValue: 820000,
                delay: 400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Your Campaigns Button ──
  Widget _buildCampaignsButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.campaignBrief),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AuraColors.obsidian.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AuraColors.sage.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.campaign_outlined,
                color: AuraColors.sage,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Campaigns',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AuraColors.chrome,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '4 active \u2022 12 completed',
                    style: TextStyle(
                      fontSize: 11,
                      color: AuraColors.textPrimary.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AuraColors.textPrimary.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  // ── Posts Header ──
  Widget _buildPostsHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE1306C).withOpacity(0.15),
                const Color(0xFFF77737).withOpacity(0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.camera_alt, size: 12, color: Color(0xFFE1306C)),
              SizedBox(width: 6),
              Text(
                'INSTAGRAM',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE1306C),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Posts',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
        ),
        Text(
          'Long-press to preview',
          style: TextStyle(
            fontSize: 9,
            color: AuraColors.textPrimary.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  // ── Shimmer Bento Loading ──
  Widget _buildShimmerBento() {
    const g = 8.0;
    return Column(
      children: [
        // Row A: tall + 2 squares
        SizedBox(
          height: 240,
          child: Row(
            children: [
              Expanded(flex: 3, child: _ShimmerBox(height: 240, radius: 24)),
              const SizedBox(width: g),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(child: _ShimmerBox(height: double.infinity, radius: 20)),
                    const SizedBox(height: g),
                    Expanded(child: _ShimmerBox(height: double.infinity, radius: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: g),
        // Row B: wide
        _ShimmerBox(height: 130, radius: 24),
        const SizedBox(height: g),
        // Row C: 2 squares + tall
        SizedBox(
          height: 240,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(child: _ShimmerBox(height: double.infinity, radius: 20)),
                    const SizedBox(height: g),
                    Expanded(child: _ShimmerBox(height: double.infinity, radius: 20)),
                  ],
                ),
              ),
              const SizedBox(width: g),
              Expanded(flex: 3, child: _ShimmerBox(height: 240, radius: 24)),
            ],
          ),
        ),
      ],
    );
  }

  // ── Bento Grid ──
  // Layout pattern:
  //   Row A: [tall 3fr] [col: square, square  2fr]
  //   Row B: [wide full]
  //   Row C: [col: square, square  2fr] [tall 3fr]
  //   Row D: [wide full]
  //   ... repeat
  Widget _buildBentoGrid() {
    const g = 8.0; // gap
    final widgets = <Widget>[];
    int i = 0;

    while (i < _posts.length) {
      // Determine which row pattern to use
      final patternIndex = widgets.length % 4;

      if (patternIndex == 0 && i + 2 < _posts.length) {
        // Row A: tall left (3fr) + 2 squares right stacked (2fr)
        widgets.add(SizedBox(
          height: 260,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: _BentoPostTile(
                  post: _posts[i],
                  shape: _BentoShape.tall,
                  borderRadius: 24,
                  onLongPress: () => _showPostPreview(_posts[i]),
                  onDoubleTap: () => _togglePin(i),
                ),
              ),
              const SizedBox(width: g),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: _BentoPostTile(
                        post: _posts[i + 1],
                        shape: _BentoShape.square,
                        borderRadius: 20,
                        onLongPress: () => _showPostPreview(_posts[i + 1]),
                        onDoubleTap: () => _togglePin(i + 1),
                      ),
                    ),
                    const SizedBox(height: g),
                    Expanded(
                      child: _BentoPostTile(
                        post: _posts[i + 2],
                        shape: _BentoShape.square,
                        borderRadius: 20,
                        onLongPress: () => _showPostPreview(_posts[i + 2]),
                        onDoubleTap: () => _togglePin(i + 2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
        i += 3;
      } else if (patternIndex == 1 && i < _posts.length) {
        // Row B: wide full-width
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: g),
          child: SizedBox(
            height: 140,
            child: _BentoPostTile(
              post: _posts[i],
              shape: _BentoShape.wide,
              borderRadius: 24,
              onLongPress: () => _showPostPreview(_posts[i]),
              onDoubleTap: () => _togglePin(i),
            ),
          ),
        ));
        i += 1;
      } else if (patternIndex == 2 && i + 2 < _posts.length) {
        // Row C: 2 squares left (2fr) + tall right (3fr)  — mirror of A
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: g),
          child: SizedBox(
            height: 260,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: _BentoPostTile(
                          post: _posts[i],
                          shape: _BentoShape.square,
                          borderRadius: 20,
                          onLongPress: () => _showPostPreview(_posts[i]),
                          onDoubleTap: () => _togglePin(i),
                        ),
                      ),
                      const SizedBox(height: g),
                      Expanded(
                        child: _BentoPostTile(
                          post: _posts[i + 1],
                          shape: _BentoShape.square,
                          borderRadius: 20,
                          onLongPress: () => _showPostPreview(_posts[i + 1]),
                          onDoubleTap: () => _togglePin(i + 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: g),
                Expanded(
                  flex: 3,
                  child: _BentoPostTile(
                    post: _posts[i + 2],
                    shape: _BentoShape.tall,
                    borderRadius: 24,
                    onLongPress: () => _showPostPreview(_posts[i + 2]),
                    onDoubleTap: () => _togglePin(i + 2),
                  ),
                ),
              ],
            ),
          ),
        ));
        i += 3;
      } else if (patternIndex == 3 && i < _posts.length) {
        // Row D: wide full-width
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: g),
          child: SizedBox(
            height: 140,
            child: _BentoPostTile(
              post: _posts[i],
              shape: _BentoShape.wide,
              borderRadius: 24,
              onLongPress: () => _showPostPreview(_posts[i]),
              onDoubleTap: () => _togglePin(i),
            ),
          ),
        ));
        i += 1;
      } else {
        // Fallback: remaining posts as a row of squares
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: g),
          child: SizedBox(
            height: 130,
            child: _BentoPostTile(
              post: _posts[i],
              shape: _BentoShape.wide,
              borderRadius: 20,
              onLongPress: () => _showPostPreview(_posts[i]),
              onDoubleTap: () => _togglePin(i),
            ),
          ),
        ));
        i += 1;
      }
    }

    return Column(children: widgets);
  }

  Widget _buildBookingCTA() {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact options opening...')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AuraColors.chrome,
          foregroundColor: AuraColors.midnight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: const Text(
          'BOOKING / CONTACT',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─── Bento Post Tile ───
class _BentoPostTile extends StatefulWidget {
  const _BentoPostTile({
    required this.post,
    required this.shape,
    required this.borderRadius,
    required this.onLongPress,
    required this.onDoubleTap,
  });

  final _SocialPost post;
  final _BentoShape shape;
  final double borderRadius;
  final VoidCallback onLongPress;
  final VoidCallback onDoubleTap;

  @override
  State<_BentoPostTile> createState() => _BentoPostTileState();
}

class _BentoPostTileState extends State<_BentoPostTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isWide = widget.shape == _BentoShape.wide;
    final isTall = widget.shape == _BentoShape.tall;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onLongPress: widget.onLongPress,
      onDoubleTap: widget.onDoubleTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.post.isPinned
                  ? AuraColors.sage.withOpacity(0.5)
                  : AuraColors.textPrimary.withOpacity(0.06),
              width: widget.post.isPinned ? 2 : 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.post.accentColor.withOpacity(0.08),
                AuraColors.obsidian.withOpacity(0.9),
              ],
            ),
            boxShadow: widget.post.isPinned
                ? [
                    BoxShadow(
                      color: AuraColors.sage.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              // Post content area
              Positioned.fill(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius - 1),
                  child: _PostPlaceholder(
                    icon: widget.post.placeholderIcon,
                    accentColor: widget.post.accentColor,
                    isTall: isTall,
                  ),
                ),
              ),
              // Bottom gradient overlay
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: isWide ? 70 : (isTall ? 100 : 60),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(widget.borderRadius - 1),
                      bottomRight: Radius.circular(widget.borderRadius - 1),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AuraColors.midnight.withOpacity(0.95),
                      ],
                    ),
                  ),
                ),
              ),
              // Caption & engagement
              Positioned(
                left: 12,
                right: 12,
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isTall || isWide)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          widget.post.caption,
                          maxLines: isWide ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isTall ? 12 : 11,
                            fontWeight: FontWeight.w400,
                            color: AuraColors.textPrimary.withOpacity(0.85),
                            height: 1.3,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Icon(Icons.favorite_border,
                            size: 11, color: AuraColors.textPrimary.withOpacity(0.5)),
                        const SizedBox(width: 3),
                        Text(
                          widget.post.likes,
                          style: TextStyle(
                            fontSize: 10,
                            color: AuraColors.textPrimary.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chat_bubble_outline,
                            size: 10, color: AuraColors.textPrimary.withOpacity(0.4)),
                        const SizedBox(width: 3),
                        Text(
                          widget.post.comments,
                          style: TextStyle(
                            fontSize: 10,
                            color: AuraColors.textPrimary.withOpacity(0.4),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.post.timeAgo,
                          style: TextStyle(
                            fontSize: 9,
                            color: AuraColors.textPrimary.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Pin badge
              if (widget.post.isPinned)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AuraColors.sage,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AuraColors.sage.withOpacity(0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(Icons.push_pin,
                        size: 12, color: AuraColors.midnight),
                  ),
                ),
              // Platform badge (top-left)
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AuraColors.midnight.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.camera_alt,
                          size: 10, color: Color(0xFFE1306C)),
                      const SizedBox(width: 4),
                      Text(
                        widget.post.platform,
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                          color: AuraColors.textPrimary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Post placeholder visual ───
class _PostPlaceholder extends StatelessWidget {
  const _PostPlaceholder({
    required this.icon,
    required this.accentColor,
    required this.isTall,
  });

  final IconData icon;
  final Color accentColor;
  final bool isTall;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.3, -0.2),
          radius: 1.2,
          colors: [
            accentColor.withOpacity(0.12),
            accentColor.withOpacity(0.03),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: isTall ? 48 : 32,
          color: accentColor.withOpacity(0.2),
        ),
      ),
    );
  }
}

// ─── Header ───
class _Header extends StatelessWidget {
  const _Header({required this.onSettingsTap});

  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'My Portfolio',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share link copied!')),
                  );
                },
                icon: const Icon(Icons.ios_share, size: 20),
              ),
              GestureDetector(
                onTap: onSettingsTap,
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

// ─── Frosted Post Preview Modal ───
class _FrostedPostPreview extends StatelessWidget {
  const _FrostedPostPreview({required this.post});

  final _SocialPost post;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AuraColors.obsidian.withOpacity(0.8),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: RadialGradient(
                        center: const Alignment(0.2, -0.3),
                        radius: 1.0,
                        colors: [
                          post.accentColor.withOpacity(0.15),
                          post.accentColor.withOpacity(0.03),
                          Colors.transparent,
                        ],
                      ),
                      border: Border.all(
                          color: AuraColors.textPrimary.withOpacity(0.06)),
                    ),
                    child: Center(
                      child: Icon(
                        post.placeholderIcon,
                        size: 56,
                        color: post.accentColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Platform badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1306C).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.camera_alt,
                            size: 12, color: Color(0xFFE1306C)),
                        const SizedBox(width: 6),
                        Text(
                          post.platform,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE1306C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post.caption,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AuraColors.chrome,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Engagement stats
                  Row(
                    children: [
                      Icon(Icons.favorite,
                          size: 16,
                          color: post.accentColor.withOpacity(0.7)),
                      const SizedBox(width: 6),
                      Text(
                        post.likes,
                        style: TextStyle(
                          fontSize: 14,
                          color: AuraColors.chrome.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.chat_bubble,
                          size: 14,
                          color: AuraColors.textPrimary.withOpacity(0.4)),
                      const SizedBox(width: 6),
                      Text(
                        post.comments,
                        style: TextStyle(
                          fontSize: 14,
                          color: AuraColors.chrome.withOpacity(0.6),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          fontSize: 12,
                          color: AuraColors.textPrimary.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Tap anywhere to dismiss',
                      style: TextStyle(
                        fontSize: 11,
                        color: AuraColors.textPrimary.withOpacity(0.25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Animated Counter ───
class _AnimatedCounter extends StatefulWidget {
  const _AnimatedCounter({
    required this.targetValue,
    required this.suffix,
    required this.formatAsShort,
    required this.style,
  });

  final int targetValue;
  final String suffix;
  final bool formatAsShort;
  final TextStyle style;

  @override
  State<_AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<_AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatNumber(int value) {
    if (!widget.formatAsShort) return value.toString();
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}k';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final cur = (_animation.value * widget.targetValue).round();
        return Text(
          '${_formatNumber(cur)}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}

// ─── Animated Social Tile ───
class _AnimatedSocialTile extends StatefulWidget {
  const _AnimatedSocialTile({
    required this.icon,
    required this.targetValue,
    required this.delay,
  });

  final IconData icon;
  final int targetValue;
  final int delay;

  @override
  State<_AnimatedSocialTile> createState() => _AnimatedSocialTileState();
}

class _AnimatedSocialTileState extends State<_AnimatedSocialTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(Duration(milliseconds: 600 + widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatShort(int val) {
    if (val >= 1000000) return '${(val / 1000000).toStringAsFixed(1)}M';
    if (val >= 1000) return '${(val / 1000).toStringAsFixed(0)}k';
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final cur = (_animation.value * widget.targetValue).round();
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(widget.icon, size: 16, color: AuraColors.textPrimary.withOpacity(0.7)),
                const SizedBox(width: 8),
                Text(
                  _formatShort(cur),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─── Shimmer Box ───
class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox({required this.height, this.radius = 24});

  final double height;
  final double radius;

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(-1.0 + 2.0 * _controller.value + 1.0, 0),
              colors: [
                AuraColors.obsidian.withOpacity(0.5),
                AuraColors.obsidian.withOpacity(0.8),
                AuraColors.obsidian.withOpacity(0.5),
              ],
            ),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
          ),
        );
      },
    );
  }
}

// ─── Animated Gradient Mesh Background ───
class _GradientMeshPainter extends CustomPainter {
  _GradientMeshPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final cx1 = size.width * (0.3 + 0.15 * math.sin(progress * 2 * math.pi));
    final cy1 =
        size.height * (0.2 + 0.1 * math.cos(progress * 2 * math.pi));
    paint.shader = RadialGradient(
      colors: [
        AuraColors.sage.withOpacity(0.06),
        AuraColors.sage.withOpacity(0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset(cx1, cy1), radius: 200));
    canvas.drawCircle(Offset(cx1, cy1), 200, paint);

    final cx2 = size.width *
        (0.7 + 0.12 * math.cos(progress * 2 * math.pi + 1.5));
    final cy2 = size.height *
        (0.6 + 0.15 * math.sin(progress * 2 * math.pi + 1.0));
    paint.shader = RadialGradient(
      colors: [
        const Color(0xFF4A7C6F).withOpacity(0.04),
        const Color(0xFF4A7C6F).withOpacity(0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset(cx2, cy2), radius: 180));
    canvas.drawCircle(Offset(cx2, cy2), 180, paint);

    final cx3 = size.width *
        (0.5 + 0.2 * math.sin(progress * 2 * math.pi + 3.0));
    final cy3 = size.height *
        (0.8 + 0.08 * math.cos(progress * 2 * math.pi + 2.0));
    paint.shader = RadialGradient(
      colors: [
        AuraColors.sage.withOpacity(0.03),
        AuraColors.sage.withOpacity(0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset(cx3, cy3), radius: 160));
    canvas.drawCircle(Offset(cx3, cy3), 160, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientMeshPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ─── Bottom Nav ───
class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.onHome,
    required this.onDiscover,
    required this.onInbox,
  });

  final VoidCallback onHome;
  final VoidCallback onDiscover;
  final VoidCallback onInbox;

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
              icon: Icons.forum_outlined,
              label: 'Inbox',
              active: false,
              onTap: onInbox),
          _NavItem(
              icon: Icons.account_circle,
              label: 'Profile',
              active: true,
              onTap: () {}),
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
