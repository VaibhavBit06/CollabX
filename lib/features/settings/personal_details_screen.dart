import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/utils/mock_data.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  // Mock data - in real app, this would come from a user service
  String _name = MockUser.fullName;
  String _handle = MockUser.handle;
  String _education = MockUser.education;
  bool _isSchoolStudent = false;
  
  // KYC Status
  String _kycStatus = MockUser.kycStatus; // Not Submitted, Pending, Verified, Rejected
  
  // Payment details
  String _upiId = '';
  String _bankAccount = '';
  String _ifsc = '';
  bool _usesFamPay = false;

  // Portfolio
  final List<_CollabItem> _completedCollabs = MockCollabs.completed
      .map((c) => _CollabItem(
            brand: c.brand,
            campaign: c.campaign,
            payout: c.earned,
            rating: c.rating,
          ))
      .toList();

  void _showImagePicker(String type) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AuraColors.obsidian,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AuraColors.textPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Change $type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _ImagePickerOption(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Camera opened')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ImagePickerOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Gallery opened')),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _sharePortfolio() {
    final link = MockUser.portfolioUrl;
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Portfolio link copied: $link'),
        backgroundColor: AuraColors.sage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: CustomScrollView(
        slivers: [
          // Cover Photo with Profile Photo overlay
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover Photo - Bento style
                GestureDetector(
                  onTap: () => _showImagePicker('Cover Photo'),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AuraColors.sage.withOpacity(0.3),
                          AuraColors.obsidian,
                          AuraColors.sage.withOpacity(0.15),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Bento grid pattern overlay
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _BentoPatternPainter(),
                          ),
                        ),
                        // Edit indicator
                        Positioned(
                          right: 16,
                          bottom: 50,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AuraColors.midnight.withOpacity(0.7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AuraColors.textPrimary.withOpacity(0.2),
                              ),
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: AuraColors.chrome.withOpacity(0.8),
                            ),
                          ),
                        ),
                        // Back button
                        Positioned(
                          left: 16,
                          top: MediaQuery.of(context).padding.top + 8,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AuraColors.midnight.withOpacity(0.7),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AuraColors.textPrimary.withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: AuraColors.chrome,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Profile Photo - Circular, sits over cover
                Positioned(
                  left: 24,
                  bottom: -50,
                  child: GestureDetector(
                    onTap: () => _showImagePicker('Profile Photo'),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AuraColors.midnight,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: AuraColors.sage.withOpacity(0.3),
                            child: Text(
                              _name.isNotEmpty ? _name[0].toUpperCase() : 'P',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w300,
                                color: AuraColors.sage,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AuraColors.sage,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AuraColors.midnight,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 14,
                                color: AuraColors.midnight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Spacing for profile photo overlap
          const SliverToBoxAdapter(
            child: SizedBox(height: 60),
          ),
          // Content
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Name & Handle Section
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: AuraColors.chrome,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _handle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AuraColors.sage,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Edit name/handle
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Edit profile coming soon')),
                              );
                            },
                            icon: Icon(
                              Icons.edit_outlined,
                              color: AuraColors.chrome.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Education Section
                _SectionHeader(icon: Icons.school_outlined, title: 'Education'),
                const SizedBox(height: 12),
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _education.isNotEmpty ? _education : 'Not specified',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: _education.isNotEmpty
                                    ? AuraColors.chrome
                                    : AuraColors.chrome.withOpacity(0.5),
                              ),
                            ),
                          ),
                          if (_isSchoolStudent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AuraColors.sage.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'School',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AuraColors.sage,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // KYC Section
                _SectionHeader(icon: Icons.verified_user_outlined, title: 'KYC Verification'),
                const SizedBox(height: 12),
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _KycStatusBadge(status: _kycStatus),
                          const Spacer(),
                          if (_kycStatus == 'Not Submitted' || _kycStatus == 'Rejected')
                            TextButton(
                              onPressed: () {
                                // Upload KYC documents
                                _showKycUploadSheet();
                              },
                              child: Text(
                                _kycStatus == 'Rejected' ? 'Re-upload' : 'Upload',
                                style: const TextStyle(
                                  color: AuraColors.sage,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _KycDocumentRow(
                        label: 'Aadhaar Card',
                        isUploaded: _kycStatus != 'Not Submitted',
                        onUpload: () => _showKycUploadSheet(),
                      ),
                      const SizedBox(height: 12),
                      _KycDocumentRow(
                        label: 'PAN Card',
                        isUploaded: _kycStatus != 'Not Submitted',
                        onUpload: () => _showKycUploadSheet(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Payment Details Section
                _SectionHeader(icon: Icons.account_balance_outlined, title: 'Payment Details'),
                const SizedBox(height: 12),
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isSchoolStudent) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AuraColors.sage.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AuraColors.sage.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                size: 18,
                                color: AuraColors.sage,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'As a school creator, payouts are via FamPay only.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AuraColors.sage.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _PaymentDetailRow(
                          label: 'FamPay Account',
                          value: _usesFamPay ? 'Connected' : 'Not Connected',
                          isConnected: _usesFamPay,
                          onTap: () {
                            setState(() => _usesFamPay = !_usesFamPay);
                          },
                        ),
                      ] else ...[
                        _PaymentDetailRow(
                          label: 'UPI ID',
                          value: _upiId.isNotEmpty ? _upiId : 'Not added',
                          isConnected: _upiId.isNotEmpty,
                          onTap: () => _showPaymentEditSheet('UPI ID'),
                        ),
                        const SizedBox(height: 16),
                        _PaymentDetailRow(
                          label: 'Bank Account',
                          value: _bankAccount.isNotEmpty
                              ? '••••${_bankAccount.substring(_bankAccount.length - 4)}'
                              : 'Not added',
                          isConnected: _bankAccount.isNotEmpty,
                          onTap: () => _showPaymentEditSheet('Bank Account'),
                        ),
                        const SizedBox(height: 16),
                        _PaymentDetailRow(
                          label: 'IFSC Code',
                          value: _ifsc.isNotEmpty ? _ifsc : 'Not added',
                          isConnected: _ifsc.isNotEmpty,
                          onTap: () => _showPaymentEditSheet('IFSC'),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Portfolio Section
                _SectionHeader(icon: Icons.work_outline, title: 'Portfolio'),
                const SizedBox(height: 12),
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_completedCollabs.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.work_off_outlined,
                                  size: 48,
                                  color: AuraColors.chrome.withOpacity(0.3),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No completed collabs yet',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AuraColors.chrome.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ..._completedCollabs.map((collab) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CollabCard(collab: collab),
                        )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Share Portfolio Button
                GestureDetector(
                  onTap: _sharePortfolio,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AuraColors.sage.withOpacity(0.2),
                          AuraColors.sage.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AuraColors.sage.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AuraColors.sage.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.share_outlined,
                            size: 22,
                            color: AuraColors.sage,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Share Portfolio',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AuraColors.chrome,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                MockUser.portfolioUrl,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AuraColors.sage.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.copy_outlined,
                          size: 20,
                          color: AuraColors.sage.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showKycUploadSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AuraColors.obsidian,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AuraColors.textPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Upload KYC Documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AuraColors.chrome,
              ),
            ),
            const SizedBox(height: 24),
            _UploadOption(
              icon: Icons.credit_card,
              label: 'Aadhaar Card',
              sublabel: 'Front & Back',
              onTap: () {
                Navigator.pop(context);
                setState(() => _kycStatus = 'Pending');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aadhaar uploaded - Pending verification'),
                    backgroundColor: AuraColors.sage,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _UploadOption(
              icon: Icons.badge_outlined,
              label: 'PAN Card',
              sublabel: 'Clear photo',
              onTap: () {
                Navigator.pop(context);
                setState(() => _kycStatus = 'Pending');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('PAN uploaded - Pending verification'),
                    backgroundColor: AuraColors.sage,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showPaymentEditSheet(String field) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: AuraColors.obsidian,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AuraColors.textPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Enter $field',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AuraColors.chrome,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller,
                autofocus: true,
                style: TextStyle(
                  fontSize: 16,
                  color: AuraColors.chrome,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter $field',
                  hintStyle: TextStyle(
                    color: AuraColors.chrome.withOpacity(0.4),
                  ),
                  filled: true,
                  fillColor: AuraColors.midnight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AuraColors.sage),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      if (field == 'UPI ID') _upiId = controller.text;
                      if (field == 'Bank Account') _bankAccount = controller.text;
                      if (field == 'IFSC') _ifsc = controller.text;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$field saved'),
                        backgroundColor: AuraColors.sage,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuraColors.sage,
                    foregroundColor: AuraColors.midnight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widgets

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
        Icon(
          icon,
          size: 18,
          color: AuraColors.sage,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: AuraColors.chrome,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: child,
    );
  }
}

class _ImagePickerOption extends StatelessWidget {
  const _ImagePickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AuraColors.midnight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: AuraColors.sage,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AuraColors.chrome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KycStatusBadge extends StatelessWidget {
  const _KycStatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (status) {
      case 'Verified':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'Pending':
        color = Colors.orange;
        icon = Icons.schedule;
        break;
      case 'Rejected':
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = AuraColors.chrome.withOpacity(0.5);
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _KycDocumentRow extends StatelessWidget {
  const _KycDocumentRow({
    required this.label,
    required this.isUploaded,
    required this.onUpload,
  });

  final String label;
  final bool isUploaded;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isUploaded ? Colors.green : AuraColors.chrome).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isUploaded ? Icons.check : Icons.upload_file,
            size: 18,
            color: isUploaded ? Colors.green : AuraColors.chrome.withOpacity(0.5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AuraColors.chrome.withOpacity(0.8),
            ),
          ),
        ),
        if (!isUploaded)
          GestureDetector(
            onTap: onUpload,
            child: Text(
              'Upload',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AuraColors.sage,
              ),
            ),
          ),
      ],
    );
  }
}

class _PaymentDetailRow extends StatelessWidget {
  const _PaymentDetailRow({
    required this.label,
    required this.value,
    required this.isConnected,
    required this.onTap,
  });

  final String label;
  final String value;
  final bool isConnected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AuraColors.chrome.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isConnected
                        ? AuraColors.chrome
                        : AuraColors.chrome.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isConnected ? Icons.check_circle : Icons.add_circle_outline,
            size: 20,
            color: isConnected ? Colors.green : AuraColors.sage,
          ),
        ],
      ),
    );
  }
}

class _CollabItem {
  final String brand;
  final String campaign;
  final String payout;
  final double rating;

  _CollabItem({
    required this.brand,
    required this.campaign,
    required this.payout,
    required this.rating,
  });
}

class _CollabCard extends StatelessWidget {
  const _CollabCard({required this.collab});

  final _CollabItem collab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                collab.brand[0],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AuraColors.sage,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collab.brand,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AuraColors.chrome,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  collab.campaign,
                  style: TextStyle(
                    fontSize: 12,
                    color: AuraColors.chrome.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                collab.payout,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AuraColors.sage,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    collab.rating.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AuraColors.chrome.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UploadOption extends StatelessWidget {
  const _UploadOption({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String sublabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AuraColors.midnight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: AuraColors.sage,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AuraColors.chrome,
                    ),
                  ),
                  Text(
                    sublabel,
                    style: TextStyle(
                      fontSize: 12,
                      color: AuraColors.chrome.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.upload_outlined,
              color: AuraColors.sage.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}

// Bento Pattern Painter for cover photo
class _BentoPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AuraColors.textPrimary.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw bento grid lines
    final spacing = size.width / 4;
    
    // Vertical lines
    for (var i = 1; i < 4; i++) {
      canvas.drawLine(
        Offset(spacing * i, 0),
        Offset(spacing * i, size.height),
        paint,
      );
    }
    
    // Horizontal lines
    final hSpacing = size.height / 3;
    for (var i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(0, hSpacing * i),
        Offset(size.width, hSpacing * i),
        paint,
      );
    }

    // Some bento style rounded rects
    final rectPaint = Paint()
      ..color = AuraColors.sage.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(spacing * 2 + 10, 10, spacing - 20, hSpacing - 15),
        const Radius.circular(12),
      ),
      rectPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, hSpacing + 5, spacing * 2 - 15, hSpacing * 2 - 15),
        const Radius.circular(12),
      ),
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
