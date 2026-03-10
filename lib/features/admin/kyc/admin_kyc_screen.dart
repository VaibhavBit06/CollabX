import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/kyc_data.dart';
import 'package:intl/intl.dart';

class AdminKycScreen extends StatefulWidget {
  const AdminKycScreen({super.key});

  @override
  State<AdminKycScreen> createState() => _AdminKycScreenState();
}

class _AdminKycScreenState extends State<AdminKycScreen> {
  // We use setState to manually trigger a rebuild when buttons are pressed.
  // In a full app, a state management solution (like Provider or Riverpod) would handle this.
  
  void _approveKyc(String name, String docType) {
    KycData.instance.approveKyc(name, docType);
    setState(() {}); // Trigger UI refresh to remove from pending queue
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('KYC Approved')),
    );
  }

  void _rejectKyc(String name, String docType) {
    KycData.instance.rejectKyc(name, docType);
    setState(() {}); // Trigger UI refresh
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('KYC Rejected'), backgroundColor: const Color(0xFFFF6B6B)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Only show pending submissions in the admin review queue
    final pendingSubmissions = KycData.instance.pendingSubmissions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('KYC Verification', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('Review uploaded KYC documents. Approve or reject with notes.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        
        if (pendingSubmissions.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 60, color: AuraColors.sage.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text('All caught up!', style: TextStyle(fontSize: 18, color: AuraColors.chrome.withOpacity(0.8))),
                  const SizedBox(height: 8),
                  Text('No pending KYC submissions to review.', style: TextStyle(fontSize: 12, color: AuraColors.chrome.withOpacity(0.5))),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: pendingSubmissions.length,
              itemBuilder: (context, index) {
                final sub = pendingSubmissions[index];
                return _KycTile(
                  doc: {
                    'creator': sub.creatorName,
                    'handle': sub.handle,
                    'docType': sub.documentType,
                    'uploadDate': DateFormat('MMM dd, yyyy').format(sub.uploadDate),
                    'status': sub.status,
                  },
                  onApprove: () => _approveKyc(sub.creatorName, sub.documentType),
                  onReject: () => _rejectKyc(sub.creatorName, sub.documentType),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _KycTile extends StatelessWidget {
  const _KycTile({required this.doc, required this.onApprove, required this.onReject});
  final Map<String, dynamic> doc;
  final VoidCallback onApprove, onReject;

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved': return AuraColors.sage;
      case 'Rejected': return const Color(0xFFFF6B6B);
      default: return const Color(0xFF7EB5D6);
    }
  }

  IconData _docIcon(String docType) {
    switch (docType) {
      case 'PAN Card': return Icons.credit_card;
      case 'Aadhaar Card': return Icons.badge;
      case 'Bank Proof': return Icons.account_balance;
      default: return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = doc['status'] as String;
    final isPending = status == 'Pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isPending ? const Color(0xFF7EB5D6).withOpacity(0.2) : AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _statusColor(status).withOpacity(0.1),
                child: Icon(_docIcon(doc['docType']), color: _statusColor(status), size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doc['creator'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AuraColors.chrome)),
                    const SizedBox(height: 2),
                    Text('${doc['handle']}  •  ${doc['docType']}', style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.4))),
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
          const SizedBox(height: 8),
          Text('Uploaded: ${doc['uploadDate']}', style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.3))),
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(label: 'APPROVE', color: AuraColors.sage, onTap: onApprove),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(label: 'REJECT', color: const Color(0xFFFF6B6B), onTap: onReject),
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
        child: Center(child: Text(label, style: TextStyle(fontSize: 10, letterSpacing: 1.5, color: color, fontWeight: FontWeight.w600))),
      ),
    );
  }
}
