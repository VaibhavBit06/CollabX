import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminDeliverablesScreen extends StatefulWidget {
  const AdminDeliverablesScreen({super.key});

  @override
  State<AdminDeliverablesScreen> createState() => _AdminDeliverablesScreenState();
}

class _AdminDeliverablesScreenState extends State<AdminDeliverablesScreen> {
  final List<Map<String, dynamic>> _deliverables = [
    {'creator': 'Sohail Khan', 'campaign': 'Summer Glow 2026', 'type': 'Dedicated Reel', 'submitted': 'Mar 08, 2026', 'status': 'Pending Review'},
    {'creator': 'Priya Sharma', 'campaign': 'Tech Unboxing Series', 'type': 'In-Feed Post', 'submitted': 'Mar 07, 2026', 'status': 'Pending Review'},
    {'creator': 'Arjun Mehta', 'campaign': 'SS25 Lookbook', 'type': 'Story Series', 'submitted': 'Mar 06, 2026', 'status': 'Approved'},
    {'creator': 'Zara Khan', 'campaign': 'Luxury Travel Diaries', 'type': 'UGC Package', 'submitted': 'Mar 05, 2026', 'status': 'Revision Requested'},
    {'creator': 'Ananya Iyer', 'campaign': 'Summer Glow 2026', 'type': 'Full Campaign', 'submitted': 'Mar 04, 2026', 'status': 'Pending Review'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Deliverable Review', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('Review submitted work from creators. Approve or request revision.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _deliverables.length,
            itemBuilder: (context, index) => _DeliverableTile(
              deliverable: _deliverables[index],
              onApprove: () => setState(() => _deliverables[index]['status'] = 'Approved'),
              onRevision: () => setState(() => _deliverables[index]['status'] = 'Revision Requested'),
            ),
          ),
        ),
      ],
    );
  }
}

class _DeliverableTile extends StatelessWidget {
  const _DeliverableTile({required this.deliverable, required this.onApprove, required this.onRevision});
  final Map<String, dynamic> deliverable;
  final VoidCallback onApprove;
  final VoidCallback onRevision;

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved': return AuraColors.sage;
      case 'Revision Requested': return const Color(0xFFE8A87C);
      default: return const Color(0xFF7EB5D6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = deliverable['status'] as String;
    final isPending = status == 'Pending Review';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isPending ? AuraColors.sage.withOpacity(0.2) : AuraColors.textPrimary.withOpacity(0.06)),
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
                    Text(deliverable['creator'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AuraColors.chrome)),
                    const SizedBox(height: 2),
                    Text(deliverable['campaign'], style: TextStyle(fontSize: 12, color: AuraColors.chrome.withOpacity(0.4))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(status).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(fontSize: 10, color: _statusColor(status), fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.attachment, size: 14, color: AuraColors.chrome.withOpacity(0.4)),
              const SizedBox(width: 6),
              Text(deliverable['type'], style: TextStyle(fontSize: 12, color: AuraColors.chrome.withOpacity(0.6))),
              const Spacer(),
              Text('Submitted: ${deliverable['submitted']}', style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.3))),
            ],
          ),
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(label: 'APPROVE', color: AuraColors.sage, onTap: onApprove),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(label: 'REQUEST REVISION', color: const Color(0xFFE8A87C), onTap: onRevision),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color, required this.onTap});
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
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 10, letterSpacing: 1.5, color: color, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
