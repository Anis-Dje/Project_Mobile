import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../models/evaluation.dart';
import '../../models/schedule.dart';
import '../../models/training_file.dart';
import '../../models/user.dart';
import '../../widgets/empty_placeholder.dart';
import '../../widgets/section_header.dart';
import 'widgets/work_id_card.dart';

/// Intern landing dashboard.
class InternDashboard extends StatelessWidget {
  final User? currentUser;

  const InternDashboard({super.key, this.currentUser});

  static const User _fallbackIntern = User(
    id: '101',
    email: 'sara.benali@univ-constantine2.dz',
    name: 'Sara Benali',
    role: 'intern',
    photoUrl: '',
    department: 'Software Engineering',
    approved: true,
  );

  @override
  Widget build(BuildContext context) {
    final List<Schedule> schedules = MockData.internSchedules();
    final List<TrainingFile> files = MockData.trainingFiles();
    final List<Evaluation> evaluations = MockData.internEvaluations();
    final User intern = currentUser ?? _fallbackIntern;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Intern Dashboard'),
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
            WorkIdCard(user: intern),
            const SectionHeader(
              title: 'My schedule',
              icon: Icons.calendar_today_outlined,
            ),
            Card(
              child: schedules.isEmpty
                  ? const EmptyPlaceholder(
                      message: 'No upcoming shifts assigned.',
                      icon: Icons.event_busy_outlined,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final Schedule s = schedules[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.schedule_outlined,
                            color: AppColors.primary,
                          ),
                          title: Text(s.shiftData),
                          subtitle: Text(_formatDate(s.date)),
                        );
                      },
                    ),
            ),
            const SectionHeader(
              title: 'Training files',
              icon: Icons.folder_open_outlined,
            ),
            Card(
              child: files.isEmpty
                  ? const EmptyPlaceholder(
                      message: 'No training resources yet.',
                      icon: Icons.folder_off_outlined,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final TrainingFile f = files[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.picture_as_pdf_outlined,
                            color: AppColors.primary,
                          ),
                          title: Text(f.title),
                          subtitle: Text(_formatDate(f.createdAt)),
                          trailing: const Icon(Icons.download_outlined),
                        );
                      },
                    ),
            ),
            const SectionHeader(
              title: 'Skill evaluations',
              icon: Icons.workspace_premium_outlined,
            ),
            Card(
              child: evaluations.isEmpty
                  ? const EmptyPlaceholder(
                      message: 'No evaluations posted yet.',
                      icon: Icons.assignment_outlined,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: evaluations.length,
                      itemBuilder: (context, index) {
                        final Evaluation e = evaluations[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.textOnPrimary,
                            child: Text(
                              '${e.score}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          title: Text(e.feedback),
                          subtitle: Text(_formatDate(e.createdAt)),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final String day = date.day.toString().padLeft(2, '0');
    return '$day ${months[date.month - 1]} ${date.year}';
  }
}
