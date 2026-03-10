import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _isPublic = true;
  bool _allowSearchIndexing = true;
  bool _showFollowers = true;
  bool _allowDirectMessages = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _SectionLabel('PROFILE VISIBILITY'),
                    _SettingsCard(
                      children: <Widget>[
                        _SwitchRow(
                          label: 'Public Profile',
                          description: 'Anyone can see your portfolio',
                          value: _isPublic,
                          onChanged: (val) => setState(() => _isPublic = val),
                        ),
                        const _Divider(),
                        _SwitchRow(
                          label: 'Search Engine Indexing',
                          description:
                              'Allow search engines to find your profile',
                          value: _allowSearchIndexing,
                          onChanged: (val) =>
                              setState(() => _allowSearchIndexing = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _SectionLabel('INTERACTIONS'),
                    _SettingsCard(
                      children: <Widget>[
                        _SwitchRow(
                          label: 'Show Follower Count',
                          description:
                              'Display your total followers on your portfolio',
                          value: _showFollowers,
                          onChanged: (val) =>
                              setState(() => _showFollowers = val),
                        ),
                        const _Divider(),
                        _SwitchRow(
                          label: 'Allow Direct Messages',
                          description: 'Brands can message you directly',
                          value: _allowDirectMessages,
                          onChanged: (val) =>
                              setState(() => _allowDirectMessages = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _SectionLabel('DATA & HISTORY'),
                    _SettingsCard(
                      children: <Widget>[
                        _ActionRow(
                          icon: Icons.download_outlined,
                          label: 'Download Support Data',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Downloading data...')),
                            );
                          },
                        ),
                        const _Divider(),
                        _ActionRow(
                          icon: Icons.delete_outline,
                          iconColor: Colors.redAccent,
                          labelColor: Colors.redAccent,
                          label: 'Delete Account',
                          onTap: () {
                            _showDeleteConfirmation(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AuraColors.obsidian,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Delete Account?',
            style: TextStyle(
                color: AuraColors.chrome,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        content: Text(
          'This action is permanent and cannot be undone. All your data will be erased.',
          style: TextStyle(
              color: AuraColors.textPrimary.withOpacity(0.6),
              fontSize: 13,
              height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: AuraColors.sage)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deletion requested')),
              );
            },
            child: Text('Delete',
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: AuraColors.sage,
            ),
          ),
          const Expanded(
            child: Text(
              'Privacy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 40), // Balance the back button
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 3,
          fontWeight: FontWeight.w600,
          color: AuraColors.textPrimary.withOpacity(0.3),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AuraColors.obsidian.withOpacity(0.4),
        border: Border.all(color: AuraColors.borderSubtle),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: AuraColors.chrome,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                      color: AuraColors.textPrimary.withOpacity(0.4),
                      fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AuraColors.sage,
            activeTrackColor: AuraColors.sage.withOpacity(0.2),
            inactiveThumbColor: AuraColors.textPrimary.withOpacity(0.4),
            inactiveTrackColor: AuraColors.obsidian,
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AuraColors.sage, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                    color: labelColor ?? AuraColors.chrome,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Icon(Icons.chevron_right,
                color: AuraColors.textPrimary.withOpacity(0.3), size: 20),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white.withOpacity(0.05),
    );
  }
}
