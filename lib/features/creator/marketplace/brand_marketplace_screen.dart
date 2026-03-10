import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class BrandMarketplaceScreen extends StatefulWidget {
  const BrandMarketplaceScreen({super.key});

  @override
  State<BrandMarketplaceScreen> createState() => _BrandMarketplaceScreenState();
}

class _BrandMarketplaceScreenState extends State<BrandMarketplaceScreen> {
  int _filterIndex = 0;
  
  // Smart Filtering State
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  String _selectedCollege = 'All';
  String _selectedCity = 'All';
  String _selectedCategory = 'All';
  String _selectedSort = 'Relevance';
  
  List<MockCampaign> _filteredCampaigns = [];

  // Available filter options extracted from mock data
  late List<String> _availableColleges;
  late List<String> _availableCities;
  late List<String> _availableCategories;

  @override
  void initState() {
    super.initState();
    _initFilters();
    _applyFilters();
  }

  void _initFilters() {
    // Extract unique colleges from campaigns that don't just target "All"
    final colleges = MockCampaigns.all
      .expand((c) => c.targetColleges)
      .where((c) => c != 'All')
      .toSet()
      .toList();
    colleges.sort();
    _availableColleges = ['All', ...colleges];

    // Extract unique cities
    final cities = MockCampaigns.all
      .expand((c) => c.targetCities)
      .where((c) => c != 'All')
      .toSet()
      .toList();
    cities.sort();
    _availableCities = ['All', ...cities];

    // Categories
    final categories = MockCampaigns.all.map((c) => c.category).toSet().toList();
    categories.sort();
    _availableCategories = ['All', ...categories];
  }

  void _applyFilters() {
    setState(() {
      _filteredCampaigns = MockCampaigns.all.where((campaign) {
        
        // --- 1. Base Eligibility (Does creator qualify to even see this?) ---
        final creatorCollege = MockUser.college;
        final creatorCity = MockUser.city;

        // Has Brand targeted specific colleges, and does creator match?
        final bool isCollegeAll = campaign.targetColleges.contains('All');
        final bool matchesCreatorCollege = isCollegeAll || campaign.targetColleges.contains(creatorCollege);
        
        // Has Brand targeted specific cities, and does creator match?
        final bool isCityAll = campaign.targetCities.contains('All');
        final bool matchesCreatorCity = isCityAll || campaign.targetCities.contains(creatorCity);

        // Creator MUST be eligible based on brand targeting
        if (!matchesCreatorCollege || !matchesCreatorCity) return false;

        // --- 2. Active User Filters (From the Drawer) ---
        
        // A. Filter by College (If user selects a college, show campaigns targeted to that OR targeted to "All")
        if (_selectedCollege != 'All') {
           if (!campaign.targetColleges.contains(_selectedCollege) && !isCollegeAll) {
             return false;
           }
        }

        // B. Filter by City
        if (_selectedCity != 'All') {
           if (!campaign.targetCities.contains(_selectedCity) && !isCityAll) {
             return false;
           }
        }

        // C. Filter by Category
        if (_selectedCategory != 'All') {
           if (campaign.category != _selectedCategory) return false;
        }

        // D. Quick Action filter bar (from legacy top row)
        if (_filterIndex != 0) {
           final quickFilter = ['All', 'Fashion', 'Beauty', 'Tech', 'Travel', 'Wellness'][_filterIndex];
           if (campaign.category != quickFilter) return false;
        }

        return true;
      }).toList();

      // Implement Sorting
      if (_selectedSort == 'Highest Paying') {
        _filteredCampaigns.sort((a, b) {
           final baseA = int.parse(a.budget.replaceAll(RegExp(r'[^0-9]'), ''));
           final baseB = int.parse(b.budget.replaceAll(RegExp(r'[^0-9]'), ''));
           return baseB.compareTo(baseA);
        });
      } else if (_selectedSort == 'Newest First') {
         // Mock sort by date (simulated)
         _filteredCampaigns.shuffle(); 
      } else if (_selectedSort == 'Relevance') {
        // Mock relevance: bring campaigns that EXACTLY match creator profile to top
        _filteredCampaigns.sort((a, b) {
           final aMatches = a.targetCities.contains(MockUser.city) || a.targetColleges.contains(MockUser.college);
           final bMatches = b.targetCities.contains(MockUser.city) || b.targetColleges.contains(MockUser.college);
           if (aMatches && !bMatches) return -1;
           if (!aMatches && bMatches) return 1;
           return 0;
        });
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedCollege = 'All';
      _selectedCity = 'All';
      _selectedCategory = 'All';
      _selectedSort = 'Relevance';
      _filterIndex = 0;
    });
    _applyFilters();
  }

  int get _activeFilterCount {
    int count = 0;
    if (_selectedCollege != 'All') count++;
    if (_selectedCity != 'All') count++;
    if (_selectedCategory != 'All') count++;
    if (_selectedSort != 'Relevance') count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AuraColors.midnight,
      endDrawer: _buildFilterDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _Header(
              onFilterTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              activeFilterCount: _activeFilterCount,
            ),
            const SizedBox(height: 16),
            _SearchBar(),
            const SizedBox(height: 16),
            _FilterRow(
              filters: const ['All', 'Fashion', 'Beauty', 'Tech', 'Travel', 'Wellness'],
              selectedIndex: _filterIndex,
              onSelect: (int i) {
                 setState(() => _filterIndex = i);
                 _applyFilters();
              },
            ),
            if (_activeFilterCount > 0) _buildActiveFilterChips(),
            const SizedBox(height: 16),
            Expanded(child: _CampaignList(campaigns: _filteredCampaigns)),
            const _BottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilterChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: [
                   if (_selectedCollege != 'All') _FilterChip(label: _selectedCollege, onRemove: () { setState(() => _selectedCollege = 'All'); _applyFilters(); }),
                   if (_selectedCity != 'All') _FilterChip(label: _selectedCity, onRemove: () { setState(() => _selectedCity = 'All'); _applyFilters(); }),
                   if (_selectedCategory != 'All') _FilterChip(label: _selectedCategory, onRemove: () { setState(() => _selectedCategory = 'All'); _applyFilters(); }),
                   if (_selectedSort != 'Relevance') _FilterChip(label: 'Sort: $_selectedSort', onRemove: () { setState(() => _selectedSort = 'Relevance'); _applyFilters(); }),
                 ],
               ),
            ),
          ),
          TextButton(
             onPressed: _clearFilters,
             child: Text('Clear All', style: TextStyle(fontSize: 11, color: AuraColors.sage)),
          )
        ],
      ),
    );
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      backgroundColor: AuraColors.obsidian,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: AuraColors.chrome)),
                  IconButton(
                    icon: Icon(Icons.close, color: AuraColors.chrome),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  if (MockUser.college.isEmpty || MockUser.city.isEmpty)
                   Container(
                     padding: const EdgeInsets.all(12),
                     margin: const EdgeInsets.only(bottom: 16),
                     decoration: BoxDecoration(
                        color: const Color(0xFFE8A87C).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE8A87C).withOpacity(0.3))
                     ),
                     child: Text(
                        'Complete your profile (college/city) to unlock campaigns specifically targeted to you.',
                        style: TextStyle(fontSize: 11, color: const Color(0xFFE8A87C)),
                     )
                   ),
                  _FilterSection(
                    title: 'Sort By',
                    value: _selectedSort,
                    options: const ['Relevance', 'Newest First', 'Highest Paying'],
                    onChanged: (v) => setState(() => _selectedSort = v!),
                  ),
                  const SizedBox(height: 24),
                  _FilterSection(
                    title: 'Location / City',
                    value: _selectedCity,
                    options: _availableCities,
                    onChanged: (v) => setState(() => _selectedCity = v!),
                  ),
                  const SizedBox(height: 24),
                  _FilterSection(
                    title: 'College / University',
                    value: _selectedCollege,
                    options: _availableColleges,
                    onChanged: (v) => setState(() => _selectedCollege = v!),
                  ),
                  const SizedBox(height: 24),
                  _FilterSection(
                    title: 'Category',
                    value: _selectedCategory,
                    options: _availableCategories,
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                ],
              ),
            ),
            Padding(
               padding: const EdgeInsets.all(20),
               child: SizedBox(
                 width: double.infinity,
                 height: 48,
                 child: ElevatedButton(
                    onPressed: () {
                      _applyFilters();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                       backgroundColor: AuraColors.sage,
                       foregroundColor: AuraColors.midnight,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ),
                    child: Text('SHOW MATCING CAMPAIGNS (${_filteredCampaigns.length})', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11, letterSpacing: 1.5)),
                 )
               )
            )
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.value, required this.options, required this.onChanged});
  final String title;
  final String value;
  final List<String> options;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: TextStyle(fontSize: 10, letterSpacing: 2, color: AuraColors.chrome.withOpacity(0.4), fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AuraColors.midnight.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              dropdownColor: AuraColors.obsidian,
              icon: const Icon(Icons.expand_more, color: AuraColors.sage),
              style: TextStyle(color: AuraColors.chrome, fontSize: 13, fontWeight: FontWeight.w300),
              onChanged: onChanged,
              items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.onRemove});
  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
         color: AuraColors.sage.withOpacity(0.1),
         borderRadius: BorderRadius.circular(8),
         border: Border.all(color: AuraColors.sage.withOpacity(0.3))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: AuraColors.sage)),
          const SizedBox(width: 4),
          GestureDetector(
             onTap: onRemove,
             child: Icon(Icons.close, size: 12, color: AuraColors.sage)
          )
        ],
      )
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onFilterTap, required this.activeFilterCount});
  final VoidCallback onFilterTap;
  final int activeFilterCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DISCOVER',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 4,
                  color: AuraColors.sage.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Brand Campaigns',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                  color: AuraColors.textPrimary,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.wallet),
                icon: const Icon(Icons.account_balance_wallet_outlined, color: AuraColors.sage),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: onFilterTap,
                    icon: Icon(Icons.tune, color: activeFilterCount > 0 ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.6)),
                  ),
                  if (activeFilterCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: AuraColors.sage, shape: BoxShape.circle),
                        child: Text('$activeFilterCount', style: TextStyle(fontSize: 8, color: AuraColors.midnight, fontWeight: FontWeight.bold)),
                      )
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.07)),
        ),
        child: TextField(
          style: TextStyle(fontSize: 14, color: AuraColors.textPrimary),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon:
                Icon(Icons.search, color: AuraColors.textPrimary.withOpacity(0.3)),
            hintText: 'Search brands or categories...',
            hintStyle:
                TextStyle(fontSize: 13, color: AuraColors.textPrimary.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.filters,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> filters;
  final int selectedIndex;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext ctx, int i) {
          final bool isSelected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AuraColors.sage : AuraColors.obsidian,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? AuraColors.sage
                      : AuraColors.textPrimary.withOpacity(0.1),
                ),
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? AuraColors.midnight
                      : AuraColors.textPrimary.withOpacity(0.6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CampaignList extends StatelessWidget {
  const _CampaignList({required this.campaigns});
  final List<MockCampaign> campaigns;

  @override
  Widget build(BuildContext context) {
    if (campaigns.isEmpty) {
       return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.search_off, size: 48, color: AuraColors.chrome.withOpacity(0.2)),
               const SizedBox(height: 16),
               Text('No campaigns match your filters.', style: TextStyle(color: AuraColors.chrome.withOpacity(0.5))),
            ],
          )
       );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: campaigns.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext ctx, int i) =>
          _CampaignCard(campaign: campaigns[i]),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({required this.campaign});
  final MockCampaign campaign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.campaignApply),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AuraColors.obsidian,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Brand avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AuraColors.sage.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AuraColors.sage.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.business_center,
                          color: AuraColors.sage, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          campaign.brand,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AuraColors.textPrimary,
                          ),
                        ),
                        Text(
                          campaign.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 9,
                            letterSpacing: 2,
                            color: AuraColors.sage.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    if (campaign.isHot)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color: const Color(0xFFFF6B35).withOpacity(0.4)),
                        ),
                        child: const Text(
                          '🔥 HOT',
                          style: TextStyle(
                              fontSize: 9,
                              letterSpacing: 1.5,
                              color: Color(0xFFFF6B35)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              campaign.tagline,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AuraColors.textPrimary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 14),
            // Niche chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: campaign.niches
                  .map(
                    (String n) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        border:
                            Border.all(color: AuraColors.textPrimary.withOpacity(0.1)),
                      ),
                      child: Text(
                        n,
                        style: TextStyle(
                          fontSize: 10,
                          color: AuraColors.textPrimary.withOpacity(0.5),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            Container(
              height: 1,
              color: AuraColors.textPrimary.withOpacity(0.06),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _InfoPill(
                    icon: Icons.payments_outlined, label: campaign.budget),
                _InfoPill(
                    icon: Icons.calendar_today_outlined,
                    label: 'By ${campaign.deadline}'),
                _InfoPill(
                    icon: Icons.people_outline,
                    label: '${campaign.minFollowers}+ followers'),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuraColors.sage,
                  foregroundColor: AuraColors.midnight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.campaignApply),
                child: const Text(
                  'APPLY NOW',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 12, color: AuraColors.textPrimary.withOpacity(0.4)),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AuraColors.textPrimary.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}



// ──────────────────────── Bottom Navigation ────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            active: false,
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          _NavItem(
            icon: Icons.explore,
            label: 'Discover',
            active: true,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.handshake_outlined,
            label: 'Collabs',
            active: false,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.creatorCollaborations),
          ),
          _NavItem(
            icon: Icons.account_circle,
            label: 'Profile',
            active: false,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.profileBento),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color =
        active ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.4);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 9, letterSpacing: 2, color: color),
          ),
        ],
      ),
    );
  }
}
