/// Named-route constants used by `MaterialApp`.
class AppRoutes {
  AppRoutes._();

  static const String login = '/';
  static const String register = '/register';
  static const String pending = '/pending';
  static const String admin = '/admin';
  static const String mentor = '/mentor';
  static const String intern = '/intern';
  static const String evaluation = '/evaluation';

  /// Maps a role string from the backend to its dashboard route.
  static String dashboardForRole(String role) {
    switch (role) {
      case 'admin':
        return admin;
      case 'mentor':
        return mentor;
      case 'intern':
        return intern;
      default:
        return login;
    }
  }
}
