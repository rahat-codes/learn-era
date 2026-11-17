class Lesson {
  final String title;
  final String duration;
  final bool isCompleted;

  Lesson({
    required this.title,
    required this.duration,
    this.isCompleted = false,
  });
}

class Course {
  final String id;
  final String title;
  final String instructor;
  final String description;
  final String imageUrl;
  final String category;
  final double rating;
  final int students;
  final double price;
  final double progress;
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.students,
    required this.price,
    this.progress = 0.0,
    this.lessons = const [],
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      instructor: json['instructor'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      students: (json['students'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
    );
  }
}