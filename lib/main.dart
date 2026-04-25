import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'models/user.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/intern/intern_dashboard.dart';
import 'screens/mentor/evaluation_form_screen.dart';
import 'screens/mentor/mentor_dashboard.dart';
import 'screens/role_selector_screen.dart';

void main() {
  runApp(const ProLinkApp());
}

class ProLinkApp extends StatelessWidget {
  const ProLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const RoleSelectorScreen(),
        AppRoutes.admin: (context) => const AdminDashboard(),
        AppRoutes.mentor: (context) => const MentorDashboard(),
        AppRoutes.intern: (context) => const InternDashboard(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.evaluation) {
          final User intern = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => EvaluationFormScreen(intern: intern),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
