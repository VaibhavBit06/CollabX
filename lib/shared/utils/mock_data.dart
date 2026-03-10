import 'package:flutter/material.dart';

class MockCampaign {
  const MockCampaign({
    required this.brand,
    required this.tagline,
    required this.category,
    required this.budget,
    required this.deadline,
    required this.minFollowers,
    required this.niches,
    required this.isHot,
    required this.targetColleges,
    required this.targetCities,
  });

  final String brand;
  final String tagline;
  final String category;
  final String budget;
  final String deadline;
  final String minFollowers;
  final List<String> niches;
  final bool isHot;
  final List<String> targetColleges;
  final List<String> targetCities;
}

class MockCampaigns {
  MockCampaigns._();

  static const List<MockCampaign> all = <MockCampaign>[
    MockCampaign(
      brand: 'Aura Essence',
      tagline: 'Global Fragrance Campaign',
      category: 'Beauty',
      budget: '₹37,500',
      deadline: 'Mar 20',
      minFollowers: '50K',
      niches: <String>['Luxury', 'Lifestyle'],
      isHot: true,
      targetColleges: <String>['All'],
      targetCities: <String>['Mumbai', 'Delhi'],
    ),
    MockCampaign(
      brand: 'Silas Studio',
      tagline: 'SS25 Lookbook Partnership',
      category: 'Fashion',
      budget: '₹26,600',
      deadline: 'Mar 28',
      minFollowers: '30K',
      niches: <String>['Fashion', 'Editorial'],
      isHot: false,
      targetColleges: <String>['NIFT', 'Pearl Academy'],
      targetCities: <String>['All'],
    ),
    MockCampaign(
      brand: 'Velvet & Stone',
      tagline: 'Interior Spring Refresh',
      category: 'Lifestyle',
      budget: '₹23,300',
      deadline: 'Apr 05',
      minFollowers: '20K',
      niches: <String>['Interior', 'Minimalism'],
      isHot: false,
      targetColleges: <String>['All'],
      targetCities: <String>['All'],
    ),
    MockCampaign(
      brand: 'Le Voyage',
      tagline: 'Luxury Travel Diaries',
      category: 'Travel',
      budget: '₹50,000',
      deadline: 'Apr 12',
      minFollowers: '80K',
      niches: <String>['Travel', 'Luxury'],
      isHot: true,
      targetColleges: <String>['All'],
      targetCities: <String>['Bangalore'],
    ),
    MockCampaign(
      brand: 'Zenith Wellness',
      tagline: 'Mindful Living Campaign',
      category: 'Wellness',
      budget: '₹15,000',
      deadline: 'Apr 18',
      minFollowers: '15K',
      niches: <String>['Wellness', 'Authentic'],
      isHot: false,
      targetColleges: <String>['All'],
      targetCities: <String>['Mumbai', 'Pune'],
    ),
  ];
}

// ──────────────────────── Wallet ────────────────────────

class MockWallet {
  MockWallet._();

  static const String availableBalance = '₹1,03,840.00';
  static const String monthlyEarnings = '+₹23,300 this month';
  static const String pendingAmount = '₹26,600';
  static const String lifetimeEarnings = '₹4,02,850';
  static const String campaignsCompleted = '14';
}

// ──────────────────────── Transactions ────────────────────────

class MockTransaction {
  const MockTransaction({
    required this.brand,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
    required this.isCredit,
  });

  final String brand;
  final String description;
  final String amount;
  final String date;
  final String status;
  final bool isCredit;
}

class MockTransactions {
  MockTransactions._();

  static const List<MockTransaction> history = <MockTransaction>[
    MockTransaction(
      brand: 'Aura Essence',
      description: 'Dedicated Reel \u2014 March',
      amount: '+₹37,500',
      date: 'Mar 02, 2025',
      status: 'Received',
      isCredit: true,
    ),
    MockTransaction(
      brand: 'Withdrawal',
      description: 'To UPI \u2022\u20225234',
      amount: '-₹16,600',
      date: 'Feb 28, 2025',
      status: 'Completed',
      isCredit: false,
    ),
    MockTransaction(
      brand: 'Velvet & Stone',
      description: 'Spring Lookbook Content',
      amount: '+₹23,300',
      date: 'Feb 20, 2025',
      status: 'Received',
      isCredit: true,
    ),
    MockTransaction(
      brand: 'Silas Studio',
      description: 'SS25 Campaign Package',
      amount: '+₹26,600',
      date: 'Feb 10, 2025',
      status: 'Received',
      isCredit: true,
    ),
    MockTransaction(
      brand: 'Withdrawal',
      description: 'To UPI \u2022\u20225234',
      amount: '-₹33,250',
      date: 'Jan 31, 2025',
      status: 'Completed',
      isCredit: false,
    ),
  ];

  static const List<MockTransaction> pending = <MockTransaction>[
    MockTransaction(
      brand: 'Le Voyage',
      description: 'Luxury Travel Diaries \u2014 in review',
      amount: '+₹50,000',
      date: 'By Apr 15',
      status: 'In Review',
      isCredit: true,
    ),
    MockTransaction(
      brand: 'Zenith Wellness',
      description: 'Mindful Living Campaign \u2014 pending delivery',
      amount: '+₹15,000',
      date: 'By Apr 20',
      status: 'Pending',
      isCredit: true,
    ),
  ];
}

// ──────────────────────── Withdraw ────────────────────────

class MockWithdrawMethod {
  const MockWithdrawMethod({
    required this.label,
    required this.last4,
    required this.icon,
  });

  final String label;
  final String last4;
  final IconData icon;
}

class MockWithdraw {
  MockWithdraw._();

  static const List<MockWithdrawMethod> methods = <MockWithdrawMethod>[
    MockWithdrawMethod(
        label: 'UPI', last4: 'sohail@upi', icon: Icons.account_balance_wallet),
    MockWithdrawMethod(
        label: 'IMPS / Bank Transfer',
        last4: '9012',
        icon: Icons.account_balance),
    MockWithdrawMethod(label: 'Paytm', last4: '', icon: Icons.phone_android),
  ];

  static const List<int> quickAmounts = <int>[5000, 10000, 20000, 50000];
  static const String currencySymbol = '₹';
}

// ──────────────────────── Payout Methods ────────────────────────

class MockPayoutMethodInfo {
  const MockPayoutMethodInfo({
    required this.type,
    required this.detail,
    required this.status,
  });

  final String type;
  final String detail;
  final String status;
}

class MockPayoutMethods {
  MockPayoutMethods._();

  static const List<MockPayoutMethodInfo> all = <MockPayoutMethodInfo>[
    MockPayoutMethodInfo(
      type: 'Goldman Sachs Bank',
      detail: 'Checking \u2022\u2022\u2022\u2022 8842',
      status: 'Default',
    ),
    MockPayoutMethodInfo(
      type: 'Stripe Account',
      detail: 'aura_prod_9921_ca',
      status: 'Verified',
    ),
  ];

  static const String payoutNote =
      'Payouts are automatically initiated every Monday at 08:00 UTC. '
      'Processing times depend on your financial institution.';
}

// ──────────────────────── Stats ────────────────────────

class MockStats {
  MockStats._();

  // Weekly Snapshot
  static const String weeklyReach = '1.2M';
  static const String weeklyReachDelta = '+12.4%';
  static const String weeklyDateRange = 'Oct 14 — Oct 21, 2023';

  // Platform Growth / Analytics Overview
  static const String totalReach = '2.4M';
  static const String platformSplit = 'Instagram 45% • TikTok 35% • YouTube 20%';

  // New Subscribers
  static const String newSubscribers = '+12.4K';
  static const String newSubsDelta = '+8.2%';

  // Engagement Rate
  static const String avgEngagementRate = '4.82%';
  static const String avgEngagementDelta = '+0.4%';
  static const String engagementRate = '5.2%';
  static const String engagementDelta = '+0.6%';
  static const String totalLikes = '42.8k';
  static const String likesDelta = '+12%';
  static const String totalComments = '1.2k';
  static const String commentsDelta = '+8%';

  // Analytics Overview
  static const String audienceReachDelta = '+18.4%';
  static const String newFans = '+12.4K';
}

// ──────────────────────── Snapshot ────────────────────────

class MockSnapshot {
  MockSnapshot._();

  static const String topContent1 = 'Midnight Collection Launch';
  static const String topContent1Reach = '182K';
  static const String topContent2 = 'Studio Aesthetic Vibe';
  static const String topContent2Reach = '145K';
}

// ──────────────────────── User ────────────────────────

class MockUser {
  MockUser._();

  static const String firstName = 'Sohail';
  static const String lastName = 'Khan';
  static const String fullName = 'Sohail Khan';
  static const String handle = '@sohailcreates';
  static const String location = 'Mumbai, India';
  static const String city = 'Mumbai';
  static const String college = 'Mumbai University';
  static const String bio =
      'Lifestyle & fashion creator crafting cinematic stories. '
      'Collaborating with brands that value authenticity.';
  static const String email = 'sohail@collabx.in';
  static const String phone = '+91 98765 43210';
  static const String education = 'Mumbai University';
  static const String upiId = 'sohail@upi';
  static const String bankLast4 = '9012';
  static const String portfolioUrl = 'collabx.in/creator/sohailcreates';
  static const String kycStatus = 'Not Submitted';
  static const String panCard = 'ABCPK1234F';
}

// ──────────────────────── Collabs ────────────────────────

class MockCollab {
  const MockCollab({
    required this.brand,
    required this.campaign,
    required this.earned,
    required this.rating,
  });

  final String brand;
  final String campaign;
  final String earned;
  final double rating;
}

class MockCollabs {
  MockCollabs._();

  static const List<MockCollab> completed = <MockCollab>[
    MockCollab(brand: 'Nike', campaign: 'Summer Collection', earned: '₹15,000', rating: 4.8),
    MockCollab(brand: 'Spotify', campaign: 'Wrapped 2025', earned: '₹8,500', rating: 5.0),
    MockCollab(brand: 'Myntra', campaign: 'EORS Sale', earned: '₹12,000', rating: 4.5),
  ];
}

// ──────────────────────── Deal Detail ────────────────────────

class MockDealDetail {
  MockDealDetail._();

  static const String campaignLabel = 'Summer 2024 Collection';
  static const String title = 'Minimalist Essentials';
  static const List<String> tags = <String>['Fashion', 'Lifestyle'];
  static const String brief =
      'Create a series of content pieces showcasing our new linen collection '
      'in a natural environment. Focus on texture, movement, and the '
      'intersection of luxury and comfort.';
  static const String deliverable1Title = '1x TikTok Video';
  static const String deliverable1Sub = '60s max, vertical 9:16';
  static const String deliverable2Title = '2x IG Stories';
  static const String deliverable2Sub = 'Static or video with link sticker';
  static const String creativeFee = '\$2,400.00';
  static const String usageRights = '\$800.00';
  static const String totalPayout = '\$3,200.00';
}

// ──────────────────────── Deal Chat ────────────────────────

class MockDealChat {
  MockDealChat._();

  static const String brandName = 'VOGUE Studio';
  static const String status = 'Active now';
  static const String offerTitle = "Spring Editorial '24";
  static const String offerAmount = '\$4,500';
  static const String offerType = 'Fixed Rate';
  static const String timestamp = 'Monday, 14:20';
  static const String msg1 =
      'Hi Sohail, we loved your recent work for the NYC gallery opening. '
      "We'd love to have you lead the creative direction for our upcoming "
      'Spring campaign.';
  static const String msg2 =
      "Thank you so much! I'm definitely interested. Could we discuss the "
      'usage rights for the video content?';
  static const String msg3 =
      "Absolutely. We're looking at 12 months digital usage across all "
      "platforms. I've updated the offer terms in the portal.";
}

// ──────────────────────── Campaign Brief ────────────────────────

class MockCampaignBrief {
  MockCampaignBrief._();

  static const String label = 'Summer Campaign 2024';
  static const String title = 'L\u2019Essence Minimaliste';
  static const List<String> tags = <String>[
    'Editorial Photography',
    '4-Post Reel Series',
    'Paris Location',
  ];
  static const String description =
      'Seeking creators with a refined, architectural aesthetic to capture '
      'the spirit of our upcoming high-jewelry collection.';
  static const String budgetRange = '\$4,500 - \$8,000';
  static const String timeline = 'Aug 12 - Sep 05';
  static const String interest = '12 Creators expressed interest';
}

// ──────────────────────── Campaign Apply ────────────────────────

class MockCampaignApply {
  MockCampaignApply._();

  static const String brand = 'Aura Essence';
  static const String campaignName = 'Global Fragrance Campaign';
  static const int defaultRate = 37500;
  static const List<String> deliverables = <String>[
    'Dedicated Reel',
    'In-Feed Post',
    'Story Series',
    'UGC Package',
    'Full Campaign',
  ];
  static const String pitchPlaceholder =
      'Describe your vision, audience fit, and why you are the perfect '
      'creator for this brand...';
  static const String successMessage =
      'Your pitch has been submitted to Aura Essence. Expect a response '
      'within 3-5 business days.';
}

// ──────────────────────── Admin ────────────────────────

class MockAdmin {
  MockAdmin._();

  static const String creatorsCount = '128';
  static const String creatorsSubtitle = 'Active creators on CollabX';
  static const String liveCampaigns = '32';
  static const String liveCampaignsSubtitle = 'Currently running collaborations';
  static const String payoutQueue = '₹1,18,400';
  static const String payoutQueueSubtitle = 'Pending creator payouts';
}

// ──────────────────────── Support ────────────────────────

class MockSupport {
  MockSupport._();

  static const String teamName = 'Aura Creative Support';
  static const List<String> avatarInitials = <String>['SC', 'AM', '+2'];
}

// ──────────────────────── Activities ────────────────────────

class MockActivity {
  const MockActivity({
    required this.title,
    required this.trailing,
    required this.timeAgo,
    required this.iconIndex,
  });

  final String title;
  final String trailing;
  final String timeAgo;
  final int iconIndex;
}

class MockActivities {
  MockActivities._();

  static const List<MockActivity> recent = <MockActivity>[
    MockActivity(
      title: 'boAt offered ₹37,500',
      trailing: 'VIEW',
      timeAgo: '2h ago',
      iconIndex: 0,
    ),
    MockActivity(
      title: 'Payment received — ₹23,300',
      trailing: '+₹23,300',
      timeAgo: '5h ago',
      iconIndex: 1,
    ),
    MockActivity(
      title: 'Engagement up 12.4%',
      trailing: '+12.4%',
      timeAgo: '1d ago',
      iconIndex: 2,
    ),
  ];
}

// ──────────────────────── Deals ────────────────────────

class MockDeal {
  const MockDeal({
    required this.brand,
    required this.subtitle,
    required this.amount,
    required this.statusLabel,
    this.isNew = false,
    this.isActive = false,
  });

  final String brand;
  final String subtitle;
  final String amount;
  final String statusLabel;
  final bool isNew;
  final bool isActive;
}

class MockDeals {
  MockDeals._();

  static const String newCount = '3';
  static const String activeCount = '5';
  static const String totalValue = '₹1.8L';

  static const List<MockDeal> inbox = <MockDeal>[
    MockDeal(
      brand: 'Nykaa',
      subtitle: 'Summer Glow Collection • ₹37,500',
      amount: '₹37,500',
      statusLabel: 'NEW OFFER',
      isNew: true,
    ),
    MockDeal(
      brand: 'Mamaearth',
      subtitle: 'Clean Beauty Campaign • ₹26,600',
      amount: '₹26,600',
      statusLabel: 'IN REVIEW',
      isActive: true,
    ),
    MockDeal(
      brand: 'MakeMyTrip',
      subtitle: 'Luxury Travel Diaries • ₹50,000',
      amount: '₹50,000',
      statusLabel: 'ACCEPTED',
      isActive: true,
    ),
  ];
}

// ──────────────────────── Profile ────────────────────────

class MockPost {
  const MockPost({
    required this.caption,
    required this.likes,
    required this.comments,
    required this.timeAgo,
    required this.color,
  });

  final String caption;
  final String likes;
  final String comments;
  final String timeAgo;
  final int color;
}

class MockProfile {
  MockProfile._();

  static const List<String> nicheTags = <String>[
    'Fashion',
    'Lifestyle',
    'Travel',
    'Editorial',
    'Luxury',
    'Minimalism',
  ];

  static const List<MockPost> posts = <MockPost>[
    MockPost(
      caption: 'Midnight Collection Launch',
      likes: '12.4K',
      comments: '842',
      timeAgo: '2d',
      color: 0xFF7EB5D6,
    ),
    MockPost(
      caption: 'Studio Aesthetic Vibe',
      likes: '8.9K',
      comments: '531',
      timeAgo: '5d',
      color: 0xFFE8A87C,
    ),
    MockPost(
      caption: 'Mumbai Skyline at Dusk',
      likes: '15.2K',
      comments: '1.1K',
      timeAgo: '1w',
      color: 0xFFB8A9C9,
    ),
    MockPost(
      caption: 'Minimal Fashion Edit',
      likes: '6.7K',
      comments: '394',
      timeAgo: '1w',
      color: 0xFF7EB5D6,
    ),
    MockPost(
      caption: 'BTS: boAt Campaign Shoot',
      likes: '22.1K',
      comments: '1.8K',
      timeAgo: '2w',
      color: 0xFFE8C07A,
    ),
    MockPost(
      caption: 'Café Culture in Bandra',
      likes: '9.3K',
      comments: '612',
      timeAgo: '2w',
      color: 0xFF7EB5D6,
    ),
    MockPost(
      caption: 'Luxury Linen Lookbook',
      likes: '11.5K',
      comments: '789',
      timeAgo: '3w',
      color: 0xFFE8A87C,
    ),
    MockPost(
      caption: 'Golden Hour Portraits',
      likes: '18.6K',
      comments: '1.4K',
      timeAgo: '3w',
      color: 0xFFB8A9C9,
    ),
  ];
}
