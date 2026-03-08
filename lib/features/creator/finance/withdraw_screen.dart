import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  int _methodIndex = 0;
  bool _submitted = false;

  static final List<_PayoutMethod> _methods = MockWithdraw.methods
      .map((MockWithdrawMethod m) => _PayoutMethod(
            label: m.label,
            last4: m.last4,
            icon: m.icon,
          ))
      .toList();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    final String text = _amountController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount')),
      );
      return;
    }
    final double? amount = double.tryParse(text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
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
            : _WithdrawForm(
                amountController: _amountController,
                methods: _methods,
                selectedIndex: _methodIndex,
                onMethodChanged: (int i) => setState(() => _methodIndex = i),
                onSubmit: _submit,
                onBack: () => Navigator.of(context).maybePop(),
              ),
      ),
    );
  }
}

class _WithdrawForm extends StatelessWidget {
  const _WithdrawForm({
    required this.amountController,
    required this.methods,
    required this.selectedIndex,
    required this.onMethodChanged,
    required this.onSubmit,
    required this.onBack,
  });

  final TextEditingController amountController;
  final List<_PayoutMethod> methods;
  final int selectedIndex;
  final void Function(int) onMethodChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Header
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
                  'Withdraw Funds',
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
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Balance available
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        AuraColors.sage.withOpacity(0.2),
                        AuraColors.obsidian,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AuraColors.sage.withOpacity(0.15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'AVAILABLE',
                            style: TextStyle(
                              fontSize: 9,
                              letterSpacing: 3,
                              color: AuraColors.textPrimary.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            MockWallet.availableBalance,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w200,
                              color: AuraColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => amountController.text = '103840',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AuraColors.sage.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                                color: AuraColors.sage.withOpacity(0.3)),
                          ),
                          child: const Text(
                            'MAX',
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 2,
                              color: AuraColors.sage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'AMOUNT TO WITHDRAW',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 3,
                    color: AuraColors.textPrimary.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AuraColors.obsidian,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        MockWithdraw.currencySymbol,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w200,
                          color: AuraColors.sage,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w200,
                            color: AuraColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w200,
                              color: AuraColors.textPrimary.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Quick amounts
                Row(
                  children: MockWithdraw.quickAmounts.map((int amt) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => amountController.text = amt.toString(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AuraColors.obsidian,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AuraColors.textPrimary.withOpacity(0.1)),
                          ),
                          child: Text(
                            '${MockWithdraw.currencySymbol}$amt',
                            style: TextStyle(
                              fontSize: 11,
                              color: AuraColors.textPrimary.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
                Text(
                  'PAYOUT METHOD',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 3,
                    color: AuraColors.textPrimary.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: List<Widget>.generate(methods.length, (int i) {
                    final bool sel = i == selectedIndex;
                    final _PayoutMethod m = methods[i];
                    return GestureDetector(
                      onTap: () => onMethodChanged(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: sel
                              ? AuraColors.sage.withOpacity(0.08)
                              : AuraColors.obsidian,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: sel
                                ? AuraColors.sage
                                : AuraColors.textPrimary.withOpacity(0.07),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(m.icon,
                                color: sel ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.54),
                                size: 22),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    m.label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          sel ? AuraColors.textPrimary : AuraColors.textPrimary.withOpacity(0.7),
                                    ),
                                  ),
                                  if (m.last4.isNotEmpty)
                                    Text(
                                      '••••  ${m.last4}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AuraColors.textPrimary.withOpacity(0.4),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (sel)
                              const Icon(Icons.check_circle,
                                  color: AuraColors.sage, size: 18),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
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
                      'CONFIRM WITHDRAWAL',
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
            'Withdrawal Initiated',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w200,
              color: AuraColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your funds will arrive within 1–3 business days to your selected payout method.',
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
                'BACK TO WALLET',
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

class _PayoutMethod {
  const _PayoutMethod({
    required this.label,
    required this.last4,
    required this.icon,
  });

  final String label;
  final String last4;
  final IconData icon;
}
