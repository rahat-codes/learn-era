import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/course.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import 'payment_screen.dart';
import 'certificate_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  void _onCTA(BuildContext context) {
    final isComplete = course.progress >= 1.0;
    final isEnrolled = course.progress > 0;

    if (isComplete) {
      final cert = MockData.certificateForCourse(course.id);
      if (cert != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CertificateScreen(certificate: cert),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Certificate not issued yet')),
        );
      }
    } else if (isEnrolled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening lesson player...')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentScreen(course: course),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = course.progress >= 1.0;
    final isEnrolled = course.progress > 0;
    final ctaLabel = isComplete
        ? 'View Certificate'
        : isEnrolled
        ? 'Continue Learning'
        : 'Enroll Now';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: course.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(color: Colors.grey.shade400),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By ${course.instructor}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${course.rating}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.people_alt_outlined,
                          size: 18, color: AppColors.textGrey),
                      const SizedBox(width: 4),
                      Text(
                        '${course.students} students',
                        style: const TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  if (isEnrolled) ...[
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: course.progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${(course.progress * 100).toStringAsFixed(0)}% complete',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  const Text(
                    'About this course',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.textDark,
                    ),
                  ),
                  if (course.lessons.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Curriculum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...course.lessons.map(
                          (l) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              l.isCompleted
                                  ? Icons.check_circle_rounded
                                  : Icons.play_circle_outline_rounded,
                              color: l.isCompleted
                                  ? Colors.green
                                  : AppColors.primary,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                l.title,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              l.duration,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => _onCTA(context),
            child: Text(ctaLabel),
          ),
        ),
      ),
    );
  }
}