import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../models/course.dart';
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
  late Future<List<Course>> _coursesFuture;
  List<Course> _allCourses = [];
  static const _categories = [
    'All', 'Design', 'Development', 'Business', 'Marketing', 'Data Science',
  ];

  @override
  void initState() {
    super.initState();
    _coursesFuture = _fetchCourses();
  }

  Future<List<Course>> _fetchCourses() async {
    final data = await supabase.from('courses').select();
    final courses = (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
    _allCourses = courses;
    return courses;
  }

  List<Course> get _filtered {
    if (_selectedCategory == 0) return _allCourses;
    final cat = _categories[_selectedCategory];
    return _allCourses.where((c) => c.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final enrolled = _allCourses.where((c) => c.progress > 0).toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello 👋',
                                style: TextStyle(
                                    color: AppColors.textGrey, fontSize: 13)),
                            Text('Learner',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.person),
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
                    itemCount: _categories.length,
                    itemBuilder: (_, i) => CategoryChip(
                      label: _categories[i],
                      selected: _selectedCategory == i,
                      onTap: () => setState(() => _selectedCategory = i),
                    ),
                  ),
                ),
              ),
              if (enrolled.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: SectionHeader(title: 'Continue Learning'),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 285,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: enrolled.length,
                      itemBuilder: (_, i) {
                        final c = enrolled[i];
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
              ],
              const SliverToBoxAdapter(
                child: SectionHeader(title: 'Popular Courses'),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.builder(
                  itemCount: _filtered.length,
                  itemBuilder: (_, i) {
                    final c = _filtered[i];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailScreen(course: c),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(10),
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
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => Container(
                                    width: 90,
                                    height: 90,
                                    color: Colors.grey.shade300),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.category.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary)),
                                  const SizedBox(height: 4),
                                  Text(c.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3)),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded,
                                          size: 14, color: Colors.amber),
                                      const SizedBox(width: 2),
                                      Text('${c.rating}',
                                          style: const TextStyle(fontSize: 12)),
                                      const Spacer(),
                                      Text(
                                        '\$${c.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primary),
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
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
      ),
    );
  }
}