import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

// ── Local data model ──
class _PayoutMethod {
  _PayoutMethod({
    required this.type,
    required this.detail,
    required this.isDefault,
    required this.icon,
  });

  String type;
  String detail;
  bool isDefault;
  IconData icon;
}

class PayoutMethodsScreen extends StatefulWidget {
  const PayoutMethodsScreen({super.key});

  @override
  State<PayoutMethodsScreen> createState() => _PayoutMethodsScreenState();
}

class _PayoutMethodsScreenState extends State<PayoutMethodsScreen> {
  // Starting methods pre-seeded from mock values
  final List<_PayoutMethod> _methods = [
    _PayoutMethod(
      type: 'Goldman Sachs Bank',
      detail: 'Checking ••• 8842',
      isDefault: true,
      icon: Icons.account_balance,
    ),
    _PayoutMethod(
      type: 'Stripe Account',
      detail: 'aura_prod_9921_ca',
      isDefault: false,
      icon: Icons.credit_card_outlined,
    ),
  ];

  void _openSheet({_PayoutMethod? existing, int? index}) {
    final typeCtrl = TextEditingController(text: existing?.type ?? '');
    final detailCtrl = TextEditingController(text: existing?.detail ?? '');
    IconData selectedIcon = existing?.icon ?? Icons.account_balance;

    HapticFeedback.mediumImpact();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx2, setSheetState) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx2).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                border: Border.all(
                  color: AuraColors.textPrimary.withOpacity(0.08),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AuraColors.textPrimary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    existing == null ? 'Add Payout Method' : 'Edit Method',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: AuraColors.chrome,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Enter the account details below.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AuraColors.textPrimary.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Icon type selector
                  Row(
                    children: [
                      for (final pair in [
                        (Icons.account_balance, 'Bank'),
                        (Icons.credit_card_outlined, 'Card'),
                        (Icons.phone_android, 'UPI/Wallet'),
                      ])
                        GestureDetector(
                          onTap: () =>
                              setSheetState(() => selectedIcon = pair.$1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: selectedIcon == pair.$1
                                  ? AuraColors.sage.withOpacity(0.15)
                                  : AuraColors.obsidian.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selectedIcon == pair.$1
                                    ? AuraColors.sage.withOpacity(0.5)
                                    : AuraColors.textPrimary.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  pair.$1,
                                  size: 12,
                                  color: selectedIcon == pair.$1
                                      ? AuraColors.sage
                                      : AuraColors.textPrimary.withOpacity(0.4),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  pair.$2,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: selectedIcon == pair.$1
                                        ? AuraColors.sage
                                        : AuraColors.textPrimary
                                            .withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _Field(
                    controller: typeCtrl,
                    hint: 'Account name (e.g. HDFC Bank)',
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 10),
                  _Field(
                    controller: detailCtrl,
                    hint: 'Detail (e.g. ••••1234 or UPI handle)',
                    icon: Icons.info_outline,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (existing != null && index != null)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _methods.removeAt(index));
                              Navigator.of(ctx).pop();
                              HapticFeedback.heavyImpact();
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: Colors.red.withOpacity(0.25)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AuraColors.sage,
                              foregroundColor: AuraColors.midnight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              final name = typeCtrl.text.trim();
                              final detail = detailCtrl.text.trim();
                              if (name.isEmpty) return;
                              setState(() {
                                if (existing != null && index != null) {
                                  _methods[index].type = name;
                                  _methods[index].detail = detail;
                                  _methods[index].icon = selectedIcon;
                                } else {
                                  _methods.add(_PayoutMethod(
                                    type: name,
                                    detail: detail,
                                    isDefault: _methods.isEmpty,
                                    icon: selectedIcon,
                                  ));
                                }
                              });
                              Navigator.of(ctx).pop();
                              HapticFeedback.lightImpact();
                            },
                            child: Text(
                              existing == null ? 'Add Method' : 'Save Changes',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _setDefault(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      for (int i = 0; i < _methods.length; i++) {
        _methods[i].isDefault = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _Header(
              onAdd: () => _openSheet(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'LINKED ACCOUNTS',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 3,
                        color: AuraColors.textPrimary.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_methods.isEmpty)
                      _EmptyState(onAdd: () => _openSheet())
                    else
                      for (int i = 0; i < _methods.length; i++) ...[
                        _PayoutCard(
                          method: _methods[i],
                          onEdit: () =>
                              _openSheet(existing: _methods[i], index: i),
                          onSetDefault: () => _setDefault(i),
                        ),
                        if (i < _methods.length - 1) const SizedBox(height: 12),
                      ],
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AuraColors.obsidian.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AuraColors.textPrimary.withOpacity(0.1)),
                      ),
                      child: Text(
                        'Payouts are automatically initiated every Monday at 08:00 UTC. '
                        'Processing times depend on your financial institution.',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.5,
                          color: AuraColors.textPrimary.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: GestureDetector(
                        onTap: () => _openSheet(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AuraColors.obsidian,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AuraColors.textPrimary.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 16,
                                color: AuraColors.textPrimary.withOpacity(0.6),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'ADD NEW PAYOUT METHOD',
                                style: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  color:
                                      AuraColors.textPrimary.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
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

// ── Header ──
class _Header extends StatelessWidget {
  const _Header({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
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
              color: AuraColors.chrome,
            ),
          ),
          const Expanded(
            child: Text(
              'Payout Methods',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
            onPressed: onAdd,
            icon: Icon(
              Icons.add_circle_outline,
              color: AuraColors.sage,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Payout Card ──
class _PayoutCard extends StatelessWidget {
  const _PayoutCard({
    required this.method,
    required this.onEdit,
    required this.onSetDefault,
  });

  final _PayoutMethod method;
  final VoidCallback onEdit;
  final VoidCallback onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: method.isDefault
              ? AuraColors.sage.withOpacity(0.3)
              : AuraColors.textPrimary.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: method.isDefault
                      ? AuraColors.sage.withOpacity(0.12)
                      : AuraColors.textPrimary.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  method.icon,
                  size: 20,
                  color: method.isDefault
                      ? AuraColors.sage
                      : AuraColors.textPrimary.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      method.type,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (method.detail.isNotEmpty)
                      Text(
                        method.detail,
                        style: TextStyle(
                          fontSize: 11,
                          color: AuraColors.textPrimary.withOpacity(0.45),
                        ),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AuraColors.textPrimary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AuraColors.textPrimary.withOpacity(0.08)),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 11,
                      color: AuraColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: method.isDefault ? null : onSetDefault,
            child: Row(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        method.isDefault ? AuraColors.sage : Colors.transparent,
                    border: Border.all(
                      color: method.isDefault
                          ? AuraColors.sage
                          : AuraColors.textPrimary.withOpacity(0.25),
                      width: 1.5,
                    ),
                  ),
                  child: method.isDefault
                      ? Icon(Icons.check, size: 9, color: AuraColors.midnight)
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  method.isDefault ? 'Default payout method' : 'Set as default',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.5,
                    color: method.isDefault
                        ? AuraColors.sage.withOpacity(0.8)
                        : AuraColors.textPrimary.withOpacity(0.35),
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

// ── Empty State ──
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AuraColors.obsidian.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AuraColors.textPrimary.withOpacity(0.08),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_outlined,
              size: 28,
              color: AuraColors.textPrimary.withOpacity(0.2),
            ),
            const SizedBox(height: 8),
            Text(
              'No payout methods yet. Tap to add one.',
              style: TextStyle(
                fontSize: 12,
                color: AuraColors.textPrimary.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Input Field ──
class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    required this.icon,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 13, color: AuraColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 13,
            color: AuraColors.textPrimary.withOpacity(0.3),
          ),
          prefixIcon: Icon(
            icon,
            size: 18,
            color: AuraColors.textPrimary.withOpacity(0.3),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
