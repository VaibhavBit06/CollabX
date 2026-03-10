import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class BrandWalletScreen extends StatelessWidget {
  const BrandWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
        title: Text(
          'BRAND WALLET',
          style: TextStyle(fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 32),
            _buildActionRow(context),
            const SizedBox(height: 32),
            _buildTransactionsHeader(),
            const SizedBox(height: 16),
            _buildTransactionItem(
              title: 'Funds Added',
              date: 'Mar 08, 2026',
              amount: '+₹50,000',
              isCredit: true,
            ),
            _buildTransactionItem(
              title: 'Payment to @creator123',
              date: 'Mar 05, 2026',
              amount: '-₹7,500',
              isCredit: false,
            ),
            _buildTransactionItem(
              title: 'Payment to @style_vibe',
              date: 'Mar 02, 2026',
              amount: '-₹12,000',
              isCredit: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AuraColors.sage.withOpacity(0.05),
            AuraColors.midnight,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'AVAILABLE BALANCE',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: AuraColors.chrome.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '₹42,500',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w200,
              color: AuraColors.chrome,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatCell(label: 'Total Spent', value: '₹1,24,000'),
              const SizedBox(width: 40),
              _StatCell(label: 'Pending', value: '₹12,000'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _WalletAction(
            icon: Icons.add_circle_outline,
            label: 'Add Funds',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _WalletAction(
            icon: Icons.history,
            label: 'Statements',
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'RECENT TRANSACTIONS',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: AuraColors.chrome.withOpacity(0.4),
          ),
        ),
        Icon(Icons.tune, color: AuraColors.chrome, size: 16),
      ],
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required bool isCredit,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: isCredit ? AuraColors.sage.withOpacity(0.1) : AuraColors.chrome.withOpacity(0.05),
            child: Icon(
              isCredit ? Icons.add : Icons.remove,
              color: isCredit ? AuraColors.sage : AuraColors.chrome,
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: AuraColors.chrome, fontSize: 14, fontWeight: FontWeight.w300),
                ),
                Text(
                  date,
                  style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isCredit ? AuraColors.sage : AuraColors.chrome,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(fontSize: 9, color: AuraColors.chrome.withOpacity(0.4), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: AuraColors.chrome, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class _WalletAction extends StatelessWidget {
  const _WalletAction({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AuraColors.sage, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: AuraColors.chrome, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
