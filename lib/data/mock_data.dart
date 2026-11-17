import '../models/course.dart';
import '../models/user.dart';
import '../models/certificate.dart';

class MockData {
  static final AppUser currentUser = AppUser(
    name: 'Alex Johnson',
    email: 'alex@learn_era.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    coursesEnrolled: 4,
    certificates: 2,
  );

  static const List<String> categories = [
    'All',
    'Design',
    'Development',
    'Business',
    'Marketing',
    'Data Science',
  ];

  static final List<Course> courses = [
    Course(
      id: 'c1',
      title: 'Flutter Bootcamp: From Zero to Hero',
      instructor: 'Angela Yu',
      description:
      'Master Flutter and Dart by building real-world mobile apps.',
      imageUrl:
      'https://images.unsplash.com/photo-1607252650355-f7fd0460ccdb?w=800',
      category: 'Development',
      rating: 4.8,
      students: 12450,
      price: 49.99,
      progress: 0.45,
      lessons: [
        Lesson(
            title: 'Introduction to Flutter',
            duration: '12 min',
            isCompleted: true),
        Lesson(
            title: 'Dart Basics', duration: '25 min', isCompleted: true),
        Lesson(
            title: 'Building Widgets', duration: '30 min', isCompleted: true),
        Lesson(title: 'State Management', duration: '45 min'),
        Lesson(title: 'REST API Integration', duration: '40 min'),
        Lesson(title: 'Deploying Your App', duration: '20 min'),
      ],
    ),
    Course(
      id: 'c2',
      title: 'UI/UX Design Masterclass',
      instructor: 'Sarah Chen',
      description: 'Learn the principles of design thinking and prototyping.',
      imageUrl:
      'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800',
      category: 'Design',
      rating: 4.7,
      students: 8320,
      price: 39.99,
      progress: 0.20,
      lessons: [
        Lesson(
            title: 'Design Thinking',
            duration: '20 min',
            isCompleted: true),
        Lesson(title: 'Wireframing', duration: '25 min'),
        Lesson(title: 'Prototyping in Figma', duration: '35 min'),
      ],
    ),
    Course(
      id: 'c3',
      title: 'Python for Data Science',
      instructor: 'Jose Portilla',
      description:
      'Analyze data, create visualizations, and build ML models.',
      imageUrl:
      'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=800',
      category: 'Data Science',
      rating: 4.9,
      students: 21000,
      price: 59.99,
      progress: 0.75,
      lessons: [
        Lesson(
            title: 'Python Refresher',
            duration: '15 min',
            isCompleted: true),
        Lesson(
            title: 'NumPy & Pandas',
            duration: '40 min',
            isCompleted: true),
        Lesson(title: 'Data Visualization', duration: '30 min'),
        Lesson(title: 'Intro to ML', duration: '50 min'),
      ],
    ),
    Course(
      id: 'c4',
      title: 'Digital Marketing Strategy',
      instructor: 'Neil Patel',
      description:
      'Grow any business with a proven marketing framework.',
      imageUrl:
      'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800',
      category: 'Marketing',
      rating: 4.6,
      students: 5320,
      price: 29.99,
      lessons: [
        Lesson(title: 'Marketing Fundamentals', duration: '18 min'),
        Lesson(title: 'SEO Deep Dive', duration: '35 min'),
      ],
    ),
    Course(
      id: 'c5',
      title: 'Business Analytics with Excel',
      instructor: 'Chris Dutton',
      description: 'Become a data-driven decision maker using Excel.',
      imageUrl:
      'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800',
      category: 'Business',
      rating: 4.5,
      students: 4100,
      price: 34.99,
      lessons: [
        Lesson(title: 'Excel Basics', duration: '20 min'),
        Lesson(title: 'PivotTables', duration: '25 min'),
      ],
    ),
  ];

  static List<Course> get enrolledCourses =>
      courses.where((c) => c.progress > 0).toList();

  static List<Course> get completedCourses =>
      courses.where((c) => c.progress >= 1.0).toList();

  static List<Certificate> certificates = [
    Certificate(
      id: 'cert1',
      courseId: 'c3',
      courseTitle: 'Python for Data Science',
      instructor: 'Jose Portilla',
      studentName: 'Alex Johnson',
      issuedDate: DateTime(2025, 9, 14),
      certificateNumber: 'LE-2025-PY-00148',
      grade: 92.5,
    ),
    Certificate(
      id: 'cert2',
      courseId: 'c2',
      courseTitle: 'UI/UX Design Masterclass',
      instructor: 'Sarah Chen',
      studentName: 'Alex Johnson',
      issuedDate: DateTime(2025, 6, 3),
      certificateNumber: 'LE-2025-UX-00921',
      grade: 88.0,
    ),
  ];

  static Certificate? certificateForCourse(String courseId) {
    try {
      return certificates.firstWhere((c) => c.courseId == courseId);
    } catch (_) {
      return null;
    }
  }
}