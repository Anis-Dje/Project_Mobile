import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../models/training_file.dart';
import '../../models/user.dart';
import '../../widgets/avatar.dart';
import '../../widgets/section_header.dart';

/// Mentor landing dashboard.
class MentorDashboard extends StatelessWidget {
  final User? currentUser;

  const MentorDashboard({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    final List<User> interns = MockData.assignedInterns;
    final List<TrainingFile> files = MockData.trainingFiles();
    final User mentor = currentUser ?? MockData.seedMentors.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login,
              (_) => false,
            ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MentorHeader(mentor: mentor),
            const SectionHeader(
              title: 'My interns',
              icon: Icons.groups_outlined,
            ),
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: interns.length,
                itemBuilder: (context, index) {
                  final User intern = interns[index];
                  return ListTile(
                    leading: Avatar(
                      name: intern.name,
                      photoUrl: intern.photoUrl,
                    ),
                    title: Text(intern.name),
                    subtitle: Text(intern.department),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.evaluation,
                      arguments: intern,
                    ),
                  );
                },
              ),
            ),
            SectionHeader(
              title: 'Training files',
              icon: Icons.folder_open_outlined,
              trailing: TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Upload available in Spiral 2 (Functions)'),
                    ),
                  );
                },
                icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                label: const Text('Upload'),
              ),
            ),
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final TrainingFile file = files[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.picture_as_pdf_outlined,
                      color: AppColors.primary,
                    ),
                    title: Text(file.title),
                    subtitle: Text(_relativeDate(file.createdAt)),
                    trailing: const Icon(Icons.download_outlined),
                  );
                },
              ),
            ),
            const SectionHeader(
              title: 'Weekly attendance',
              icon: Icons.fact_check_outlined,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Track presence for each assigned intern across the week.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        _AttendanceChip(label: 'Mon ✓'),
                        _AttendanceChip(label: 'Tue ✓'),
                        _AttendanceChip(label: 'Wed –'),
                        _AttendanceChip(label: 'Thu ✓'),
                        _AttendanceChip(label: 'Fri ✓'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _relativeDate(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inDays >= 1) return '${diff.inDays}d ago';
    if (diff.inHours >= 1) return '${diff.inHours}h ago';
    return 'just now';
  }
}

class _MentorHeader extends StatelessWidget {
  final User mentor;

  const _MentorHeader({required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Avatar(
              name: mentor.name,
              photoUrl: mentor.photoUrl,
              radius: 28,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${mentor.name}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.textOnPrimary),
                  ),
                  Text(
                    '${mentor.department} — Mentor',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceChip extends StatelessWidget {
  final String label;

  const _AttendanceChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: AppColors.surfaceAlt,
      side: BorderSide.none,
    );
  }
}
