import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _Header(onBack: () => Navigator.of(context).maybePop()),
            const SizedBox(height: 20),
            const _BalanceCard(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: _WithdrawButton(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.withdraw),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    'TRANSACTION HISTORY',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                      color: AuraColors.textPrimary.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(child: _AllTransactionList()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_ios_new, color: AuraColors.chrome),
          ),
          Text(
            'Wallet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: AuraColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.payoutMethods),
            icon: Icon(Icons.tune,
                color: AuraColors.textPrimary.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AuraColors.sage.withOpacity(0.25),
              AuraColors.obsidian,
              AuraColors.midnight,
            ],
          ),
          border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'AVAILABLE BALANCE',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 3,
                    color: AuraColors.textPrimary.withOpacity(0.45),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AuraColors.sage.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    '● ACTIVE',
                    style: TextStyle(
                        fontSize: 8, letterSpacing: 2, color: AuraColors.sage),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              MockWallet.availableBalance,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w200,
                color: AuraColors.textPrimary,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              MockWallet.monthlyEarnings,
              style: TextStyle(
                fontSize: 12,
                color: AuraColors.sage.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                height: 1, color: AuraColors.textPrimary.withOpacity(0.08)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _StatCol(label: 'Pending', value: MockWallet.pendingAmount),
                _StatCol(label: 'Lifetime', value: MockWallet.lifetimeEarnings),
                _StatCol(
                    label: 'Campaigns', value: MockWallet.campaignsCompleted),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCol extends StatelessWidget {
  const _StatCol({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 2,
            color: AuraColors.textPrimary.withOpacity(0.35),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AuraColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────── Withdraw Button ────────────────────────

class _WithdrawButton extends StatelessWidget {
  const _WithdrawButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AuraColors.sage,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_upward, color: AuraColors.midnight, size: 20),
            const SizedBox(width: 10),
            Text(
              'Withdraw',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AuraColors.midnight,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────── Combined Transaction List ────────────────────────

class _AllTransactionList extends StatelessWidget {
  const _AllTransactionList();

  static final List<_TxData> _all = [
    ...MockTransactions.history.map((t) => _TxData(
          brand: t.brand,
          description: t.description,
          amount: t.amount,
          date: t.date,
          status: t.status,
          isCredit: t.isCredit,
        )),
    ...MockTransactions.pending.map((t) => _TxData(
          brand: t.brand,
          description: t.description,
          amount: t.amount,
          date: t.date,
          status: t.status,
          isCredit: t.isCredit,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
      itemCount: _all.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, int i) => _TxCard(tx: _all[i]),
    );
  }
}

class _TxCard extends StatelessWidget {
  const _TxCard({required this.tx});
  final _TxData tx;

  @override
  Widget build(BuildContext context) {
    final Color amountColor = tx.isCredit
        ? AuraColors.sage
        : AuraColors.textPrimary.withOpacity(0.54);
    final Color statusColor = tx.status == 'Received'
        ? AuraColors.sage.withOpacity(0.8)
        : tx.status == 'In Review'
            ? Colors.amber.withOpacity(0.8)
            : AuraColors.textPrimary.withOpacity(0.38);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tx.isCredit
                  ? AuraColors.sage.withOpacity(0.12)
                  : Colors.red.withOpacity(0.12),
            ),
            child: Icon(
              tx.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: tx.isCredit ? AuraColors.sage : Colors.redAccent,
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tx.brand,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AuraColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tx.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: AuraColors.textPrimary.withOpacity(0.45),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                tx.amount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: amountColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                tx.date,
                style: TextStyle(
                  fontSize: 10,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TxData {
  const _TxData({
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
