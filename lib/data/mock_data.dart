import '../models/evaluation.dart';
import '../models/schedule.dart';
import '../models/training_file.dart';
import '../models/user.dart';

/// In-memory mock data used by Spiral 1 (UI-only). Replaced by the REST API
/// layer in Spiral 3.
class MockData {
  MockData._();

  /// Department options offered on the registration form.
  static const List<String> departments = [
    'Software Engineering',
    'Mobile Development',
    'Data Science',
    'Cybersecurity',
    'Cloud Infrastructure',
    'Quality Assurance',
  ];

  /// Seed admin accounts. Spiral 3 will replace this with a `users` row in Neon.
  static final List<User> seedAdmins = [
    const User(
      id: '1',
      email: 'admin@prolink.dz',
      name: 'HR Coordinator',
      role: 'admin',
      photoUrl: '',
      department: 'Human Resources',
      approved: true,
    ),
  ];

  /// Seed mentor accounts.
  static final List<User> seedMentors = [
    const User(
      id: '301',
      email: 'mentor@prolink.dz',
      name: 'Mounir Saidi',
      role: 'mentor',
      photoUrl: '',
      department: 'Software Engineering',
      approved: true,
    ),
  ];

  /// Mock password store. Maps lower-cased email to plaintext password
  /// (Spiral 1 only — Spiral 3 hashes server-side).
  static final Map<String, String> seedPasswords = {
    'admin@prolink.dz': 'admin123',
    'mentor@prolink.dz': 'mentor123',
    'sara.benali@univ-constantine2.dz': 'sara123',
    'omar.tazi@univ-constantine2.dz': 'omar123',
    'rania.bouzid@univ-constantine2.dz': 'rania123',
    'yacine.haddadi@univ-constantine2.dz': 'yacine123',
  };

  /// Mutable in-memory list of interns awaiting admin validation. The admin
  /// dashboard removes from this list when it approves/rejects.
  static final List<User> pendingInterns = [
    const User(
      id: '201',
      email: 'amine.kacem@univ-constantine2.dz',
      name: 'Amine Kacem',
      role: 'intern',
      photoUrl: '',
      department: 'Cybersecurity',
      approved: false,
    ),
    const User(
      id: '202',
      email: 'lina.medjadji@univ-constantine2.dz',
      name: 'Lina Medjadji',
      role: 'intern',
      photoUrl: '',
      department: 'Data Science',
      approved: false,
    ),
    const User(
      id: '203',
      email: 'yacine.haddadi@univ-constantine2.dz',
      name: 'Yacine Haddadi',
      role: 'intern',
      photoUrl: '',
      department: 'Mobile Development',
      approved: false,
    ),
  ];

  /// Mutable in-memory list of approved interns assigned to a mentor.
  static final List<User> assignedInterns = [
    const User(
      id: '101',
      email: 'sara.benali@univ-constantine2.dz',
      name: 'Sara Benali',
      role: 'intern',
      photoUrl: '',
      department: 'Software Engineering',
      approved: true,
    ),
    const User(
      id: '102',
      email: 'omar.tazi@univ-constantine2.dz',
      name: 'Omar Tazi',
      role: 'intern',
      photoUrl: '',
      department: 'Software Engineering',
      approved: true,
    ),
    const User(
      id: '103',
      email: 'rania.bouzid@univ-constantine2.dz',
      name: 'Rania Bouzid',
      role: 'intern',
      photoUrl: '',
      department: 'Software Engineering',
      approved: true,
    ),
  ];

  static List<Schedule> internSchedules() {
    final DateTime today = DateTime.now();
    return [
      Schedule(
        id: '1',
        userId: '101',
        shiftData: 'Morning shift — 08:30 to 12:30',
        date: today,
      ),
      Schedule(
        id: '2',
        userId: '101',
        shiftData: 'Afternoon shift — 13:30 to 17:00',
        date: today.add(const Duration(days: 1)),
      ),
      Schedule(
        id: '3',
        userId: '101',
        shiftData: 'Team review — 10:00 to 11:00',
        date: today.add(const Duration(days: 2)),
      ),
    ];
  }

  static List<TrainingFile> trainingFiles() {
    final DateTime now = DateTime.now();
    return [
      TrainingFile(
        id: '1',
        title: 'Onboarding Handbook 2025',
        fileUrl: '',
        uploadedBy: '301',
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      TrainingFile(
        id: '2',
        title: 'Flutter Mobile Standards',
        fileUrl: '',
        uploadedBy: '301',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      TrainingFile(
        id: '3',
        title: 'Internal Security Policy',
        fileUrl: '',
        uploadedBy: '301',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  static List<Evaluation> internEvaluations() {
    final DateTime now = DateTime.now();
    return [
      Evaluation(
        id: '1',
        internId: '101',
        mentorId: '301',
        score: 17,
        feedback: 'Excellent autonomy on the mobile module sprint.',
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      Evaluation(
        id: '2',
        internId: '101',
        mentorId: '301',
        score: 18,
        feedback: 'Great collaboration during code review sessions.',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    ];
  }
}
