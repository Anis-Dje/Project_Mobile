/// Performance evaluation written by a mentor for an intern.
class Evaluation {
  final String id;
  final String internId;
  final String mentorId;
  final int score;
  final String feedback;
  final DateTime createdAt;

  const Evaluation({
    required this.id,
    required this.internId,
    required this.mentorId,
    required this.score,
    required this.feedback,
    required this.createdAt,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'].toString(),
      internId: json['intern_id'].toString(),
      mentorId: json['mentor_id'].toString(),
      score: json['score'] is int
          ? json['score'] as int
          : int.tryParse('${json['score']}') ?? 0,
      feedback: (json['feedback'] ?? '') as String,
      createdAt: DateTime.tryParse('${json['created_at']}') ?? DateTime.now(),
    );
  }
}
