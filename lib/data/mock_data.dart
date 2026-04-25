import '../models/evaluation.dart';
import '../models/schedule.dart';
import '../models/training_file.dart';
import '../models/user.dart';

/// In-memory mock data used by Spiral 1 (UI-only). Replaced by the REST API
/// layer in Spiral 3.
class MockData {
  MockData._();

  static const User currentIntern = User(
    id: '101',
    email: 'sara.benali@univ-constantine2.dz',
    name: 'Sara Benali',
    role: 'intern',
    photoUrl: '',
    department: 'Software Engineering',
    approved: true,
  );

  static const List<User> pendingInterns = [
    User(
      id: '201',
      email: 'amine.kacem@univ-constantine2.dz',
      name: 'Amine Kacem',
      role: 'intern',
      photoUrl: '',
      department: 'Cybersecurity',
      approved: false,
    ),
    User(
      id: '202',
      email: 'lina.medjadji@univ-constantine2.dz',
      name: 'Lina Medjadji',
      role: 'intern',
      photoUrl: '',
      department: 'Data Science',
      approved: false,
    ),
    User(
      id: '203',
      email: 'yacine.haddadi@univ-constantine2.dz',
      name: 'Yacine Haddadi',
      role: 'intern',
      photoUrl: '',
      department: 'Mobile Development',
      approved: false,
    ),
  ];

  static const List<User> assignedInterns = [
    User(
      id: '101',
      email: 'sara.benali@univ-constantine2.dz',
      name: 'Sara Benali',
      role: 'intern',
      photoUrl: '',
      department: 'Software Engineering',
      approved: true,
    ),
    User(
      id: '102',
      email: 'omar.tazi@univ-constantine2.dz',
      name: 'Omar Tazi',
      role: 'intern',
      photoUrl: '',
      department: 'Software Engineering',
      approved: true,
    ),
    User(
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
