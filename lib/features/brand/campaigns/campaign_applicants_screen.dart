import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/campaign_data.dart';

class CampaignApplicantsScreen extends StatefulWidget {
  const CampaignApplicantsScreen({super.key});

  @override
  State<CampaignApplicantsScreen> createState() => _CampaignApplicantsScreenState();
}

class _CampaignApplicantsScreenState extends State<CampaignApplicantsScreen> {
  late String _campaignTitle;
  List<Applicant> _applicants = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _campaignTitle = args?['campaignTitle'] ?? 'CAMPAIGN';
    _refreshApplicants();
  }

  void _refreshApplicants() {
    final campaign = CampaignData.instance.getCampaign(_campaignTitle);
    setState(() {
      _applicants = campaign?.visibleApplicants ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final campaign = CampaignData.instance.getCampaign(_campaignTitle);
    final hasApproved = campaign?.hasApproved ?? false;

    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
        title: Column(
          children: [
            Text(
              hasApproved ? 'APPROVED CREATOR' : 'APPLICANTS',
              style: TextStyle(fontSize: 10, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome.withOpacity(0.5)),
            ),
            Text(
              _campaignTitle.toUpperCase(),
              style: TextStyle(fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.w400, color: AuraColors.chrome),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: _applicants.isEmpty
          ? Center(
              child: Text(
                'No applicants yet',
                style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 14),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _applicants.length,
              itemBuilder: (context, index) {
                final applicant = _applicants[index];
                return _ApplicantTile(
                  applicant: applicant,
                  campaignTitle: _campaignTitle,
                  onReturn: _refreshApplicants,
                );
              },
            ),
    );
  }
}

class _ApplicantTile extends StatelessWidget {
  const _ApplicantTile({
    required this.applicant,
    required this.campaignTitle,
    required this.onReturn,
  });

  final Applicant applicant;
  final String campaignTitle;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: applicant.status == 'APPROVED'
              ? AuraColors.sage.withOpacity(0.3)
              : AuraColors.textPrimary.withOpacity(0.06),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AuraColors.sage.withOpacity(0.1),
            child: Icon(Icons.person, color: AuraColors.sage, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  applicant.name,
                  style: TextStyle(color: AuraColors.chrome, fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  applicant.handle,
                  style: TextStyle(color: AuraColors.chrome.withOpacity(0.3), fontSize: 12),
                ),
                const SizedBox(height: 8),
                _StatusBadge(status: applicant.status),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                applicant.rate,
                style: TextStyle(color: AuraColors.sage, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _ViewButton(
                label: applicant.status == 'APPROVED' ? 'VIEW' : 'REVIEW',
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    AppRoutes.applicantDetails,
                    arguments: {
                      'creatorName': applicant.name,
                      'creatorHandle': applicant.handle,
                      'proposedRate': applicant.rate,
                      'campaignTitle': campaignTitle,
                    },
                  );
                  onReturn();
                },
              ),
            ],
          ),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isApproved ? AuraColors.sage : AuraColors.chrome).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isApproved ? AuraColors.sage : AuraColors.chrome.withOpacity(0.5),
          fontSize: 8,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _ViewButton extends StatelessWidget {
  const _ViewButton({required this.onTap, required this.label});
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AuraColors.sage,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(color: AuraColors.midnight, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
