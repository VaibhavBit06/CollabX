import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/constants.dart';

class CreatorTypeSelectionScreen extends StatefulWidget {
  const CreatorTypeSelectionScreen({super.key});

  @override
  State<CreatorTypeSelectionScreen> createState() =>
      _CreatorTypeSelectionScreenState();
}

class _CreatorTypeSelectionScreenState extends State<CreatorTypeSelectionScreen> {
  CreatorType? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Select Creator Type',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w200,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the category that best describes you.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AuraColors.chrome.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            ...CreatorType.values.map(
              (CreatorType type) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _CreatorTypeChip(
                  type: type,
                  selected: _selected == type,
                  onTap: () => setState(() {
                    _selected = type;
                  }),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _selected == null
                    ? null
                    : () => Navigator.of(context).pushReplacementNamed(
                          AppRoutes.basicProfileSetup,
                          arguments: _selected,
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  disabledBackgroundColor: AuraColors.obsidian,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
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

class _CreatorTypeChip extends StatelessWidget {
  const _CreatorTypeChip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final CreatorType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: selected
              ? AuraColors.sage.withOpacity(0.15)
              : AuraColors.obsidian.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.08),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              _iconForType(type),
              color: selected ? AuraColors.sage : AuraColors.chrome.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              type.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: selected ? AuraColors.chrome : AuraColors.chrome.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(CreatorType type) {
    switch (type) {
      case CreatorType.collegeStudent:
        return Icons.school_outlined;
      case CreatorType.schoolStudent16Plus:
        return Icons.person_outline;
      case CreatorType.independent:
        return Icons.work_outline;
    }
  }
}
