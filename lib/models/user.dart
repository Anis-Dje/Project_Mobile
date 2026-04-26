/// Application user (Admin, Mentor, or Intern).
///
/// Backed by the `users` table in Neon Postgres (Spiral 3). For Spiral 1 the
/// model is constructed from in-memory mock data only.
class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String photoUrl;
  final String department;
  final bool approved;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.photoUrl,
    required this.department,
    required this.approved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      photoUrl: (json['photo_url'] ?? '') as String,
      department: (json['department'] ?? '') as String,
      approved: json['approved'] == true || json['approved'] == 't',
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? photoUrl,
    String? department,
    bool? approved,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      department: department ?? this.department,
      approved: approved ?? this.approved,
    );
  }
}
