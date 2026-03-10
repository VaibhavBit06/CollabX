import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminCreatorsScreen extends StatefulWidget {
  const AdminCreatorsScreen({super.key});

  @override
  State<AdminCreatorsScreen> createState() => _AdminCreatorsScreenState();
}

class _AdminCreatorsScreenState extends State<AdminCreatorsScreen> {
  String _filterStatus = 'All';

  final List<Map<String, dynamic>> _creators = [
    {'name': 'Sohail Khan', 'handle': '@sohailcreates', 'followers': '45.2K', 'kyc': 'Approved', 'campaigns': 14, 'earnings': '₹4,02,850'},
    {'name': 'Priya Sharma', 'handle': '@priyastyle', 'followers': '128K', 'kyc': 'Pending', 'campaigns': 8, 'earnings': '₹2,15,000'},
    {'name': 'Arjun Mehta', 'handle': '@arjunlens', 'followers': '67K', 'kyc': 'Approved', 'campaigns': 22, 'earnings': '₹6,80,400'},
    {'name': 'Ananya Iyer', 'handle': '@ananyavibes', 'followers': '92K', 'kyc': 'Not Submitted', 'campaigns': 3, 'earnings': '₹45,000'},
    {'name': 'Raj Malhotra', 'handle': '@rajcreates', 'followers': '31K', 'kyc': 'Rejected', 'campaigns': 5, 'earnings': '₹78,200'},
    {'name': 'Zara Khan', 'handle': '@zarafashion', 'followers': '215K', 'kyc': 'Approved', 'campaigns': 31, 'earnings': '₹9,45,000'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filterStatus == 'All'
        ? _creators
        : _creators.where((c) => c['kyc'] == _filterStatus).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Creator Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('View, verify, and manage all creators on CollabX.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        _buildFilterRow(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) => _CreatorTile(creator: filtered[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    final filters = ['All', 'Approved', 'Pending', 'Not Submitted', 'Rejected'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isActive = _filterStatus == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(f, style: TextStyle(fontSize: 11, color: isActive ? AuraColors.midnight : AuraColors.chrome)),
              selected: isActive,
              selectedColor: AuraColors.sage,
              backgroundColor: AuraColors.obsidian,
              side: BorderSide(color: isActive ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.1)),
              onSelected: (_) => setState(() => _filterStatus = f),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CreatorTile extends StatelessWidget {
  const _CreatorTile({required this.creator});
  final Map<String, dynamic> creator;

  Color _kycColor(String status) {
    switch (status) {
      case 'Approved': return AuraColors.sage;
      case 'Pending': return const Color(0xFFE8A87C);
      case 'Rejected': return const Color(0xFFFF6B6B);
      default: return AuraColors.chrome.withOpacity(0.4);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: AuraColors.sage.withOpacity(0.15),
            child: Text(
              creator['name'].substring(0, 1),
              style: const TextStyle(color: AuraColors.sage, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(creator['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AuraColors.chrome)),
                const SizedBox(height: 2),
                Text('${creator['handle']}  •  ${creator['followers']}', style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.4))),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _MiniTag(label: 'KYC: ${creator['kyc']}', color: _kycColor(creator['kyc'])),
                    const SizedBox(width: 8),
                    _MiniTag(label: '${creator['campaigns']} campaigns', color: AuraColors.chrome.withOpacity(0.5)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(creator['earnings'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AuraColors.sage)),
              const SizedBox(height: 4),
              Text('TOTAL EARNED', style: TextStyle(fontSize: 8, letterSpacing: 1.5, color: AuraColors.chrome.withOpacity(0.3))),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  const _MiniTag({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w500)),
    );
  }
}
