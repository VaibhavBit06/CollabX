import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class CollaborationCenterScreen extends StatefulWidget {
  const CollaborationCenterScreen({super.key});

  @override
  State<CollaborationCenterScreen> createState() =>
      _CollaborationCenterScreenState();
}

class _CollaborationCenterScreenState extends State<CollaborationCenterScreen> {
  bool _isContentSubmitted = true;
  bool _isPaymentReleased = false;

  @override
  Widget build(BuildContext context) {
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
          'COLLABORATION CENTER',
          style: TextStyle(
              fontSize: 12,
              letterSpacing: 4,
              fontWeight: FontWeight.w300,
              color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDealOverview(),
            const SizedBox(height: 32),
            _SectionHeader(title: 'DELIVERABLES'),
            const SizedBox(height: 16),
            _buildDeliverableCard(
              title: 'Instagram Reel (15-30s)',
              status: _isContentSubmitted ? 'SUBMITTED' : 'PENDING',
              isReviewable: _isContentSubmitted && !_isPaymentReleased,
            ),
            const SizedBox(height: 16),
            _buildDeliverableCard(
              title: 'Instagram Story (Link + Tag)',
              status: _isContentSubmitted ? 'SUBMITTED' : 'PENDING',
              isReviewable: _isContentSubmitted && !_isPaymentReleased,
            ),
            const SizedBox(height: 48),
            if (_isContentSubmitted && !_isPaymentReleased)
              _buildPayoutAction(),
            if (_isPaymentReleased) _buildCompletionNotice(),
          ],
        ),
      ),
    );
  }

  Widget _buildDealOverview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.sage.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AuraColors.sage.withOpacity(0.1),
                child: Icon(Icons.person, color: AuraColors.sage),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Karan Sharma',
                      style: TextStyle(
                          color: AuraColors.chrome,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  Text('@karan_vlogs',
                      style: TextStyle(color: AuraColors.sage, fontSize: 12)),
                ],
              ),
              const Spacer(),
              _StatusIndicator(
                  label: _isPaymentReleased ? 'COMPLETED' : 'IN PROGRESS'),
            ],
          ),
          const Divider(height: 40, color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MetaItem(label: 'Total Payout', value: '₹15,000'),
              _MetaItem(label: 'Timeline', value: '7 Days Left'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.brandDealChat,
                arguments: {
                  'creatorName': 'Karan Sharma',
                  'creatorHandle': '@karan_vlogs',
                  'campaignTitle': 'Active Collab',
                  'dealAmount': '₹15,000',
                },
              ),
              icon: Icon(Icons.chat_bubble_outline,
                  size: 16, color: AuraColors.sage),
              label: Text(
                'Message Creator',
                style: TextStyle(
                  color: AuraColors.sage,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AuraColors.sage.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverableCard(
      {required String title,
      required String status,
      bool isReviewable = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.midnight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(Icons.video_library_outlined,
              color: AuraColors.chrome.withOpacity(0.4), size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: AuraColors.chrome,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
                const SizedBox(height: 4),
                Text(status,
                    style: TextStyle(
                        color: status == 'SUBMITTED'
                            ? AuraColors.sage
                            : Colors.white24,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              ],
            ),
          ),
          if (isReviewable)
            TextButton(
              onPressed: () => _showContentPreview(context),
              child: Text('REVIEW',
                  style: TextStyle(
                      color: AuraColors.sage,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildPayoutAction() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AuraColors.sage.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            'All content looks perfect?',
            style: TextStyle(
                color: AuraColors.chrome.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                _showPaymentConfirmation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AuraColors.sage,
                foregroundColor: AuraColors.midnight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('RELEASE PAYMENT (₹15,000)',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionNotice() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle_outline, color: AuraColors.sage, size: 48),
          const SizedBox(height: 16),
          Text(
            'Deals Completed & Paid',
            style: TextStyle(
                color: AuraColors.chrome,
                fontSize: 18,
                fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 8),
          Text(
            '₹15,000 has been transferred from your wallet.',
            style: TextStyle(
                color: AuraColors.chrome.withOpacity(0.4), fontSize: 12),
          ),
          const SizedBox(height: 24),
          _OutlinedButton(
            label: 'VIEW IN HISTORY',
            color: AuraColors.chrome.withOpacity(0.5),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.transactionHistory),
          ),
        ],
      ),
    );
  }

  void _showContentPreview(BuildContext context) {
    const submittedLink = 'https://www.instagram.com/reel/CXkm8qALm9T/';

    showModalBottomSheet(
      context: context,
      backgroundColor: AuraColors.midnight,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SUBMISSION REVIEW',
                    style: TextStyle(
                        color: AuraColors.chrome,
                        fontSize: 12,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w300)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close,
                        color: AuraColors.chrome.withOpacity(0.5))),
              ],
            ),
            const SizedBox(height: 24),
            // Creator info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AuraColors.obsidian,
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AuraColors.sage.withOpacity(0.15),
                    child: const Icon(Icons.person, color: AuraColors.sage),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Karan Sharma',
                          style: TextStyle(
                              color: AuraColors.chrome,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      Text('@karan_vlogs',
                          style:
                              TextStyle(color: AuraColors.sage, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'SUBMITTED INSTAGRAM LINK',
              style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600,
                  color: AuraColors.textPrimary.withOpacity(0.35)),
            ),
            const SizedBox(height: 10),
            // Instagram link card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AuraColors.obsidian,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: const Color(0xFFE1306C).withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF833AB4),
                          Color(0xFFE1306C),
                          Color(0xFFF77737)
                        ],
                      ),
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Instagram Reel',
                            style: TextStyle(
                                color: AuraColors.chrome,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(height: 4),
                        Text(
                          submittedLink,
                          style: TextStyle(
                            fontSize: 11,
                            color: AuraColors.sage.withOpacity(0.8),
                            decoration: TextDecoration.underline,
                            decorationColor: AuraColors.sage.withOpacity(0.4),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.open_in_new,
                      color: AuraColors.sage.withOpacity(0.6), size: 18),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('APPROVE CONTENT',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AuraColors.obsidian,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Release Payment?',
            style: TextStyle(
                color: AuraColors.chrome, fontWeight: FontWeight.w300)),
        content: Text(
            'This will transfer ₹15,000 from your wallet to the creator. This action cannot be undone.',
            style: TextStyle(
                color: AuraColors.chrome.withOpacity(0.6), fontSize: 13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL',
                  style: TextStyle(color: AuraColors.chrome.withOpacity(0.4)))),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isPaymentReleased = true);
            },
            child: const Text('YES, PAY NOW',
                style: TextStyle(
                    color: AuraColors.sage, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: TextStyle(
                color: AuraColors.chrome.withOpacity(0.4),
                fontSize: 10,
                letterSpacing: 3,
                fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Expanded(
            child: Divider(color: AuraColors.textPrimary.withOpacity(0.05))),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AuraColors.sage.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: const TextStyle(
              color: AuraColors.sage,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1)),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: AuraColors.chrome.withOpacity(0.3), fontSize: 9)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                color: AuraColors.chrome,
                fontSize: 15,
                fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton(
      {required this.label, required this.color, required this.onTap});
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(label,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 12)),
      ),
    );
  }
}
