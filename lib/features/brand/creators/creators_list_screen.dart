import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class CreatorsListScreen extends StatefulWidget {
  const CreatorsListScreen({super.key});

  @override
  State<CreatorsListScreen> createState() => _CreatorsListScreenState();
}

class _CreatorsListScreenState extends State<CreatorsListScreen> {
  String _selectedNiche = 'All';
  final List<String> _niches = ['All', 'Fashion', 'Tech', 'Travel', 'Lifestyle'];

  @override
  Widget build(BuildContext context) {
    // Mock data for display
    final allCreators = [
      {'name': 'Creator #1000', 'niche': 'Fashion'},
      {'name': 'Creator #1001', 'niche': 'Tech'},
      {'name': 'Creator #1002', 'niche': 'Food'},
      {'name': 'Creator #1003', 'niche': 'Travel'},
      {'name': 'Creator #1004', 'niche': 'Gaming'},
      {'name': 'Creator #1005', 'niche': 'Fashion'},
      {'name': 'Creator #1006', 'niche': 'Lifestyle'},
    ];

    final filteredCreators = _selectedNiche == 'All'
        ? allCreators
        : allCreators.where((c) => c['niche'] == _selectedNiche).toList();

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
          'DISCOVER CREATORS',
          style: TextStyle(fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredCreators.length,
              itemBuilder: (context, index) {
                final creator = filteredCreators[index];
                return _CreatorCard(
                  name: creator['name']!,
                  niche: creator['niche']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: TextField(
        style: TextStyle(color: AuraColors.chrome),
        decoration: InputDecoration(
          hintText: 'Search by niche or handle...',
          hintStyle: TextStyle(color: AuraColors.chrome.withOpacity(0.3)),
          prefixIcon: Icon(Icons.search, color: AuraColors.sage),
          filled: true,
          fillColor: AuraColors.obsidian,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _niches.length,
        itemBuilder: (context, index) {
          final niche = _niches[index];
          final isSelected = _selectedNiche == niche;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(niche),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedNiche = niche;
                });
              },
              backgroundColor: AuraColors.obsidian,
              selectedColor: AuraColors.sage.withOpacity(0.2),
              showCheckmark: false,
              labelStyle: TextStyle(
                color: isSelected ? AuraColors.sage : AuraColors.chrome.withOpacity(0.6),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: isSelected ? AuraColors.sage : Colors.white.withOpacity(0.05)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CreatorCard extends StatelessWidget {
  const _CreatorCard({required this.name, required this.niche});
  final String name;
  final String niche;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AuraColors.sage.withOpacity(0.1),
            child: const Icon(Icons.person, color: AuraColors.sage, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: AuraColors.chrome, fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 4),
                Text(
                  '@********',
                  style: TextStyle(color: AuraColors.chrome.withOpacity(0.4), fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  niche,
                  style: const TextStyle(color: AuraColors.sage, fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '12.5k',
                style: TextStyle(color: AuraColors.chrome, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                'Subscribers',
                style: TextStyle(color: Colors.white24, fontSize: 9),
              ),
              const SizedBox(height: 12),
              _ViewButton(
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.profileBento,
                  arguments: {
                    'isPublicView': true,
                    'customDisplayName': name,
                    'customHandle': '@********',
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewButton extends StatelessWidget {
  const _ViewButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AuraColors.sage.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('PORTFOLIO', style: TextStyle(color: AuraColors.sage, fontSize: 9, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
