import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AdminCampaignsScreen extends StatefulWidget {
  const AdminCampaignsScreen({super.key});

  @override
  State<AdminCampaignsScreen> createState() => _AdminCampaignsScreenState();
}

class _AdminCampaignsScreenState extends State<AdminCampaignsScreen> {
  String _filter = 'All';

  final List<Map<String, dynamic>> _campaigns = [
    {'title': 'Summer Glow 2026', 'brand': 'Aura Essence', 'budget': '₹37,500', 'applicants': 42, 'hired': 3, 'status': 'Active'},
    {'title': 'Tech Unboxing Series', 'brand': 'TechNova', 'budget': '₹25,000', 'applicants': 18, 'hired': 1, 'status': 'Active'},
    {'title': 'SS25 Lookbook', 'brand': 'Silas Studio', 'budget': '₹26,600', 'applicants': 31, 'hired': 4, 'status': 'Completed'},
    {'title': 'Luxury Travel Diaries', 'brand': 'Le Voyage', 'budget': '₹50,000', 'applicants': 56, 'hired': 2, 'status': 'Active'},
    {'title': 'Mindful Living', 'brand': 'Zenith Wellness', 'budget': '₹15,000', 'applicants': 12, 'hired': 0, 'status': 'Paused'},
    {'title': 'Spring Refresh', 'brand': 'Velvet & Stone', 'budget': '₹23,300', 'applicants': 24, 'hired': 2, 'status': 'Completed'},
    {'title': 'Clean Beauty', 'brand': 'FreshBites', 'budget': '₹18,000', 'applicants': 9, 'hired': 0, 'status': 'Draft'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All' ? _campaigns : _campaigns.where((c) => c['status'] == _filter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Campaign Oversight', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome)),
        const SizedBox(height: 4),
        Text('View all active and completed campaigns across the platform.', style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5))),
        const SizedBox(height: 20),
        _buildFilterRow(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) => _CampaignTile(campaign: filtered[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    final filters = ['All', 'Active', 'Completed', 'Paused', 'Draft'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isActive = _filter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(f, style: TextStyle(fontSize: 11, color: isActive ? AuraColors.midnight : AuraColors.chrome)),
              selected: isActive,
              selectedColor: AuraColors.sage,
              backgroundColor: AuraColors.obsidian,
              side: BorderSide(color: isActive ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.1)),
              onSelected: (_) => setState(() => _filter = f),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CampaignTile extends StatelessWidget {
  const _CampaignTile({required this.campaign});
  final Map<String, dynamic> campaign;

  Color _statusColor(String status) {
    switch (status) {
      case 'Active': return AuraColors.sage;
      case 'Completed': return const Color(0xFF7EB5D6);
      case 'Paused': return const Color(0xFFE8A87C);
      case 'Draft': return AuraColors.chrome.withOpacity(0.4);
      default: return AuraColors.chrome;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(campaign['title'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AuraColors.chrome)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(campaign['status']).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(campaign['status'], style: TextStyle(fontSize: 10, color: _statusColor(campaign['status']), fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('by ${campaign['brand']}', style: TextStyle(fontSize: 12, color: AuraColors.chrome.withOpacity(0.4))),
          const SizedBox(height: 10),
          Row(
            children: [
              _Stat(icon: Icons.attach_money, value: campaign['budget']),
              const SizedBox(width: 16),
              _Stat(icon: Icons.people_outline, value: '${campaign['applicants']} applied'),
              const SizedBox(width: 16),
              _Stat(icon: Icons.handshake_outlined, value: '${campaign['hired']} hired'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value});
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AuraColors.sage.withOpacity(0.6)),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(fontSize: 11, color: AuraColors.chrome.withOpacity(0.5))),
      ],
    );
  }
}
