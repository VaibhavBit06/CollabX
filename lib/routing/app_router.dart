import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/features/creator/home/splash_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/home/portfolio_intro_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/auth/auth_welcome_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/auth/login_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/auth/sign_up_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/auth/forgot_password_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/auth/creator_type_selection_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/auth/basic_profile_setup_screen.dart';

import 'package:aura_influencer_portfolio/features/creator/home/home_dashboard_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/marketplace/deals_inbox_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/marketplace/deal_chat_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/settings_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/account_security_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/finance/payout_methods_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/marketplace/deal_details_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/analytics/engagement_rate_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/analytics/platform_growth_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/analytics/weekly_snapshot_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/campaigns/campaign_brief_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/campaigns/creator_collaborations_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/campaigns/creator_collab_details_screen.dart';

import 'package:aura_influencer_portfolio/features/creator/support/help_support_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/social_links_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/privacy_settings_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/notification_settings_screen.dart';

import 'package:aura_influencer_portfolio/features/creator/profile/profile_bento_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/marketplace/brand_marketplace_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/campaigns/campaign_apply_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/finance/wallet_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/finance/withdraw_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/admin_dashboard_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/personal_details_screen.dart';
import 'package:aura_influencer_portfolio/features/creator/settings/theme_selection_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/home/brand_dashboard_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/auth/brand_signup_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/campaigns/add_campaign_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/campaigns/collaboration_center_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/campaigns/campaign_applicants_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/campaigns/manage_campaigns_screen.dart';
// Brand wallet removed — brands pay per-campaign via Razorpay
import 'package:aura_influencer_portfolio/features/brand/campaigns/campaign_payment_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/creators/creators_list_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/settings/brand_settings_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/profile/brand_profile_preview_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/campaigns/applicant_details_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/finance/transaction_history_screen.dart';
import 'package:aura_influencer_portfolio/features/brand/campaigns/brand_deal_chat_screen.dart';
import 'package:aura_influencer_portfolio/shared/utils/constants.dart';

class AppRoutes {
  static const String splash = '/';
  static const String portfolioIntro = '/portfolio-intro';
  static const String authWelcome = '/auth-welcome';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String creatorTypeSelection = '/creator-type';
  static const String basicProfileSetup = '/basic-profile';

  static const String home = '/home';
  static const String dealsInbox = '/deals-inbox';
  static const String dealChat = '/deal-chat';
  static const String settings = '/settings';
  static const String accountSecurity = '/account-security';
  static const String payoutMethods = '/payout-methods';
  static const String dealDetails = '/deal-details';
  static const String engagementRate = '/engagement-rate';
  static const String platformGrowth = '/platform-growth';
  static const String weeklySnapshot = '/weekly-snapshot';
  static const String campaignBrief = '/campaign-brief';

  static const String helpSupport = '/help-support';
  static const String socialLinks = '/social-links';

  static const String privacySettings = '/privacy-settings';
  static const String notificationSettings = '/notification-settings';

  static const String profileBento = '/profile-bento';
  static const String brandMarketplace = '/brand-marketplace';
  static const String campaignApply = '/campaign-apply';
  static const String wallet = '/wallet';
  static const String withdraw = '/withdraw';
  static const String adminDashboard = '/admin-dashboard';
  static const String personalDetails = '/personal-details';
  static const String themeSelection = '/theme-selection';
  static const String creatorCollaborations = '/creator/collaborations';
  static const String creatorCollabDetails = '/creator/collab-details';

  // Brand Routes
  static const String brandDashboard = '/brand-dashboard';
  static const String brandSignUp = '/brand-sign-up';
  static const String addCampaign = '/add-campaign';
  static const String manageCampaigns = '/manage-campaigns';
  static const String creatorsList = '/creators-list';
  // Brand wallet removed — brands pay per-campaign via Razorpay
  static const String campaignPayment = '/campaign-payment';
  static const String brandSettings = '/brand-settings';
  static const String brandProfilePreview = '/brand-profile-preview';
  static const String applicantDetails = '/applicant-details';
  static const String campaignApplicants = '/brand/campaign-applicants';
  static const String collaborationCenter = '/brand/collaboration-center';
  static const String transactionHistory = '/transaction-history';
  static const String brandDealChat = '/brand-deal-chat';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildPage(
          settings,
          const SplashScreen(),
        );
      case AppRoutes.portfolioIntro:
        return _buildPage(
          settings,
          const PortfolioIntroScreen(),
        );
      case AppRoutes.authWelcome:
        return _buildPage(
          settings,
          const AuthWelcomeScreen(),
        );
      case AppRoutes.login:
        return _buildPage(
          settings,
          const LoginScreen(),
        );
      case AppRoutes.signUp:
        return _buildPage(
          settings,
          const SignUpScreen(),
        );
      case AppRoutes.forgotPassword:
        return _buildPage(
          settings,
          const ForgotPasswordScreen(),
        );
      case AppRoutes.creatorTypeSelection:
        return _buildPage(
          settings,
          const CreatorTypeSelectionScreen(),
        );
      case AppRoutes.basicProfileSetup:
        final creatorType =
            settings.arguments as CreatorType? ?? CreatorType.independent;
        return _buildPage(
          settings,
          BasicProfileSetupScreen(creatorType: creatorType),
        );

      case AppRoutes.home:
        return _buildPage(
          settings,
          const HomeDashboardScreen(),
        );
      case AppRoutes.dealsInbox:
        return _buildPage(
          settings,
          const DealsInboxScreen(),
        );
      case AppRoutes.dealChat:
        return _buildPage(
          settings,
          const DealChatScreen(),
        );
      case AppRoutes.settings:
        return _buildPage(
          settings,
          const SettingsScreen(),
        );
      case AppRoutes.accountSecurity:
        return _buildPage(
          settings,
          const AccountSecurityScreen(),
        );
      case AppRoutes.payoutMethods:
        return _buildPage(
          settings,
          const PayoutMethodsScreen(),
        );
      case AppRoutes.dealDetails:
        return _buildPage(
          settings,
          const DealDetailsScreen(),
        );
      case AppRoutes.engagementRate:
        return _buildPage(
          settings,
          const EngagementRateScreen(),
        );
      case AppRoutes.platformGrowth:
        return _buildPage(
          settings,
          const PlatformGrowthScreen(),
        );
      case AppRoutes.weeklySnapshot:
        return _buildPage(
          settings,
          const WeeklySnapshotScreen(),
        );
      case AppRoutes.campaignBrief:
        return _buildPage(
          settings,
          const CampaignBriefScreen(),
        );

      case AppRoutes.helpSupport:
        return _buildPage(
          settings,
          const HelpSupportScreen(),
        );
      case AppRoutes.socialLinks:
        return _buildPage(
          settings,
          const SocialLinksScreen(),
        );
      case AppRoutes.privacySettings:
        return _buildPage(
          settings,
          const PrivacySettingsScreen(),
        );
      case AppRoutes.notificationSettings:
        return _buildPage(
          settings,
          const NotificationSettingsScreen(),
        );

      case AppRoutes.profileBento:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPage(
          settings,
          ProfileBentoScreen(
            isPublicView: args?['isPublicView'] ?? false,
            customDisplayName: args?['customDisplayName'],
            customHandle: args?['customHandle'],
          ),
        );
      case AppRoutes.brandMarketplace:
        return _buildPage(
          settings,
          const BrandMarketplaceScreen(),
        );
      case AppRoutes.campaignApply:
        return _buildPage(
          settings,
          const CampaignApplyScreen(),
        );
      case AppRoutes.wallet:
        return _buildPage(
          settings,
          const WalletScreen(),
        );
      case AppRoutes.withdraw:
        return _buildPage(
          settings,
          const WithdrawScreen(),
        );
      case AppRoutes.adminDashboard:
        return _buildPage(
          settings,
          const AdminDashboardScreen(),
        );
      case AppRoutes.personalDetails:
        return _buildPage(
          settings,
          const PersonalDetailsScreen(),
        );
      case AppRoutes.themeSelection:
        return _buildPage(
          settings,
          const ThemeSelectionScreen(),
        );
      case AppRoutes.creatorCollaborations:
        return _buildPage(
          settings,
          const CreatorCollaborationsScreen(),
        );
      case AppRoutes.creatorCollabDetails:
        return _buildPage(
          settings,
          const CreatorCollabDetailsScreen(),
        );

      // Brand Cases
      case AppRoutes.brandDashboard:
        return _buildPage(
          settings,
          const BrandDashboardScreen(),
        );
      case AppRoutes.brandSignUp:
        return _buildPage(
          settings,
          const BrandSignupScreen(),
        );
      case AppRoutes.addCampaign:
        return _buildPage(
          settings,
          const AddCampaignScreen(),
        );
      case AppRoutes.manageCampaigns:
        return _buildPage(
          settings,
          const ManageCampaignsScreen(),
        );
      // Brand wallet removed — brands pay per-campaign via Razorpay
      case AppRoutes.campaignPayment:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPage(
          settings,
          CampaignPaymentScreen(
            campaignTitle: args?['campaignTitle'] ?? 'Campaign Name',
            creatorName: args?['creatorName'] ?? 'Creator Name',
            creatorHandle: args?['creatorHandle'] ?? '@handle',
            proposedRate: args?['proposedRate'] ?? '₹0',
          ),
        );
      case AppRoutes.creatorsList:
        return _buildPage(
          settings,
          const CreatorsListScreen(),
        );
      case AppRoutes.brandSettings:
        return _buildPage(
          settings,
          const BrandSettingsScreen(),
        );
      case AppRoutes.brandProfilePreview:
        return _buildPage(
          settings,
          const BrandProfilePreviewScreen(),
        );
      case AppRoutes.applicantDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPage(
          settings,
          ApplicantDetailsScreen(
            creatorName: args?['creatorName'] ?? 'Unknown Creator',
            proposedRate: args?['proposedRate'] ?? '₹0',
            campaignTitle: args?['campaignTitle'] ?? '',
          ),
        );
      case AppRoutes.campaignApplicants:
        return _buildPage(
          settings,
          const CampaignApplicantsScreen(),
        );
      case AppRoutes.collaborationCenter:
        return _buildPage(
          settings,
          const CollaborationCenterScreen(),
        );
      case AppRoutes.transactionHistory:
        return _buildPage(
          settings,
          const TransactionHistoryScreen(),
        );
      case AppRoutes.brandDealChat:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPage(
          settings,
          BrandDealChatScreen(
            creatorName: args?['creatorName'] ?? 'Sohail',
            creatorHandle: args?['creatorHandle'] ?? '@sohail.creates',
            campaignTitle: args?['campaignTitle'] ?? 'Summer Skincare Launch',
            dealAmount: args?['dealAmount'] ?? '₹35,000',
          ),
        );
      // Other brand placeholders will go here as implemented

      default:
        return _buildPage(
          settings,
          const SplashScreen(),
        );
    }
  }

  static PageRouteBuilder<dynamic> _buildPage(
    RouteSettings settings,
    Widget child,
  ) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, secondaryAnimation, widget) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(curved),
            child: widget,
          ),
        );
      },
    );
  }
}
