import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = false;
  bool _newDeals = true;
  bool _messages = true;
  bool _paymentUpdates = true;

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
                    const _SectionLabel('GLOBAL PREFERENCES'),
                    _SettingsCard(
                      children: <Widget>[
                        _SwitchRow(
                          label: 'Push Notifications',
                          description: 'Receive alerts on your device',
                          value: _pushEnabled,
                          onChanged: (val) =>
                              setState(() => _pushEnabled = val),
                        ),
                        const _Divider(),
                        _SwitchRow(
                          label: 'Email Summaries',
                          description: 'Weekly recap of portfolio performance',
                          value: _emailEnabled,
                          onChanged: (val) =>
                              setState(() => _emailEnabled = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _SectionLabel('ALERT TYPES'),
                    // Only show alert toggles if push notifications are enabled
                    Opacity(
                      opacity: _pushEnabled ? 1.0 : 0.5,
                      child: IgnorePointer(
                        ignoring: !_pushEnabled,
                        child: _SettingsCard(
                          children: <Widget>[
                            _SwitchRow(
                              label: 'New Deals',
                              description:
                                  'When a brand sends a collaboration offer',
                              value: _newDeals,
                              onChanged: (val) =>
                                  setState(() => _newDeals = val),
                            ),
                            const _Divider(),
                            _SwitchRow(
                              label: 'Messages',
                              description:
                                  'New chat messages in Collaboration Center',
                              value: _messages,
                              onChanged: (val) =>
                                  setState(() => _messages = val),
                            ),
                            const _Divider(),
                            _SwitchRow(
                              label: 'Payment Updates',
                              description:
                                  'When payouts are initiated or completed',
                              value: _paymentUpdates,
                              onChanged: (val) =>
                                  setState(() => _paymentUpdates = val),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              'Notifications',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 40),
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
