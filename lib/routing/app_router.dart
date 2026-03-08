import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/features/home/splash_screen.dart';
import 'package:aura_influencer_portfolio/features/home/portfolio_intro_screen.dart';
import 'package:aura_influencer_portfolio/features/auth/auth_welcome_screen.dart';
import 'package:aura_influencer_portfolio/features/auth/login_screen.dart';
import 'package:aura_influencer_portfolio/features/auth/sign_up_screen.dart';
import 'package:aura_influencer_portfolio/features/auth/forgot_password_screen.dart';
import 'package:aura_influencer_portfolio/features/auth/creator_type_selection_screen.dart';
import 'package:aura_influencer_portfolio/features/auth/basic_profile_setup_screen.dart';

import 'package:aura_influencer_portfolio/features/home/home_dashboard_screen.dart';
import 'package:aura_influencer_portfolio/features/marketplace/deals_inbox_screen.dart';
import 'package:aura_influencer_portfolio/features/marketplace/deal_chat_screen.dart';
import 'package:aura_influencer_portfolio/features/settings/settings_screen.dart';
import 'package:aura_influencer_portfolio/features/settings/account_security_screen.dart';
import 'package:aura_influencer_portfolio/features/finance/payout_methods_screen.dart';
import 'package:aura_influencer_portfolio/features/marketplace/deal_details_screen.dart';
import 'package:aura_influencer_portfolio/features/analytics/engagement_rate_screen.dart';
import 'package:aura_influencer_portfolio/features/analytics/platform_growth_screen.dart';
import 'package:aura_influencer_portfolio/features/analytics/weekly_snapshot_screen.dart';
import 'package:aura_influencer_portfolio/features/campaigns/campaign_brief_screen.dart';

import 'package:aura_influencer_portfolio/features/support/help_support_screen.dart';
import 'package:aura_influencer_portfolio/features/settings/social_links_screen.dart';

import 'package:aura_influencer_portfolio/features/profile/profile_bento_screen.dart';
import 'package:aura_influencer_portfolio/features/marketplace/brand_marketplace_screen.dart';
import 'package:aura_influencer_portfolio/features/campaigns/campaign_apply_screen.dart';
import 'package:aura_influencer_portfolio/features/finance/wallet_screen.dart';
import 'package:aura_influencer_portfolio/features/finance/withdraw_screen.dart';
import 'package:aura_influencer_portfolio/features/admin/admin_dashboard_screen.dart';
import 'package:aura_influencer_portfolio/features/settings/personal_details_screen.dart';
import 'package:aura_influencer_portfolio/features/settings/theme_selection_screen.dart';
import 'package:aura_influencer_portfolio/utils/constants.dart';

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

  static const String profileBento = '/profile-bento';
  static const String brandMarketplace = '/brand-marketplace';
  static const String campaignApply = '/campaign-apply';
  static const String wallet = '/wallet';
  static const String withdraw = '/withdraw';
  static const String adminDashboard = '/admin-dashboard';
  static const String personalDetails = '/personal-details';
  static const String themeSelection = '/theme-selection';
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
        final creatorType = settings.arguments as CreatorType? ?? CreatorType.independent;
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

      case AppRoutes.profileBento:
        return _buildPage(
          settings,
          const ProfileBentoScreen(),
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
