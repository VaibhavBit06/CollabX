import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/utils/constants.dart';

class BasicProfileSetupScreen extends StatefulWidget {
  const BasicProfileSetupScreen({
    super.key,
    required this.creatorType,
  });

  final CreatorType creatorType;

  @override
  State<BasicProfileSetupScreen> createState() => _BasicProfileSetupScreenState();
}

class _BasicProfileSetupScreenState extends State<BasicProfileSetupScreen> {
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _followersController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  // Parent/Guardian controllers (for school students)
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _parentEmailController = TextEditingController();
  String _parentRelationship = 'Parent';
  
  static const int _maxBioLength = 150;
  bool _loading = false;

  bool get _isStudent =>
      widget.creatorType == CreatorType.collegeStudent ||
      widget.creatorType == CreatorType.schoolStudent16Plus;

  bool get _isSchoolStudent =>
      widget.creatorType == CreatorType.schoolStudent16Plus;

  String get _institutionLabel {
    switch (widget.creatorType) {
      case CreatorType.collegeStudent:
        return 'College Name';
      case CreatorType.schoolStudent16Plus:
        return 'School Name';
      case CreatorType.independent:
        return '';
    }
  }

  String get _institutionHint {
    switch (widget.creatorType) {
      case CreatorType.collegeStudent:
        return 'e.g. Delhi University';
      case CreatorType.schoolStudent16Plus:
        return 'e.g. DPS Noida';
      case CreatorType.independent:
        return '';
    }
  }

  String get _screenTitle {
    switch (widget.creatorType) {
      case CreatorType.collegeStudent:
        return 'Student Profile';
      case CreatorType.schoolStudent16Plus:
        return 'Student Profile';
      case CreatorType.independent:
        return 'Creator Profile';
    }
  }

  String get _screenSubtitle {
    switch (widget.creatorType) {
      case CreatorType.collegeStudent:
        return 'Tell us about yourself and your college.';
      case CreatorType.schoolStudent16Plus:
        return 'Tell us about yourself and your school.';
      case CreatorType.independent:
        return 'Fill in a few details to get started.';
    }
  }

  @override
  void dispose() {
    _instagramController.dispose();
    _followersController.dispose();
    _cityController.dispose();
    _bioController.dispose();
    _institutionController.dispose();
    _parentNameController.dispose();
    _parentPhoneController.dispose();
    _parentEmailController.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final ig = _instagramController.text.trim();
    final followers = _followersController.text.trim();
    final city = _cityController.text.trim();
    final bio = _bioController.text.trim();
    final institution = _institutionController.text.trim();
    final parentName = _parentNameController.text.trim();
    final parentPhone = _parentPhoneController.text.trim();
    final parentEmail = _parentEmailController.text.trim();

    // Validate required fields
    if (ig.isEmpty || followers.isEmpty || city.isEmpty) return;
    if (_isStudent && institution.isEmpty) return;
    // School students must provide parent details
    if (_isSchoolStudent && (parentName.isEmpty || parentPhone.isEmpty)) return;

    setState(() {
      _loading = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (Route<dynamic> route) => false,
    );
  }

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
            // Header with creator type badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    _screenTitle,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w200,
                      color: AuraColors.chrome,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AuraColors.sage.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AuraColors.sage.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    widget.creatorType.label,
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      color: AuraColors.sage,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _screenSubtitle,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AuraColors.chrome.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'KYC & payment can be done later from Profile.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: AuraColors.chrome.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 32),
            // Student-specific section
            if (_isStudent) ...<Widget>[
              _SectionHeader(
                icon: widget.creatorType == CreatorType.collegeStudent
                    ? Icons.school_outlined
                    : Icons.account_balance_outlined,
                title: 'Education Details',
              ),
              const SizedBox(height: 16),
              _Label(_institutionLabel),
              const SizedBox(height: 8),
              _TextField(
                controller: _institutionController,
                hint: _institutionHint,
              ),
              const SizedBox(height: 28),
              // Divider
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AuraColors.chrome.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
            // Parent/Guardian section (only for school students)
            if (_isSchoolStudent) ...<Widget>[
              _SectionHeader(
                icon: Icons.family_restroom_outlined,
                title: 'Parent/Guardian Details',
              ),
              const SizedBox(height: 8),
              Text(
                'Since you are under 18, we need your parent/guardian\'s consent.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: AuraColors.chrome.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
              _Label('Relationship'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AuraColors.obsidian.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _parentRelationship,
                    isExpanded: true,
                    dropdownColor: AuraColors.obsidian,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AuraColors.chrome,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AuraColors.chrome.withOpacity(0.5),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                      DropdownMenuItem(value: 'Mother', child: Text('Mother')),
                      DropdownMenuItem(value: 'Father', child: Text('Father')),
                      DropdownMenuItem(value: 'Guardian', child: Text('Legal Guardian')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _parentRelationship = value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _Label('Parent/Guardian Full Name'),
              const SizedBox(height: 8),
              _TextField(
                controller: _parentNameController,
                hint: 'Full name as per ID',
              ),
              const SizedBox(height: 20),
              _Label('Parent/Guardian Phone'),
              const SizedBox(height: 8),
              _TextField(
                controller: _parentPhoneController,
                hint: '+91 98765 43210',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _Label('Parent/Guardian Email (optional)'),
              const SizedBox(height: 8),
              _TextField(
                controller: _parentEmailController,
                hint: 'parent@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AuraColors.sage.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AuraColors.sage.withOpacity(0.15)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: AuraColors.sage.withOpacity(0.8),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'A verification link will be sent to your parent/guardian for consent.',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: AuraColors.sage.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Divider
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AuraColors.chrome.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
            // Social Media section
            _SectionHeader(
              icon: Icons.camera_alt_outlined,
              title: 'Social Media',
            ),
            const SizedBox(height: 16),
            _Label('Instagram Handle'),
            const SizedBox(height: 8),
            _TextField(
              controller: _instagramController,
              hint: '@username',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            _Label('Instagram Followers'),
            const SizedBox(height: 8),
            _TextField(
              controller: _followersController,
              hint: 'e.g. 5000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 28),
            // Location section
            _SectionHeader(
              icon: Icons.location_on_outlined,
              title: 'Location',
            ),
            const SizedBox(height: 16),
            _Label('City'),
            const SizedBox(height: 8),
            _TextField(
              controller: _cityController,
              hint: 'Your city',
            ),
            const SizedBox(height: 28),
            // About section
            _SectionHeader(
              icon: Icons.person_outline,
              title: 'About You',
            ),
            const SizedBox(height: 16),
            _Label('Bio (optional, max $_maxBioLength chars)'),
            const SizedBox(height: 8),
            TextField(
              controller: _bioController,
              maxLines: 4,
              maxLength: _maxBioLength,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AuraColors.chrome,
              ),
              decoration: InputDecoration(
                hintText: 'A short bio about you...',
                hintStyle: TextStyle(
                  color: AuraColors.chrome.withOpacity(0.4),
                  fontWeight: FontWeight.w200,
                ),
                filled: true,
                fillColor: AuraColors.obsidian.withOpacity(0.7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AuraColors.sage),
                ),
                counterStyle: TextStyle(
                  fontSize: 10,
                  color: AuraColors.chrome.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _loading ? null : _complete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: _loading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AuraColors.midnight,
                        ),
                      )
                    : const Text(
                        'COMPLETE & GO TO DASHBOARD',
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

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 10,
        letterSpacing: 2,
        fontWeight: FontWeight.w500,
        color: AuraColors.chrome.withOpacity(0.6),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AuraColors.sage.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AuraColors.sage,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: AuraColors.chrome.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AuraColors.chrome,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AuraColors.chrome.withOpacity(0.4),
          fontWeight: FontWeight.w200,
        ),
        filled: true,
        fillColor: AuraColors.obsidian.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AuraColors.sage),
        ),
      ),
    );
  }
}
