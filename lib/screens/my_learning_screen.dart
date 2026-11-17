import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import 'course_detail_screen.dart';

class MyLearningScreen extends StatelessWidget {
  const MyLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enrolled = MockData.enrolledCourses;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              'My Learning',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: enrolled.isEmpty
                ? const Center(child: Text('No courses yet'))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: enrolled.length,
              itemBuilder: (_, i) {
                final c = enrolled[i];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailScreen(course: c),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: c.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => Container(
                              width: 70,
                              height: 70,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: c.progress,
                                  minHeight: 6,
                                  backgroundColor:
                                  Colors.grey.shade200,
                                  valueColor:
                                  const AlwaysStoppedAnimation<
                                      Color>(AppColors.primary),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${(c.progress * 100).toStringAsFixed(0)}% complete',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}