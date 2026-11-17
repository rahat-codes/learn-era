class AppUser {
  final String name;
  final String email;
  final String avatarUrl;
  final int coursesEnrolled;
  final int certificates;

  AppUser({
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.coursesEnrolled = 0,
    this.certificates = 0,
  });
}