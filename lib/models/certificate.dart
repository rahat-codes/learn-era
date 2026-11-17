class Certificate {
  final String id;
  final String courseId;
  final String courseTitle;
  final String instructor;
  final String studentName;
  final DateTime issuedDate;
  final String certificateNumber;
  final double grade; // 0-100

  Certificate({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.instructor,
    required this.studentName,
    required this.issuedDate,
    required this.certificateNumber,
    required this.grade,
  });
}