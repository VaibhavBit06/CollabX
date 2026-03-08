import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  Animation<double> _fadeFor(int i) {
    final s = (i * 0.12).clamp(0.0, 0.7);
    final e = (s + 0.3).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _staggerController,
      curve: Interval(s, e, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeNotifier.instance.isDark;

    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            FadeTransition(
              opacity: _fadeFor(0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AuraColors.sage,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'App Theme',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AuraColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Choose your visual style',
                      style: TextStyle(
                        fontSize: 14,
                        color: AuraColors.textPrimary.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Theme cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _fadeFor(1),
                      child: _ThemeCard(
                        name: 'Midnight',
                        description: 'Deep, dark elegance',
                        isSelected: isDark,
                        previewColors: const [
                          Color(0xFF0A0A0B),
                          Color(0xFF1C1C1E),
                          Color(0xFF9DB4A0),
                          Color(0xFFE5E7EB),
                        ],
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          ThemeNotifier.instance.setDark();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _fadeFor(2),
                      child: _ThemeCard(
                        name: 'Aurora',
                        description: 'Warm, luminous clarity',
                        isSelected: !isDark,
                        previewColors: const [
                          Color(0xFFF8F7F4),
                          Color(0xFFFFFFFF),
                          Color(0xFF9DB4A0),
                          Color(0xFF2D2D2D),
                        ],
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          ThemeNotifier.instance.setLight();
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeCard extends StatefulWidget {
  const _ThemeCard({
    required this.name,
    required this.description,
    required this.isSelected,
    required this.previewColors,
    required this.onTap,
  });

  final String name;
  final String description;
  final bool isSelected;
  final List<Color> previewColors;
  final VoidCallback onTap;

  @override
  State<_ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<_ThemeCard> {
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AuraColors.obsidian.withOpacity(0.6),
            border: Border.all(
              color: widget.isSelected
                  ? AuraColors.sage.withOpacity(0.6)
                  : AuraColors.borderSubtle,
              width: widget.isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Color swatch row
              Row(
                children: [
                  for (int i = 0; i < widget.previewColors.length; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: widget.previewColors[i],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AuraColors.borderMedium,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isSelected
                          ? AuraColors.sage
                          : Colors.transparent,
                      border: Border.all(
                        color: widget.isSelected
                            ? AuraColors.sage
                            : AuraColors.textPrimary.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: widget.isSelected
                        ? const Icon(Icons.check,
                            size: 16, color: Color(0xFF0A0A0B))
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AuraColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 13,
                  color: AuraColors.textPrimary.withOpacity(0.4),
                ),
              ),
              if (widget.isSelected) ...[
                const SizedBox(height: 14),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: AuraColors.sage.withOpacity(0.15),
                  ),
                  child: Text(
                    'ACTIVE',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: AuraColors.sage,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
