/// A training resource (PDF, slide deck, etc.) uploaded by a mentor.
class TrainingFile {
  final String id;
  final String title;
  final String fileUrl;
  final String uploadedBy;
  final DateTime createdAt;

  const TrainingFile({
    required this.id,
    required this.title,
    required this.fileUrl,
    required this.uploadedBy,
    required this.createdAt,
  });

  factory TrainingFile.fromJson(Map<String, dynamic> json) {
    return TrainingFile(
      id: json['id'].toString(),
      title: (json['title'] ?? '') as String,
      fileUrl: (json['file_url'] ?? '') as String,
      uploadedBy: json['uploaded_by'].toString(),
      createdAt: DateTime.tryParse('${json['created_at']}') ?? DateTime.now(),
    );
  }
}
