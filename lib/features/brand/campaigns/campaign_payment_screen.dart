import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class CampaignPaymentScreen extends StatefulWidget {
  const CampaignPaymentScreen({
    super.key,
    required this.campaignTitle,
    required this.creatorName,
    required this.creatorHandle,
    required this.proposedRate,
  });

  final String campaignTitle;
  final String creatorName;
  final String creatorHandle;
  final String proposedRate;

  @override
  State<CampaignPaymentScreen> createState() => _CampaignPaymentScreenState();
}

class _CampaignPaymentScreenState extends State<CampaignPaymentScreen> {
  String _selectedMethod = 'UPI';
  bool _processing = false;

  final List<Map<String, dynamic>> _methods = [
    {'id': 'UPI', 'label': 'UPI', 'icon': Icons.phone_android, 'desc': 'Google Pay, PhonePe, Paytm'},
    {'id': 'Card', 'label': 'Card', 'icon': Icons.credit_card, 'desc': 'Visa, Mastercard, Rupay'},
    {'id': 'NetBanking', 'label': 'Net Banking', 'icon': Icons.account_balance, 'desc': 'All major banks'},
  ];

  void _handlePayment() async {
    setState(() => _processing = true);
    // Simulates Razorpay checkout — will be replaced with real integration
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _processing = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AuraColors.obsidian,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: AuraColors.sage.withOpacity(0.15), shape: BoxShape.circle),
                child: const Icon(Icons.check, color: AuraColors.sage, size: 28),
              ),
              const SizedBox(height: 16),
              Text('Payment Successful!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: AuraColors.chrome)),
              const SizedBox(height: 8),
              Text('${_getTotalAmount()} sent to Master Account (Escrow)', style: TextStyle(fontSize: 12, color: AuraColors.chrome.withOpacity(0.5)), textAlign: TextAlign.center),
              const SizedBox(height: 6),
              Text('Funds will be released to the creator once deliverables are approved by admin.', style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.35)), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(); // Close dialog
                    Navigator.of(context).pop(true); // Pop screen, return true for success
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuraColors.sage,
                    foregroundColor: AuraColors.midnight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('DONE', style: TextStyle(fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // Helper to calculate total (Adding 7% platform fee)
  String _getTotalAmount() {
    final rawRate = int.tryParse(widget.proposedRate.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final fee = (rawRate * 0.07).round();
    final total = rawRate + fee;
    // Format back with commas
    final formatted = total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return '₹$formatted';
  }

  String _getPlatformFee() {
    final rawRate = int.tryParse(widget.proposedRate.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final fee = (rawRate * 0.07).round();
    final formatted = fee.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return '₹$formatted';
  }

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
          'CAMPAIGN PAYMENT',
          style: TextStyle(fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            const SizedBox(height: 32),
            Text('PAYMENT METHOD', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.chrome.withOpacity(0.4))),
            const SizedBox(height: 12),
            ..._methods.map((m) => _PaymentMethodTile(
              method: m,
              isSelected: _selectedMethod == m['id'],
              onTap: () => setState(() => _selectedMethod = m['id']),
            )),
            const SizedBox(height: 16),
            _buildRazorpayBranding(),
            const SizedBox(height: 32),
            _buildEscrowNote(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _processing ? null : _handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _processing
                    ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: AuraColors.midnight))
                    : Text('PAY ${_getTotalAmount()}', style: const TextStyle(fontSize: 12, letterSpacing: 2.5, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AuraColors.sage.withOpacity(0.08), AuraColors.obsidian],
        ),
        border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ORDER SUMMARY', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.w600, color: AuraColors.sage.withOpacity(0.6))),
          const SizedBox(height: 16),
          _SummaryRow(label: 'Campaign', value: widget.campaignTitle),
          const SizedBox(height: 8),
          _SummaryRow(label: 'Creator', value: '${widget.creatorName} (${widget.creatorHandle})'),
          const SizedBox(height: 8),
          _SummaryRow(label: 'Agreed Amount', value: widget.proposedRate),
          const SizedBox(height: 8),
          _SummaryRow(label: 'Platform Fee (7%)', value: _getPlatformFee()),
          const SizedBox(height: 12),
          Divider(color: AuraColors.textPrimary.withOpacity(0.1)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL', style: TextStyle(fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w600, color: AuraColors.chrome)),
              Text(_getTotalAmount(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200, color: AuraColors.sage)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRazorpayBranding() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, size: 12, color: AuraColors.chrome.withOpacity(0.3)),
          const SizedBox(width: 6),
          Text('Secured by ', style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.3))),
          Text('Razorpay', style: TextStyle(fontSize: 10, color: AuraColors.sage.withOpacity(0.6), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildEscrowNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF7EB5D6).withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF7EB5D6).withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18, color: const Color(0xFF7EB5D6).withOpacity(0.6)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your payment goes to the CollabX Master Account (escrow). Funds are released to the creator only after admin verifies deliverables and KYC.',
              style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.5), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: AuraColors.chrome.withOpacity(0.4))),
        Text(value, style: TextStyle(fontSize: 12, color: AuraColors.chrome, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({required this.method, required this.isSelected, required this.onTap});
  final Map<String, dynamic> method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AuraColors.sage.withOpacity(0.08) : AuraColors.obsidian,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.08)),
          ),
          child: Row(
            children: [
              Icon(method['icon'] as IconData, size: 22, color: isSelected ? AuraColors.sage : AuraColors.chrome.withOpacity(0.4)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(method['label'], style: TextStyle(fontSize: 14, color: isSelected ? AuraColors.sage : AuraColors.chrome, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300)),
                    Text(method['desc'], style: TextStyle(fontSize: 10, color: AuraColors.chrome.withOpacity(0.35))),
                  ],
                ),
              ),
              if (isSelected) const Icon(Icons.check_circle, color: AuraColors.sage, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
