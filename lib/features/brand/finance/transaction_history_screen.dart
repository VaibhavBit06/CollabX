import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

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
          'TRANSACTION HISTORY',
          style: TextStyle(fontSize: 12, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: 8,
        itemBuilder: (context, index) {
          final isCredit = index % 3 == 0;
          return _TransactionTile(
            type: isCredit ? 'Add Funds' : 'Payout',
            date: 'Oct ${24 - index}, 2026',
            amount: isCredit ? '+₹50,000' : '-₹12,400',
            recipient: isCredit ? 'Via UPI' : 'to @creator_$index',
            isCredit: isCredit,
          );
        },
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.type,
    required this.date,
    required this.amount,
    required this.recipient,
    required this.isCredit,
  });

  final String type, date, amount, recipient;
  final bool isCredit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isCredit ? AuraColors.sage : Colors.redAccent).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.add : Icons.north_east,
              color: isCredit ? AuraColors.sage : Colors.redAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(color: AuraColors.chrome, fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Text(
                  recipient,
                  style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: isCredit ? AuraColors.sage : AuraColors.chrome,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
