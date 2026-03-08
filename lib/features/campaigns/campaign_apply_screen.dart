import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/utils/mock_data.dart';

class CampaignApplyScreen extends StatefulWidget {
  const CampaignApplyScreen({super.key});

  @override
  State<CampaignApplyScreen> createState() => _CampaignApplyScreenState();
}

class _CampaignApplyScreenState extends State<CampaignApplyScreen> {
  final TextEditingController _pitchController = TextEditingController();
  final TextEditingController _rateController =
      TextEditingController(text: MockCampaignApply.defaultRate.toString());
  String _deliverable = MockCampaignApply.deliverables.first;
  bool _submitted = false;

  static const List<String> _deliverables = MockCampaignApply.deliverables;

  @override
  void dispose() {
    _pitchController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_pitchController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a pitch message')),
      );
      return;
    }
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: _submitted
            ? _SuccessView(onDone: () => Navigator.of(context).pop())
            : _FormView(
                pitchController: _pitchController,
                rateController: _rateController,
                deliverable: _deliverable,
                deliverables: _deliverables,
                onDeliverableChanged: (String v) =>
                    setState(() => _deliverable = v),
                onSubmit: _submit,
                onBack: () => Navigator.of(context).maybePop(),
              ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({
    required this.pitchController,
    required this.rateController,
    required this.deliverable,
    required this.deliverables,
    required this.onDeliverableChanged,
    required this.onSubmit,
    required this.onBack,
  });

  final TextEditingController pitchController;
  final TextEditingController rateController;
  final String deliverable;
  final List<String> deliverables;
  final void Function(String) onDeliverableChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 24, 0),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: onBack,
                icon: Icon(Icons.arrow_back_ios_new,
                    color: AuraColors.chrome),
              ),
              Expanded(
                child: Text(
                  'Apply to Campaign',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.5,
                    color: AuraColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AuraColors.obsidian,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AuraColors.sage.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.business_center,
                            color: AuraColors.sage, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            MockCampaignApply.brand,
                            style: TextStyle(
                                fontSize: 15,
                                color: AuraColors.textPrimary,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            MockCampaignApply.campaignName,
                            style: TextStyle(
                                fontSize: 12,
                                color: AuraColors.textPrimary.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _SectionLabel('SELECT DELIVERABLE'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: deliverables.map((String d) {
                    final bool selected = d == deliverable;
                    return GestureDetector(
                      onTap: () => onDeliverableChanged(d),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected
                              ? AuraColors.sage.withOpacity(0.15)
                              : AuraColors.obsidian,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selected
                                ? AuraColors.sage
                                : AuraColors.textPrimary.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          d,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected
                                ? AuraColors.sage
                                : AuraColors.textPrimary.withOpacity(0.5),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
                _SectionLabel('YOUR RATE (INR)'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AuraColors.obsidian,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        '₹',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                          color: AuraColors.sage,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: rateController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: AuraColors.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _SectionLabel('YOUR PITCH'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AuraColors.obsidian,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: TextField(
                    controller: pitchController,
                    maxLines: 6,
                    style: TextStyle(
                        fontSize: 14, color: AuraColors.textPrimary, height: 1.5),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: MockCampaignApply.pitchPlaceholder,
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: AuraColors.textPrimary.withOpacity(0.3),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AuraColors.sage,
                      foregroundColor: AuraColors.midnight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: onSubmit,
                    child: const Text(
                      'SUBMIT APPLICATION',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.onDone});
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AuraColors.sage.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: AuraColors.sage.withOpacity(0.3)),
            ),
            child: const Icon(Icons.check, color: AuraColors.sage, size: 36),
          ),
          const SizedBox(height: 28),
          Text(
            'Application Sent!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w200,
              color: AuraColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            MockCampaignApply.successMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AuraColors.textPrimary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AuraColors.textPrimary,
                foregroundColor: AuraColors.midnight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: onDone,
              child: const Text(
                'BACK TO DISCOVER',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 9,
        letterSpacing: 3,
        color: AuraColors.textPrimary.withOpacity(0.4),
      ),
    );
  }
}
