import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'models/user.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/pending_approval_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/intern/intern_dashboard.dart';
import 'screens/mentor/evaluation_form_screen.dart';
import 'screens/mentor/mentor_dashboard.dart';

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
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.admin:
            final User? user = settings.arguments as User?;
            return MaterialPageRoute(
              builder: (_) => AdminDashboard(currentUser: user),
              settings: settings,
            );
          case AppRoutes.mentor:
            final User? user = settings.arguments as User?;
            return MaterialPageRoute(
              builder: (_) => MentorDashboard(currentUser: user),
              settings: settings,
            );
          case AppRoutes.intern:
            final User? user = settings.arguments as User?;
            return MaterialPageRoute(
              builder: (_) => InternDashboard(currentUser: user),
              settings: settings,
            );
          case AppRoutes.pending:
            final User user = settings.arguments as User;
            return MaterialPageRoute(
              builder: (_) => PendingApprovalScreen(user: user),
              settings: settings,
            );
          case AppRoutes.evaluation:
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
