import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_colors.dart';

/// Temporary landing screen used during Spiral 1.
///
/// The unified login page is part of the same Sprint 1 deliverable but is
/// being built in a follow-up step. This screen lets us preview the three
/// role dashboards in the meantime.
class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.business_center_outlined,
                        color: AppColors.primary,
                        size: 38,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.appName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: AppColors.textOnPrimary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppStrings.appTagline,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.university,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textOnPrimary.withValues(alpha: 0.65),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 36),
                  _RoleButton(
                    label: AppStrings.roleAdminLabel,
                    icon: Icons.admin_panel_settings_outlined,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.admin),
                  ),
                  const SizedBox(height: 12),
                  _RoleButton(
                    label: AppStrings.roleMentorLabel,
                    icon: Icons.school_outlined,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.mentor),
                  ),
                  const SizedBox(height: 12),
                  _RoleButton(
                    label: AppStrings.roleInternLabel,
                    icon: Icons.badge_outlined,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.intern),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Spiral 1 preview — login page coming next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textOnPrimary.withValues(alpha: 0.55),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Continue as $label',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.primary),
        ],
      ),
    );
  }
}
