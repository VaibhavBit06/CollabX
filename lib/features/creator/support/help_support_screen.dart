import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: Stack(
        children: <Widget>[
          const _BackgroundTexture(),
          SafeArea(
            child: Column(
              children: const <Widget>[
                _Header(),
                Expanded(
                  child: _Content(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(
            color: AuraColors.textPrimary.withOpacity(0.05),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: Icon(
                Icons.chevron_left,
                color: AuraColors.textPrimary.withOpacity(0.7),
              ),
              label: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 17,
                  color: AuraColors.textPrimary.withOpacity(0.7),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AuraColors.textPrimary.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          const Text(
            'Help & Support',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SearchField(),
          const SizedBox(height: 24),
          const _CommonQuestionsSection(),
          const SizedBox(height: 24),
          const _CategoriesSection(),
          const SizedBox(height: 32),
          const _StillNeedHelpCard(),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  MockSupport.teamName,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w200,
                    color: AuraColors.textPrimary.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AuraColors.obsidian,
            hintText: 'Search for articles...',
            hintStyle: TextStyle(
              color: AuraColors.textPrimary.withOpacity(0.2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AuraColors.textPrimary.withOpacity(0.05),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AuraColors.textPrimary.withOpacity(0.05),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AuraColors.chrome.withOpacity(0.2),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 40,
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          bottom: 10,
          child: Icon(
            Icons.search,
            color: AuraColors.textPrimary.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

class _CommonQuestionsSection extends StatelessWidget {
  const _CommonQuestionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _SectionTitle('Common Questions'),
        SizedBox(height: 8),
        _GlassListCard(
          items: <_ListItem>[
            _ListItem(
              icon: Icons.payments_outlined,
              title: 'How do I get paid?',
            ),
            _ListItem(
              icon: Icons.gavel_outlined,
              title: 'Managing disputes',
            ),
            _ListItem(
              icon: Icons.verified_user_outlined,
              title: 'Identity verification FAQ',
            ),
            _ListItem(
              icon: Icons.schedule_outlined,
              title: 'Campaign deadlines',
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _SectionTitle('Categories'),
        SizedBox(height: 12),
        _CategoryGrid(),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          letterSpacing: 3,
          fontWeight: FontWeight.w600,
          color: AuraColors.textPrimary.withOpacity(0.4),
        ),
      ),
    );
  }
}

class _GlassListCard extends StatelessWidget {
  const _GlassListCard({required this.items});

  final List<_ListItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AuraColors.textPrimary.withOpacity(0.05),
        ),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < items.length; i++)
            Column(
              children: <Widget>[
                _IosListItem(item: items[i]),
                if (i != items.length - 1)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 1,
                    color: AuraColors.textPrimary.withOpacity(0.05),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ListItem {
  const _ListItem({required this.icon, required this.title});

  final IconData icon;
  final String title;
}

class _IosListItem extends StatelessWidget {
  const _IosListItem({required this.item});

  final _ListItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loading ${item.title}...')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  item.icon,
                  color: AuraColors.sage.withOpacity(0.6),
                ),
                const SizedBox(width: 12),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: AuraColors.textPrimary.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    final List<_Category> categories = <_Category>[
      const _Category('Earnings', '12 articles', Icons.account_balance_wallet),
      const _Category('Collaborations', '8 articles', Icons.campaign),
      const _Category('Security', '5 articles', Icons.security),
      const _Category('Performance', '9 articles', Icons.star_rate),
    ];

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: categories.map((_Category category) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AuraColors.obsidian.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AuraColors.textPrimary.withOpacity(0.05),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                category.icon,
                color: AuraColors.chrome.withOpacity(0.4),
              ),
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                category.subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: AuraColors.textPrimary.withOpacity(0.3),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _Category {
  const _Category(this.title, this.subtitle, this.icon);

  final String title;
  final String subtitle;
  final IconData icon;
}

class _StillNeedHelpCard extends StatelessWidget {
  const _StillNeedHelpCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AuraColors.obsidian,
            AuraColors.midnight,
          ],
        ),
        border: Border.all(
          color: AuraColors.textPrimary.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _AvatarCircle(label: MockSupport.avatarInitials[0]),
              const SizedBox(width: 8),
              _AvatarCircle(label: MockSupport.avatarInitials[1]),
              const SizedBox(width: 8),
              _AvatarCircle(label: MockSupport.avatarInitials[2]),
            ],
          ),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: <Color>[
                  Color(0xFFF3F4F6),
                  Color(0xFF9CA3AF),
                  Color(0xFFD1D5DB),
                ],
              ).createShader(bounds);
            },
            child: Text(
              'Still need help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: AuraColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Our support team is available 24/7',
            style: TextStyle(
              fontSize: 12,
              color: AuraColors.textPrimary.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Connecting to Support...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AuraColors.chrome,
                foregroundColor: AuraColors.midnight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Chat with Support'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AuraColors.sage.withOpacity(0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AuraColors.midnight,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class _BackgroundTexture extends StatelessWidget {
  const _BackgroundTexture();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            radius: 1.2,
            colors: <Color>[
              Color(0x059DB4A0),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
