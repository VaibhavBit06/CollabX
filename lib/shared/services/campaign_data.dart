/// In-memory mock data for campaigns and their applicants.
/// Singleton — state survives navigation within a session.

class Applicant {
  final String name;
  final String handle;
  final String rate;
  String status; // 'PENDING', 'APPROVED', 'REJECTED'

  Applicant({
    required this.name,
    required this.handle,
    required this.rate,
    this.status = 'PENDING',
  });
}

class CampaignInfo {
  final String title;
  final String budget;
  final String statusLabel; // 'ACTIVE', 'PENDING REVIEW', 'COMPLETED'
  final List<Applicant> applicants;

  CampaignInfo({
    required this.title,
    required this.budget,
    required this.statusLabel,
    required this.applicants,
  });

  /// Returns only the approved applicant if any, otherwise all non-rejected.
  List<Applicant> get visibleApplicants {
    final approved = applicants.where((a) => a.status == 'APPROVED').toList();
    if (approved.isNotEmpty) return approved;
    return applicants.where((a) => a.status != 'REJECTED').toList();
  }

  bool get hasApproved => applicants.any((a) => a.status == 'APPROVED');
}

class CampaignData {
  CampaignData._();
  static final CampaignData instance = CampaignData._();

  late final List<CampaignInfo> campaigns = _buildMockCampaigns();

  CampaignInfo? getCampaign(String title) {
    try {
      return campaigns.firstWhere((c) => c.title == title);
    } catch (_) {
      return null;
    }
  }

  void approveApplicant(String campaignTitle, String applicantName) {
    final campaign = getCampaign(campaignTitle);
    if (campaign == null) return;
    for (final a in campaign.applicants) {
      if (a.name == applicantName) {
        a.status = 'APPROVED';
      } else {
        a.status = 'REJECTED';
      }
    }
  }

  void rejectApplicant(String campaignTitle, String applicantName) {
    final campaign = getCampaign(campaignTitle);
    if (campaign == null) return;
    for (final a in campaign.applicants) {
      if (a.name == applicantName) {
        a.status = 'REJECTED';
      }
    }
  }

  // ────────────────── Mock seed data ──────────────────

  static List<CampaignInfo> _buildMockCampaigns() {
    return [
      CampaignInfo(
        title: 'Summer Glow 2026',
        budget: '₹15,000',
        statusLabel: 'ACTIVE',
        applicants: _generateApplicants(8),
      ),
      CampaignInfo(
        title: 'Tech Unboxing Series',
        budget: '₹25,000',
        statusLabel: 'PENDING REVIEW',
        applicants: _generateApplicants(5),
      ),
      CampaignInfo(
        title: 'Winter Wardrobe',
        budget: '₹8,000',
        statusLabel: 'COMPLETED',
        applicants: _generateApplicants(3),
      ),
    ];
  }

  static List<Applicant> _generateApplicants(int count) {
    final names = [
      'Arjun Mehta',
      'Priya Sharma',
      'Karan Singh',
      'Neha Gupta',
      'Rohit Verma',
      'Ananya Roy',
      'Vikram Joshi',
      'Sneha Patel',
      'Aditya Rao',
      'Ishita Nair',
    ];
    final rates = ['₹12,500', '₹15,000', '₹10,000', '₹18,000', '₹14,000'];

    return List.generate(count, (i) {
      final name = names[i % names.length];
      return Applicant(
        name: name,
        handle: '@${name.toLowerCase().replaceAll(' ', '_')}',
        rate: rates[i % rates.length],
      );
    });
  }
}
