import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminBrandsScreen extends StatelessWidget {
  const AdminBrandsScreen({super.key});

  static final List<Map<String, dynamic>> _brands = [
    {'name': 'Aura Essence', 'category': 'Beauty & Personal Care', 'campaigns': 12, 'totalSpend': '₹4,50,000', 'status': 'Verified'},
    {'name': 'Silas Studio', 'category': 'Fashion & Apparel', 'campaigns': 8, 'totalSpend': '₹2,12,800', 'status': 'Verified'},
    {'name': 'Le Voyage', 'category': 'Travel & Hospitality', 'campaigns': 5, 'totalSpend': '₹3,50,000', 'status': 'Pending'},
    {'name': 'Zenith Wellness', 'category': 'Health & Wellness', 'campaigns': 3, 'totalSpend': '₹75,000', 'status': 'Verified'},
    {'name': 'TechNova', 'category': 'Tech & Gadgets', 'campaigns': 15, 'totalSpend': '₹6,80,000', 'status': 'Verified'},
    {'name': 'FreshBites', 'category': 'Food & Beverage', 'campaigns': 2, 'totalSpend': '₹30,000', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Brand Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('View brands, campaigns, and payment history.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _brands.length,
            itemBuilder: (context, index) => _BrandTile(brand: _brands[index]),
          ),
        ),
      ],
    );
  }
}

class _BrandTile extends StatelessWidget {
  const _BrandTile({required this.brand});
  final Map<String, dynamic> brand;

  @override
  Widget build(BuildContext context) {
    final isVerified = brand['status'] == 'Verified';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF7EB5D6).withOpacity(0.15),
            child: const Icon(Icons.business, color: Color(0xFF7EB5D6), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(brand['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AuraColors.chrome)),
                    const SizedBox(width: 8),
                    if (isVerified) Icon(Icons.verified, color: AuraColors.sage, size: 14),
                  ],
                ),
                const SizedBox(height: 2),
                Text(brand['category'], style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.4))),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _Tag(label: '${brand['campaigns']} campaigns'),
                    const SizedBox(width: 8),
                    _Tag(label: 'Spent: ${brand['totalSpend']}'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: (isVerified ? AuraColors.sage : const Color(0xFFE8A87C)).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              brand['status'],
              style: TextStyle(fontSize: 10, color: isVerified ? AuraColors.sage : const Color(0xFFE8A87C), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AuraColors.midnight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Text(label, style: TextStyle(fontSize: 9, color: AuraColors.chrome.withOpacity(0.5), fontWeight: FontWeight.w500)),
    );
  }
}
