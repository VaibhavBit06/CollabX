import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/campaign_data.dart';

class ApplicantDetailsScreen extends StatefulWidget {
  const ApplicantDetailsScreen({
    super.key,
    required this.creatorName,
    required this.proposedRate,
    this.campaignTitle = '',
  });
  final String creatorName;
  final String proposedRate;
  final String campaignTitle;

  @override
  State<ApplicantDetailsScreen> createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  bool _isApproved = false;

  @override
  void initState() {
    super.initState();
    // Check if already approved
    if (widget.campaignTitle.isNotEmpty) {
      final campaign = CampaignData.instance.getCampaign(widget.campaignTitle);
      if (campaign != null) {
        final match = campaign.applicants.where((a) => a.name == widget.creatorName);
        if (match.isNotEmpty && match.first.status == 'APPROVED') {
          _isApproved = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _isApproved ? widget.creatorName : 'Creator #1042';
    final displayHandle = _isApproved
        ? '@${widget.creatorName.toLowerCase().replaceAll(' ', '_')}'
        : '@********';

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
          'PROPOSAL DETAILS',
          style: TextStyle(fontSize: 12, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(displayName, displayHandle),
            const SizedBox(height: 32),
            _SectionHeader(title: 'CAMPAIGN CONTEXT'),
            const SizedBox(height: 12),
            _buildCampaignBriefCard(),
            const SizedBox(height: 32),
            _SectionHeader(title: 'CREATOR PROPOSAL'),
            const SizedBox(height: 12),
            _buildProposalCard(),
            const SizedBox(height: 32),
            _SectionHeader(title: 'CREATOR MESSAGE'),
            const SizedBox(height: 12),
            Text(
              "I'd love to collaborate on this campaign! My audience aligns perfectly with your brand aesthetic. I've worked with similar brands in the past and can deliver high-quality content within 1 week.",
              style: TextStyle(color: AuraColors.chrome.withOpacity(0.7), fontSize: 14, height: 1.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 48),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(String name, String handle) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: AuraColors.sage.withOpacity(0.1),
          child: Icon(Icons.person, color: AuraColors.sage, size: 30),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: AuraColors.chrome, fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 4),
              Text(
                handle,
                style: TextStyle(color: AuraColors.sage, fontSize: 13, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _StatusBadge(status: _isApproved ? 'APPROVED' : 'PENDING'),
            const SizedBox(height: 8),
            _SmallLinkButton(
              label: 'PORTFOLIO',
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.profileBento,
                arguments: {
                  'isPublicView': true,
                  'customDisplayName': name,
                  'customHandle': handle,
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProposalCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: AuraColors.sage.withOpacity(0.05), blurRadius: 40, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Label('PROPOSED RATE'),
              Icon(Icons.payments_outlined, color: AuraColors.sage, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.proposedRate,
            style: TextStyle(color: AuraColors.chrome, fontSize: 32, fontWeight: FontWeight.w200),
          ),
          const Divider(height: 40, color: Colors.white10),
          Row(
            children: [
              _ProposalMeta(label: 'Deliverables', value: '2 Reels, 3 Stories'),
              const Spacer(),
              _ProposalMeta(label: 'Timeline', value: '7-10 Days'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_isApproved) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.dealChat),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.obsidian,
                  foregroundColor: AuraColors.chrome,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: BorderSide(color: AuraColors.sage.withOpacity(0.3)),
                ),
                child: const Text('GO TO CHAT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.collaborationCenter),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('COLLAB HUB', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _OutlinedButton(
                label: 'REJECT',
                color: const Color(0xFFFB7185),
                onTap: () {
                  if (widget.campaignTitle.isNotEmpty) {
                    CampaignData.instance.rejectApplicant(widget.campaignTitle, widget.creatorName);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _OutlinedButton(
                label: 'COUNTER',
                color: AuraColors.chrome.withOpacity(0.6),
                onTap: () {
                  _showCounterDialog();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () async {
              // Launch payment screen first
              final success = await Navigator.of(context).pushNamed(
                AppRoutes.campaignPayment,
                arguments: {
                  'campaignTitle': widget.campaignTitle.isNotEmpty ? widget.campaignTitle : 'Summer Glow 2026',
                  'creatorName': widget.creatorName,
                  'creatorHandle': '@creator', // In a real app, this comes from the creator object
                  'proposedRate': widget.proposedRate,
                },
              );
              
              // If payment was successful (returned true), then approve applicant
              if (success == true) {
                if (widget.campaignTitle.isNotEmpty) {
                  CampaignData.instance.approveApplicant(widget.campaignTitle, widget.creatorName);
                }
                setState(() => _isApproved = true);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creator hired & funds secured!')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AuraColors.sage,
              foregroundColor: AuraColors.midnight,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('APPROVE PROPOSAL', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignBriefCard() {
    final title = widget.campaignTitle.isNotEmpty ? widget.campaignTitle : 'Summer Glow 2026';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.midnight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AuraColors.chrome, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 4),
          Text(
            'Target: ${widget.proposedRate} | Deliverables: 2 Reels',
            style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showCounterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AuraColors.midnight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SEND COUNTER OFFER', style: TextStyle(color: AuraColors.chrome, fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w200)),
            const SizedBox(height: 24),
            TextFormField(
              style: TextStyle(color: AuraColors.chrome),
              decoration: InputDecoration(
                labelText: 'YOUR OFFER',
                labelStyle: TextStyle(color: AuraColors.sage, fontSize: 10),
                prefixText: '₹ ',
                prefixStyle: TextStyle(color: AuraColors.chrome),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AuraColors.sage)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Counter Offer Sent!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('SEND OFFER', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
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
        Text(
          title,
          style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: AuraColors.textPrimary.withOpacity(0.05))),
      ],
    );
  }
}

class _SmallLinkButton extends StatelessWidget {
  const _SmallLinkButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: AuraColors.sage,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          decoration: TextDecoration.underline,
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
      text,
      style: TextStyle(fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.4)),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final isApproved = status == 'APPROVED';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isApproved ? AuraColors.sage : AuraColors.chrome).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (isApproved ? AuraColors.sage : AuraColors.chrome).withOpacity(0.2)),
      ),
      child: Text(
        status,
        style: TextStyle(color: isApproved ? AuraColors.sage : AuraColors.chrome.withOpacity(0.6), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }
}

class _ProposalMeta extends StatelessWidget {
  const _ProposalMeta({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AuraColors.chrome.withOpacity(0.3), fontSize: 9)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: AuraColors.chrome, fontSize: 13, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({required this.label, required this.color, required this.onTap});
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
      ),
    );
  }
}
