import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../models/user.dart';
import '../../widgets/avatar.dart';
import '../../widgets/empty_placeholder.dart';
import '../../widgets/section_header.dart';

/// Administrator landing dashboard.
///
/// Spiral 1 scope: pending-intern approval list, mentor assignment overview,
/// and a placeholder for office-schedule uploads. All data is mocked.
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late List<User> _pending;

  @override
  void initState() {
    super.initState();
    _pending = List<User>.from(MockData.pendingInterns);
  }

  void _approve(User user) {
    setState(() => _pending.removeWhere((u) => u.id == user.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${user.name} approved (mock)')),
    );
  }

  void _reject(User user) {
    setState(() => _pending.removeWhere((u) => u.id == user.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${user.name} rejected (mock)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrator Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SummaryRow(pending: _pending.length),
            const SectionHeader(
              title: 'Pending intern approvals',
              icon: Icons.pending_actions_outlined,
            ),
            Card(
              child: _pending.isEmpty
                  ? const EmptyPlaceholder(
                      message: 'No interns awaiting validation.',
                      icon: Icons.check_circle_outline,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pending.length,
                      itemBuilder: (context, index) {
                        final User intern = _pending[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Avatar(
                                name: intern.name,
                                photoUrl: intern.photoUrl,
                              ),
                              title: Text(intern.name),
                              subtitle: Text(
                                '${intern.department} • ${intern.email}',
                              ),
                              isThreeLine: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _approve(intern),
                                      icon: const Icon(Icons.check, size: 18),
                                      label: const Text(AppStrings.approve),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => _reject(intern),
                                      icon: const Icon(Icons.close, size: 18),
                                      label: const Text(AppStrings.reject),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != _pending.length - 1) const Divider(),
                          ],
                        );
                      },
                    ),
            ),
            const SectionHeader(
              title: 'Mentor assignments',
              icon: Icons.group_outlined,
            ),
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MockData.assignedInterns.length,
                itemBuilder: (context, index) {
                  final User intern = MockData.assignedInterns[index];
                  return ListTile(
                    leading: Avatar(
                      name: intern.name,
                      photoUrl: intern.photoUrl,
                    ),
                    title: Text(intern.name),
                    subtitle: Text(intern.department),
                    trailing: const Text('Mentor: M. Saidi'),
                  );
                },
              ),
            ),
            const SectionHeader(
              title: 'Office schedules & policies',
              icon: Icons.upload_file_outlined,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Upload office timetables and policy handbooks for all '
                      'departments. (Spiral 2)',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.cloud_upload_outlined),
                      label: const Text('Upload document'),
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
}

class _SummaryRow extends StatelessWidget {
  final int pending;

  const _SummaryRow({required this.pending});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Pending interns',
            value: '$pending',
            icon: Icons.pending_actions_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Active interns',
            value: '${MockData.assignedInterns.length}',
            icon: Icons.badge_outlined,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: _StatCard(
            label: 'Mentors',
            value: '4',
            icon: Icons.school_outlined,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
