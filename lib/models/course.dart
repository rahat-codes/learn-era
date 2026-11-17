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
  final double progress; // 0.0 - 1.0
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
}