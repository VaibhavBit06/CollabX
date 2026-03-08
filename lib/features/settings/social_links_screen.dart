import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class SocialLinksScreen extends StatelessWidget {
  const SocialLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Header(),
              const SizedBox(height: 32),
              const _TitleSection(),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: const <Widget>[
                    _SocialConnectCard(
                      icon: Icons.camera_alt,
                      platformName: 'Instagram',
                      username: '@lexicreates',
                      isConnected: true,
                    ),
                    SizedBox(height: 16),
                    _SocialConnectCard(
                      icon: Icons.music_note,
                      platformName: 'TikTok',
                      isConnected: false,
                    ),
                    SizedBox(height: 16),
                    _SocialConnectCard(
                      icon: Icons.play_arrow,
                      platformName: 'YouTube',
                      isConnected: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _ContinueSection(
                onContinue: () {
                  Navigator.of(context).pushNamed(AppRoutes.home);
                },
                onSkip: () {
                  Navigator.of(context).pushNamed(AppRoutes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'STEP 2 OF 5',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
                color: AuraColors.sage,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                _progressBarSegment(active: true),
                _progressBarSegment(active: true),
                _progressBarSegment(active: false),
                _progressBarSegment(active: false),
                _progressBarSegment(active: false),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.chevron_left,
            color: AuraColors.textPrimary.withOpacity(0.4),
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _progressBarSegment({required bool active}) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 24,
      height: 1,
      color: active ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.1),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Connect your\nsocials',
          style: TextStyle(
            fontSize: 32,
            height: 1.1,
            fontWeight: FontWeight.w200,
            color: AuraColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Link your primary platforms to build your portfolio and start calculating your reach.',
          style: TextStyle(
            color: Color(0x66FFFFFF),
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class _SocialConnectCard extends StatelessWidget {
  const _SocialConnectCard({
    required this.icon,
    required this.platformName,
    this.username,
    required this.isConnected,
  });

  final IconData icon;
  final String platformName;
  final String? username;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isConnected ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AuraColors.textPrimary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AuraColors.textPrimary.withOpacity(0.7)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  platformName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AuraColors.textPrimary,
                  ),
                ),
                if (username != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    username!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AuraColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isConnected)
            const Text(
              'Connected',
              style: TextStyle(
                fontSize: 12,
                color: AuraColors.sage,
              ),
            )
          else
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Connecting $platformName...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AuraColors.textPrimary.withOpacity(0.1),
                foregroundColor: AuraColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Connect', style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }
}

class _ContinueSection extends StatelessWidget {
  const _ContinueSection({required this.onContinue, required this.onSkip});

  final VoidCallback onContinue;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 64,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AuraColors.textPrimary,
              foregroundColor: AuraColors.midnight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: onContinue,
            child: const Text(
              'CONTINUE',
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: InkWell(
            onTap: onSkip,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SKIP FOR NOW',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w400,
                  color: AuraColors.textPrimary.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
