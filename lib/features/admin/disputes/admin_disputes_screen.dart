import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminDisputesScreen extends StatefulWidget {
  const AdminDisputesScreen({super.key});

  @override
  State<AdminDisputesScreen> createState() => _AdminDisputesScreenState();
}

class _AdminDisputesScreenState extends State<AdminDisputesScreen> {
  final List<Map<String, dynamic>> _disputes = [
    {'raisedBy': 'Aura Essence (Brand)', 'against': 'Sohail Khan (Creator)', 'campaign': 'Summer Glow 2026', 'reason': 'Deliverables not matching brief requirements', 'status': 'Open', 'date': 'Mar 08, 2026'},
    {'raisedBy': 'Priya Sharma (Creator)', 'against': 'TechNova (Brand)', 'campaign': 'Tech Unboxing', 'reason': 'Payment delayed by 15 days after approval', 'status': 'In Review', 'date': 'Mar 05, 2026'},
    {'raisedBy': 'Le Voyage (Brand)', 'against': 'Arjun Mehta (Creator)', 'campaign': 'Luxury Travel', 'reason': 'Content posted before campaign launch date', 'status': 'Open', 'date': 'Mar 03, 2026'},
    {'raisedBy': 'Zara Khan (Creator)', 'against': 'Silas Studio (Brand)', 'campaign': 'SS25 Lookbook', 'reason': 'Scope creep — brand requested extra deliverables', 'status': 'Resolved', 'date': 'Feb 28, 2026'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dispute Resolution', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('Handle conflicts between brands and creators.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _disputes.length,
            itemBuilder: (context, index) => _DisputeTile(
              dispute: _disputes[index],
              onResolve: () => setState(() => _disputes[index]['status'] = 'Resolved'),
              onReview: () => setState(() => _disputes[index]['status'] = 'In Review'),
            ),
          ),
        ),
      ],
    );
  }
}

class _DisputeTile extends StatelessWidget {
  const _DisputeTile({required this.dispute, required this.onResolve, required this.onReview});
  final Map<String, dynamic> dispute;
  final VoidCallback onResolve, onReview;

  Color _statusColor(String status) {
    switch (status) {
      case 'Open': return const Color(0xFFFF6B6B);
      case 'In Review': return const Color(0xFFE8A87C);
      case 'Resolved': return AuraColors.sage;
      default: return AuraColors.chrome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = dispute['status'] as String;
    final isActionable = status != 'Resolved';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActionable ? _statusColor(status).withOpacity(0.2) : AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(status).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status.toUpperCase(), style: TextStyle(fontSize: 10, color: _statusColor(status), fontWeight: FontWeight.w600, letterSpacing: 1)),
              ),
              Text(dispute['date'], style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.3))),
            ],
          ),
          const SizedBox(height: 12),
          Text(dispute['campaign'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AuraColors.chrome)),
          const SizedBox(height: 6),
          _InfoRow(icon: Icons.flag_outlined, label: 'Raised by', value: dispute['raisedBy']),
          const SizedBox(height: 4),
          _InfoRow(icon: Icons.person_outline, label: 'Against', value: dispute['against']),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuraColors.midnight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              dispute['reason'],
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AuraColors.chrome.withOpacity(0.5), height: 1.4),
            ),
          ),
          if (isActionable) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (status == 'Open')
                  Expanded(child: _ActionBtn(label: 'START REVIEW', color: const Color(0xFFE8A87C), onTap: onReview)),
                if (status == 'In Review')
                  Expanded(child: _ActionBtn(label: 'RESOLVE DISPUTE', color: AuraColors.sage, onTap: onResolve)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AuraColors.chrome.withOpacity(0.3)),
        const SizedBox(width: 6),
        Text('$label: ', style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.3))),
        Expanded(child: Text(value, style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.6)))),
      ],
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
