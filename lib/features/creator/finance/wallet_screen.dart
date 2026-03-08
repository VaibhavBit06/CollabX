import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            _ActionRow(
              onWithdraw: () =>
                  Navigator.of(context).pushNamed(AppRoutes.withdraw),
            ),
            const SizedBox(height: 24),
            _TabBar(controller: _tabController),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  _TransactionList(),
                  _PendingList(),
                ],
              ),
            ),
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
            icon:
                Icon(Icons.arrow_back_ios_new, color: AuraColors.chrome),
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
            icon: Icon(Icons.tune, color: AuraColors.textPrimary.withOpacity(0.6)),
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
            Container(height: 1, color: AuraColors.textPrimary.withOpacity(0.08)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _StatCol(label: 'Pending', value: MockWallet.pendingAmount),
                _StatCol(label: 'Lifetime', value: MockWallet.lifetimeEarnings),
                _StatCol(label: 'Campaigns', value: MockWallet.campaignsCompleted),
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

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.onWithdraw});
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _ActionButton(
              icon: Icons.arrow_upward,
              label: 'Withdraw',
              primary: true,
              onTap: onWithdraw,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.history,
              label: 'History',
              primary: false,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Full history coming soon')),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.receipt_long_outlined,
              label: 'Invoices',
              primary: false,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invoices coming soon')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.primary,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: primary ? AuraColors.sage : AuraColors.obsidian,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: primary ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.08),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: primary ? AuraColors.midnight : AuraColors.textPrimary,
              size: 20,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: primary ? AuraColors.midnight : AuraColors.textPrimary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
        child: TabBar(
          controller: controller,
          indicator: BoxDecoration(
            color: AuraColors.sage.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AuraColors.sage.withOpacity(0.3)),
          ),
          labelColor: AuraColors.sage,
          unselectedLabelColor: AuraColors.textPrimary.withOpacity(0.38),
          labelStyle: const TextStyle(
              fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w500),
          dividerColor: Colors.transparent,
          tabs: const <Tab>[
            Tab(text: 'RECEIVED'),
            Tab(text: 'PENDING'),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────── Transaction Lists ────────────────────────

class _TransactionList extends StatelessWidget {
  const _TransactionList();

  static final List<_TxData> _txs = MockTransactions.history
      .map((MockTransaction t) => _TxData(
            brand: t.brand,
            description: t.description,
            amount: t.amount,
            date: t.date,
            status: t.status,
            isCredit: t.isCredit,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      itemCount: _txs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, int i) => _TxCard(tx: _txs[i]),
    );
  }
}

class _PendingList extends StatelessWidget {
  const _PendingList();

  static final List<_TxData> _pending = MockTransactions.pending
      .map((MockTransaction t) => _TxData(
            brand: t.brand,
            description: t.description,
            amount: t.amount,
            date: t.date,
            status: t.status,
            isCredit: t.isCredit,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      itemCount: _pending.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, int i) => _TxCard(tx: _pending[i]),
    );
  }
}

class _TxCard extends StatelessWidget {
  const _TxCard({required this.tx});
  final _TxData tx;

  @override
  Widget build(BuildContext context) {
    final Color amountColor = tx.isCredit ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.54);
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
