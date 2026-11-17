import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/course_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/section_header.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  List get _filtered {
    if (_selectedCategory == 0) return MockData.courses;
    final cat = MockData.categories[_selectedCategory];
    return MockData.courses.where((c) => c.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello 👋',
                          style: TextStyle(
                              color: AppColors.textGrey, fontSize: 13),
                        ),
                        Text(
                          MockData.currentUser.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: CachedNetworkImageProvider(
                      MockData.currentUser.avatarUrl,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                readOnly: true,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: 'Search courses, skills...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'Categories'),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: MockData.categories.length,
                itemBuilder: (_, i) => CategoryChip(
                  label: MockData.categories[i],
                  selected: _selectedCategory == i,
                  onTap: () => setState(() => _selectedCategory = i),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'Continue Learning'),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 285,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: MockData.enrolledCourses.length,
                itemBuilder: (_, i) {
                  final c = MockData.enrolledCourses[i];
                  return CourseCard(
                    course: c,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailScreen(course: c),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'Popular Courses'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.builder(
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final c = _filtered[i];
                return _ListCourseTile(course: c);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _ListCourseTile extends StatelessWidget {
  final dynamic course;

  const _ListCourseTile({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CourseDetailScreen(course: course),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: course.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(width: 90, height: 90, color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text('${course.rating}',
                          style: const TextStyle(fontSize: 12)),
                      const Spacer(),
                      Text(
                        '\$${course.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}