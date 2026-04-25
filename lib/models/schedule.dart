/// A single shift/schedule entry assigned to a user.
class Schedule {
  final String id;
  final String userId;
  final String shiftData;
  final DateTime date;

  const Schedule({
    required this.id,
    required this.userId,
    required this.shiftData,
    required this.date,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      shiftData: (json['shift_data'] ?? '') as String,
      date: DateTime.tryParse('${json['date']}') ?? DateTime.now(),
    );
  }
}
