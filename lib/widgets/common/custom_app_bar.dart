import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

/// App-specific AppBar with consistent styling.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AuraColors.midnight,
      foregroundColor: AuraColors.chrome,
      title: title != null ? Text(title!) : null,
      actions: actions,
      leading: leading,
    );
  }
}
