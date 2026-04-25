import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Subtle empty-state row used inside list cards.
class EmptyPlaceholder extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyPlaceholder({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
