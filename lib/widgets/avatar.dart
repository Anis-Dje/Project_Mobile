import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Circular avatar that falls back to the user's initials when no photo URL
/// is available. Uses `Image.network` once a real URL is provided.
class Avatar extends StatelessWidget {
  final String name;
  final String photoUrl;
  final double radius;

  const Avatar({
    super.key,
    required this.name,
    required this.photoUrl,
    this.radius = 22,
  });

  String get _initials {
    final List<String> parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (photoUrl.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(photoUrl),
        backgroundColor: AppColors.primaryLight,
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primaryLight,
      child: Text(
        _initials,
        style: TextStyle(
          color: AppColors.textOnPrimary,
          fontSize: radius * 0.75,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
