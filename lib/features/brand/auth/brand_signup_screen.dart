import 'package:flutter/material.dart';
import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/services/auth_service.dart';
import 'package:aura_influencer_portfolio/shared/utils/constants.dart';

class BrandSignupScreen extends StatefulWidget {
  const BrandSignupScreen({super.key});

  @override
  State<BrandSignupScreen> createState() => _BrandSignupScreenState();
}

class _BrandSignupScreenState extends State<BrandSignupScreen> {
  int _currentStep = 0;
  bool _loading = false;

  // Step 1 Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Step 2 Controllers
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _gstinController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Step 3 Selection
  String? _selectedCategory;
  final List<String> _categories = [
    'Fashion & Apparel',
    'Beauty & Personal Care',
    'Tech & Gadgets',
    'Health & Wellness',
    'Food & Beverage',
    'Travel & Hospitality',
    'Luxury & Lifestyle',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _brandNameController.dispose();
    _websiteController.dispose();
    _gstinController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _completeSignup();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _completeSignup() async {
    if (_selectedCategory == null) return;
    
    setState(() => _loading = true);
    
    try {
      await AuthService.instance.signUp(
        email: _emailController.text, 
        password: _passwordController.text,
        defaultRole: UserRole.brand,
      );
      
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.brandDashboard,
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Brand registration failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
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
          onPressed: _prevStep,
          icon: Icon(Icons.arrow_back_ios, color: AuraColors.chrome),
        ),
        title: _StepIndicator(currentStep: _currentStep),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildCurrentStep(),
              const SizedBox(height: 40),
              _PrimaryButton(
                label: _currentStep == 2 ? 'COMPLETE SETUP' : 'CONTINUE',
                loading: _loading,
                onPressed: _nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String title = "";
    String subtitle = "";
    
    switch (_currentStep) {
      case 0:
        title = "Brand Account";
        subtitle = "Start your journey as a CollabX Brand.";
        break;
      case 1:
        title = "Business Details";
        subtitle = "Help us verify your brand identity.";
        break;
      case 2:
        title = "Brand Category";
        subtitle = "Select the primary industry for your brand.";
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w200,
            color: AuraColors.chrome,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: AuraColors.chrome.withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return Column(
          children: [
            _Label('FULL NAME'),
            const SizedBox(height: 8),
            _TextField(controller: _nameController, hint: 'John Doe'),
            const SizedBox(height: 24),
            _Label('OFFICIAL EMAIL'),
            const SizedBox(height: 8),
            _TextField(controller: _emailController, hint: 'brand@company.com', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            _Label('PASSWORD'),
            const SizedBox(height: 8),
            _TextField(controller: _passwordController, hint: '••••••••', obscureText: true),
          ],
        );
      case 1:
        return Column(
          children: [
            _Label('BRAND NAME'),
            const SizedBox(height: 8),
            _TextField(controller: _brandNameController, hint: 'e.g. Aura Essence'),
            const SizedBox(height: 24),
            _Label('WEBSITE'),
            const SizedBox(height: 8),
            _TextField(controller: _websiteController, hint: 'www.aura.com'),
            const SizedBox(height: 24),
            _Label('GSTIN'),
            const SizedBox(height: 8),
            _TextField(controller: _gstinController, hint: '22AAAAA0000A1Z5'),
            const SizedBox(height: 24),
            _Label('LOCATION (HQ)'),
            const SizedBox(height: 8),
            _TextField(controller: _locationController, hint: 'Mumbai, India'),
          ],
        );
      case 2:
        return Column(
          children: _categories.map((cat) {
            final isSelected = _selectedCategory == cat;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => setState(() => _selectedCategory = cat),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? AuraColors.sage.withOpacity(0.1) : AuraColors.obsidian,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AuraColors.sage : AuraColors.textPrimary.withOpacity(0.08),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? AuraColors.sage : AuraColors.chrome,
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected) Icon(Icons.check_circle, color: AuraColors.sage, size: 20),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      default:
        return const SizedBox();
    }
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isActive = index <= currentStep;
        return Container(
          width: 24,
          height: 3,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? AuraColors.sage : AuraColors.chrome.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 2,
          fontWeight: FontWeight.w500,
          color: AuraColors.chrome.withOpacity(0.6),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AuraColors.chrome,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AuraColors.chrome.withOpacity(0.4),
          fontWeight: FontWeight.w200,
        ),
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
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuraColors.sage,
          foregroundColor: AuraColors.midnight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: loading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: AuraColors.midnight),
              )
            : Text(
                label,
                style: const TextStyle(fontSize: 12, letterSpacing: 2.5, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
