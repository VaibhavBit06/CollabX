import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminPaymentsScreen extends StatefulWidget {
  const AdminPaymentsScreen({super.key});

  @override
  State<AdminPaymentsScreen> createState() => _AdminPaymentsScreenState();
}

class _AdminPaymentsScreenState extends State<AdminPaymentsScreen> {
  String _filter = 'All';

  final List<Map<String, dynamic>> _payments = [
    {'brand': 'Aura Essence', 'creator': 'Sohail Khan', 'campaign': 'Summer Glow 2026', 'amount': '₹37,500', 'status': 'held_in_escrow', 'date': 'Mar 08, 2026'},
    {'brand': 'TechNova', 'creator': 'Priya Sharma', 'campaign': 'Tech Unboxing', 'amount': '₹25,000', 'status': 'deliverables_submitted', 'date': 'Mar 07, 2026'},
    {'brand': 'Le Voyage', 'creator': 'Arjun Mehta', 'campaign': 'Travel Diaries', 'amount': '₹50,000', 'status': 'approved_for_release', 'date': 'Mar 06, 2026'},
    {'brand': 'Silas Studio', 'creator': 'Zara Khan', 'campaign': 'SS25 Lookbook', 'amount': '₹26,600', 'status': 'payout_completed', 'date': 'Mar 04, 2026'},
    {'brand': 'Zenith Wellness', 'creator': 'Ananya Iyer', 'campaign': 'Mindful Living', 'amount': '₹15,000', 'status': 'payment_declined', 'date': 'Mar 03, 2026'},
    {'brand': 'FreshBites', 'creator': 'Raj Malhotra', 'campaign': 'Clean Beauty', 'amount': '₹18,000', 'status': 'payment_stuck', 'date': 'Mar 02, 2026'},
    {'brand': 'Aura Essence', 'creator': 'Priya Sharma', 'campaign': 'Winter Collection', 'amount': '₹42,000', 'status': 'refund_initiated', 'date': 'Feb 28, 2026'},
    {'brand': 'TechNova', 'creator': 'Sohail Khan', 'campaign': 'Gadget Review', 'amount': '₹30,000', 'status': 'disputed', 'date': 'Feb 25, 2026'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All' ? _payments : _payments.where((p) => p['status'] == _filter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('Master Account overview. Approve payouts, handle declined & stuck payments.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 16),
        _MasterAccountCard(),
        const SizedBox(height: 20),
        _buildFilterRow(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) => _PaymentTile(
              payment: filtered[index],
              onApprove: () => setState(() => filtered[index]['status'] = 'payout_completed'),
              onRefund: () => setState(() => filtered[index]['status'] = 'refund_initiated'),
              onRetry: () => setState(() => filtered[index]['status'] = 'held_in_escrow'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    final filters = ['All', 'held_in_escrow', 'deliverables_submitted', 'approved_for_release', 'payment_declined', 'payment_stuck', 'disputed'];
    final labels = ['All', 'In Escrow', 'Deliverables', 'Approved', 'Declined', 'Stuck', 'Disputed'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (i) {
          final isActive = _filter == filters[i];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(labels[i], style: TextStyle(fontSize: 10, color: isActive ? AuraColors.midnight : AuraColors.chrome)),
              selected: isActive,
              selectedColor: AuraColors.sage,
              backgroundColor: AuraColors.obsidian,
              side: BorderSide(color: isActive ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.1)),
              onSelected: (_) => setState(() => _filter = filters[i]),
            ),
          );
        }),
      ),
    );
  }
}

class _MasterAccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AuraColors.sage.withOpacity(0.12), AuraColors.obsidian.withOpacity(0.8)],
        ),
        border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text('MASTER ACCOUNT', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.sage.withOpacity(0.7))),
          const SizedBox(height: 8),
          Text('₹2,44,100', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
          const SizedBox(height: 4),
          Text('Total held in escrow', style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.4))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat(label: 'INCOMING', value: '₹3,20,000'),
              Container(width: 1, height: 30, color: AuraColors.textPrimary.withOpacity(0.1)),
              _MiniStat(label: 'RELEASED', value: '₹1,75,900'),
              Container(width: 1, height: 30, color: AuraColors.textPrimary.withOpacity(0.1)),
              _MiniStat(label: 'REFUNDED', value: '₹42,000'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 8, letterSpacing: 2, color: AuraColors.chrome.withOpacity(0.3), fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, color: AuraColors.chrome, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.payment, required this.onApprove, required this.onRefund, required this.onRetry});
  final Map<String, dynamic> payment;
  final VoidCallback onApprove, onRefund, onRetry;

  String _statusLabel(String status) {
    switch (status) {
      case 'held_in_escrow': return 'In Escrow';
      case 'deliverables_submitted': return 'Deliverables Submitted';
      case 'approved_for_release': return 'Approved for Release';
      case 'payout_completed': return 'Payout Completed';
      case 'payment_declined': return 'Payment Declined';
      case 'payment_stuck': return 'Payment Stuck';
      case 'refund_initiated': return 'Refund Initiated';
      case 'disputed': return 'Disputed';
      default: return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'held_in_escrow': return const Color(0xFF7EB5D6);
      case 'deliverables_submitted': return const Color(0xFFE8A87C);
      case 'approved_for_release': return AuraColors.sage;
      case 'payout_completed': return AuraColors.sage;
      case 'payment_declined': return const Color(0xFFFF6B6B);
      case 'payment_stuck': return const Color(0xFFFF6B6B);
      case 'refund_initiated': return const Color(0xFFE8A87C);
      case 'disputed': return const Color(0xFFFF6B6B);
      default: return AuraColors.chrome;
    }
  }

  bool _showActions(String status) {
    return ['deliverables_submitted', 'approved_for_release', 'payment_declined', 'payment_stuck', 'disputed'].contains(status);
  }

  @override
  Widget build(BuildContext context) {
    final status = payment['status'] as String;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _showActions(status) ? _statusColor(status).withOpacity(0.2) : AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${payment['brand']} → ${payment['creator']}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AuraColors.chrome)),
                    const SizedBox(height: 2),
                    Text(payment['campaign'], style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.4))),
                  ],
                ),
              ),
              Text(payment['amount'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AuraColors.sage)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(status).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_statusLabel(status), style: TextStyle(fontSize: 10, color: _statusColor(status), fontWeight: FontWeight.w600)),
              ),
              Text(payment['date'], style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.3))),
            ],
          ),
          if (_showActions(status)) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (status == 'deliverables_submitted' || status == 'approved_for_release')
                  Expanded(child: _ActionBtn(label: 'RELEASE FUNDS', color: AuraColors.sage, onTap: onApprove)),
                if (status == 'payment_declined' || status == 'payment_stuck')
                  Expanded(child: _ActionBtn(label: 'RETRY / FLAG', color: const Color(0xFFE8A87C), onTap: onRetry)),
                if (status == 'disputed') ...[
                  Expanded(child: _ActionBtn(label: 'RELEASE', color: AuraColors.sage, onTap: onApprove)),
                  const SizedBox(width: 8),
                  Expanded(child: _ActionBtn(label: 'REFUND', color: const Color(0xFFFF6B6B), onTap: onRefund)),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({required this.label, required this.color, required this.onTap});
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Center(child: Text(label, style: TextStyle(fontSize: 10, letterSpacing: 1.5, color: color, fontWeight: FontWeight.w600))),
      ),
    );
  }
}
