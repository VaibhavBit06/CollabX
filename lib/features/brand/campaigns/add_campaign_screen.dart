import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});

  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _collegesController = TextEditingController();
  final TextEditingController _citiesController = TextEditingController();
  
  String _selectedNiche = 'Fashion';
  final List<String> _niches = ['Fashion', 'Tech', 'Travel', 'Food', 'Lifestyle', 'Gaming'];
  bool _isCampusCampaign = false;
  bool _targetAllColleges = true;
  bool _targetAllCities = true;

  @override
  void dispose() {
    _titleController.dispose();
    _budgetController.dispose();
    _requirementsController.dispose();
    _collegesController.dispose();
    _citiesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Logic to save campaign (mock)
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Campaign Published!')),
      );
    }
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
          icon: Icon(Icons.close, color: AuraColors.chrome),
        ),
        title: Text(
          'CREATE CAMPAIGN',
          style: TextStyle(fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.w300, color: AuraColors.chrome),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _Label('CAMPAIGN TITLE'),
              const SizedBox(height: 8),
              _TextField(controller: _titleController, hint: 'e.g. Summer Collection 2026'),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Label('BUDGET'),
                        const SizedBox(height: 8),
                        _TextField(controller: _budgetController, hint: '₹15,000', keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Label('NICHE'),
                        const SizedBox(height: 8),
                        _Dropdown(
                          value: _selectedNiche,
                          items: _niches,
                          onChanged: (val) => setState(() => _selectedNiche = val!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _Label('REQUIREMENTS & GUIDELINES'),
              const SizedBox(height: 8),
              _TextField(
                controller: _requirementsController,
                hint: 'Describe what you are looking for in a creator...',
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              _Label('TARGETING'),
              const SizedBox(height: 16),
              _buildTargetingSection(),
              const SizedBox(height: 48),
              _PrimaryButton(label: 'PUBLISH BRIEF', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTargetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Campaign?',
                  style: TextStyle(color: AuraColors.chrome, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  'Enable to target university students specifically',
                  style: TextStyle(color: AuraColors.chrome.withOpacity(0.5), fontSize: 11),
                ),
              ],
            ),
            Switch(
              value: _isCampusCampaign,
              onChanged: (val) => setState(() => _isCampusCampaign = val),
              activeColor: AuraColors.sage,
            ),
          ],
        ),
        if (_isCampusCampaign) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Label('SELECT COLLEGES / UNIVERSITIES'),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('All', style: TextStyle(color: AuraColors.chrome, fontSize: 12)),
                  Checkbox(
                    value: _targetAllColleges,
                    onChanged: (val) {
                      setState(() {
                        _targetAllColleges = val ?? true;
                        if (_targetAllColleges) _collegesController.clear();
                      });
                    },
                    activeColor: AuraColors.sage,
                    checkColor: AuraColors.midnight,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          _TextField(
            controller: _collegesController,
            hint: 'e.g. IIT Delhi, St. Stephens, Mumbai University',
            enabled: !_targetAllColleges,
            opacity: _targetAllColleges ? 0.3 : 1.0,
          ),
        ],
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Label('TARGET CITIES'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('All', style: TextStyle(color: AuraColors.chrome, fontSize: 12)),
                Checkbox(
                  value: _targetAllCities,
                  onChanged: (val) {
                    setState(() {
                      _targetAllCities = val ?? true;
                      if (_targetAllCities) _citiesController.clear();
                    });
                  },
                  activeColor: AuraColors.sage,
                  checkColor: AuraColors.midnight,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        _TextField(
          controller: _citiesController,
          hint: 'e.g. Mumbai, Delhi, Bangalore',
          enabled: !_targetAllCities,
          opacity: _targetAllCities ? 0.3 : 1.0,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brief Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: AuraColors.chrome),
        ),
        const SizedBox(height: 8),
        Text(
          'Craft a compelling brief to attract the best creators.',
          style: TextStyle(fontSize: 13, color: AuraColors.chrome.withOpacity(0.5), fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
        color: AuraColors.chrome.withOpacity(0.4),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.enabled = true,
    this.opacity = 1.0,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool enabled;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        enabled: enabled,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AuraColors.chrome),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AuraColors.chrome.withOpacity(0.3), fontWeight: FontWeight.w200),
        filled: true,
        fillColor: AuraColors.obsidian,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AuraColors.sage),
        ),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    ));
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({required this.value, required this.items, required this.onChanged});
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AuraColors.obsidian,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AuraColors.obsidian,
          icon: const Icon(Icons.expand_more, color: AuraColors.sage),
          style: TextStyle(color: AuraColors.chrome, fontSize: 14, fontWeight: FontWeight.w300),
          onChanged: onChanged,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuraColors.sage,
          foregroundColor: AuraColors.midnight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
