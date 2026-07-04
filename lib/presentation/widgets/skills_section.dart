import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/theme/app_colors.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> _skillCategories = [
    {
      'title': 'Mobile Development',
      'icon': Icons.phone_android,
      'skills': ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Responsive UI', 'State Management'],
      'color': AppColors.primary,
    },
    {
      'title': 'Backend Development',
      'icon': Icons.dns,
      'skills': ['ASP.NET', 'ASP.NET Core', 'C#', 'Entity Framework', 'REST API', 'Auth'],
      'color': AppColors.secondary,
    },
    {
      'title': 'Database',
      'icon': Icons.storage,
      'skills': ['SQL Server', 'MySQL', 'SQLite', 'Database Design', 'DBMS', 'Optimization'],
      'color': Colors.green,
    },
    {
      'title': 'Cybersecurity',
      'icon': Icons.security,
      'skills': ['CEH', 'Ethical Hacking', 'Vulnerability Assessment', 'Pen Testing', 'Network Security', 'OWASP'],
      'color': Colors.redAccent,
    },
    {
      'title': 'Artificial Intelligence',
      'icon': Icons.psychology,
      'skills': ['Python', 'Machine Learning', 'AI Fundamentals', 'NumPy', 'Pandas', 'Scikit-learn'],
      'color': AppColors.accent,
    },
    {
      'title': 'Tools',
      'icon': Icons.build,
      'skills': ['Git', 'GitHub', 'VS Code', 'Visual Studio', 'Android Studio', 'Figma', 'Postman'],
      'color': Colors.orangeAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          bool isMobile = sizingInformation.isMobile;
          
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 100,
              vertical: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(isMobile),
                const SizedBox(height: 60),
                if (_isVisible)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : (sizingInformation.isTablet ? 2 : 3),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: isMobile ? 1.5 : 1.2,
                    ),
                    itemCount: _skillCategories.length,
                    itemBuilder: (context, index) {
                      return _buildSkillCard(_skillCategories[index], index)
                          .animate()
                          .fade(delay: (100 * index).ms)
                          .slideY(begin: 0.2, end: 0);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(bool isMobile) {
    if (!_isVisible) return const SizedBox(height: 50);
    
    return Row(
      children: [
        Text(
          'Skills & Expertise',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.surfaceLight,
          ),
        ),
      ].animate().fade(duration: 600.ms).slideX(begin: -0.2, end: 0),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> category, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  color: category['color'],
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  category['title'],
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (category['skills'] as List<String>).map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
