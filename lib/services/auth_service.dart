import '../data/mock_data.dart';
import '../models/user.dart';

/// Result of a login or registration attempt.
sealed class AuthResult {
  const AuthResult();
}

class AuthSuccess extends AuthResult {
  final User user;
  const AuthSuccess(this.user);
}

class AuthFailure extends AuthResult {
  final String message;
  const AuthFailure(this.message);
}

/// Mock authentication used by Spiral 1.
///
/// Spiral 3 replaces this class with `ApiService.login` / `ApiService.register`
/// hitting the PHP REST API. The public API of this class is intentionally
/// shaped like the future HTTP-backed version:
///   * `Future<AuthResult>` for both calls
///   * a small artificial delay so loading spinners render
///   * `AuthFailure` for any non-success path (wrong credentials, duplicate
///     email, etc.)
class AuthService {
  AuthService._();

  static const Duration _fakeLatency = Duration(milliseconds: 500);

  static List<User> get _allUsers => [
        ...MockData.seedAdmins,
        ...MockData.seedMentors,
        ...MockData.assignedInterns,
        ...MockData.pendingInterns,
      ];

  /// Authenticate against the seeded mock user list.
  static Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_fakeLatency);

    final String normalized = email.trim().toLowerCase();
    final String? expected = MockData.seedPasswords[normalized];
    if (expected == null || expected != password) {
      return const AuthFailure('Invalid email or password');
    }

    User? match;
    for (final User u in _allUsers) {
      if (u.email.toLowerCase() == normalized) {
        match = u;
        break;
      }
    }
    if (match == null) {
      return const AuthFailure('Account not found');
    }
    return AuthSuccess(match);
  }

  /// Register a new intern. The new user lands in the pending list and must
  /// wait for an admin to approve them.
  static Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    required String department,
    String photoUrl = '',
  }) async {
    await Future<void>.delayed(_fakeLatency);

    final String normalized = email.trim().toLowerCase();
    if (normalized.isEmpty) {
      return const AuthFailure('Email is required');
    }
    if (MockData.seedPasswords.containsKey(normalized)) {
      return const AuthFailure('An account with this email already exists');
    }

    final String newId = '9${DateTime.now().millisecondsSinceEpoch % 100000}';
    final User user = User(
      id: newId,
      email: normalized,
      name: name.trim(),
      role: 'intern',
      photoUrl: photoUrl,
      department: department,
      approved: false,
    );

    MockData.pendingInterns.add(user);
    MockData.seedPasswords[normalized] = password;
    return AuthSuccess(user);
  }
}
