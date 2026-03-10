import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class CreatorCollabDetailsScreen extends StatefulWidget {
  const CreatorCollabDetailsScreen({super.key});

  @override
  State<CreatorCollabDetailsScreen> createState() => _CreatorCollabDetailsScreenState();
}

class _CreatorCollabDetailsScreenState extends State<CreatorCollabDetailsScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final brandName = args?['brandName'] ?? 'BRAND';
    final campaignTitle = args?['campaignTitle'] ?? 'CAMPAIGN';
    final status = args?['status'] ?? 'CONTENT CREATION';

    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
        title: Text(
          'COLLAB HUB',
          style: TextStyle(fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.dealChat),
            icon: Icon(Icons.forum_outlined, color: AuraColors.sage),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBrandHeader(brandName, campaignTitle),
             const SizedBox(height: 32),
             _buildStatusCard(status),
             const SizedBox(height: 24),
             _buildChatAction(),
             const SizedBox(height: 32),
             _buildSubmissionSection(),
             const SizedBox(height: 32),
             _buildRequirementsCard(),
           ],
         ),
       ),
    );
  }

  Widget _buildChatAction() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.dealChat),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AuraColors.sage.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AuraColors.sage.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.forum_outlined, color: AuraColors.sage, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'BRAND COMMUNICATION',
                    style: TextStyle(fontSize: 9, color: AuraColors.sage.withOpacity(0.6), letterSpacing: 1, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Chat with Brand Representative',
                    style: TextStyle(color: AuraColors.chrome, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AuraColors.sage, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandHeader(String brandName, String campaignTitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AuraColors.sage.withOpacity(0.15), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.sage.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(Icons.business_center, color: AuraColors.sage, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaignTitle,
                  style: TextStyle(color: AuraColors.chrome, fontSize: 22, fontWeight: FontWeight.w200),
                ),
                Text(
                  brandName,
                  style: TextStyle(color: AuraColors.sage, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.timer_outlined, color: AuraColors.sage, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COLLAB STATUS',
                  style: TextStyle(fontSize: 9, color: AuraColors.chrome.withOpacity(0.4), letterSpacing: 1),
                ),
                Text(
                  status,
                  style: TextStyle(color: AuraColors.chrome, fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionSection() {
    if (_isSubmitted) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AuraColors.sage.withOpacity(0.05),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AuraColors.sage.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_outline, color: AuraColors.sage, size: 40),
            ),
            const SizedBox(height: 20),
            Text(
              'Deliverable Submitted!',
              style: TextStyle(color: AuraColors.chrome, fontSize: 18, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 12),
            Text(
              'The brand has been notified and is currently reviewing your Instagram post. Payments are processed after approval.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AuraColors.chrome.withOpacity(0.5), fontSize: 13, height: 1.6),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'PROOF OF COLLABORATION',
            style: TextStyle(fontSize: 10, letterSpacing: 2.5, color: AuraColors.chrome.withOpacity(0.4), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AuraColors.obsidian,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 20)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Instagram Post / Reel Link',
                style: TextStyle(color: AuraColors.chrome.withOpacity(0.7), fontSize: 13, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _urlController,
                style: TextStyle(color: AuraColors.chrome),
                decoration: InputDecoration(
                  hintText: 'https://www.instagram.com/p/...',
                  hintStyle: TextStyle(color: AuraColors.chrome.withOpacity(0.2), fontSize: 13),
                  prefixIcon: Icon(Icons.camera_alt_outlined, color: AuraColors.sage, size: 20),
                  filled: true,
                  fillColor: AuraColors.midnight.withOpacity(0.5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AuraColors.sage.withOpacity(0.3))),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_urlController.text.isNotEmpty) {
                      HapticFeedback.mediumImpact();
                      setState(() => _isSubmitted = true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuraColors.sage,
                    foregroundColor: AuraColors.midnight,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('SUBMIT FOR REVIEW', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, color: AuraColors.chrome.withOpacity(0.5), size: 18),
              const SizedBox(width: 8),
              Text(
                'REQUIREMENTS',
                style: TextStyle(fontSize: 10, letterSpacing: 1, color: AuraColors.chrome.withOpacity(0.5), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _RequirementRow(text: 'One 30-second high-energy Reel'),
          _RequirementRow(text: 'Mention @brand_official in caption'),
          _RequirementRow(text: 'Use hashtag #SummerGlow2026'),
          _RequirementRow(text: 'Tag location in the post'),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  const _RequirementRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(color: AuraColors.sage, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(color: AuraColors.chrome.withOpacity(0.7), fontSize: 13, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
