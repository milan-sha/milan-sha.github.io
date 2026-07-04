import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Flutter', '.NET', 'Cybersecurity', 'AI'];

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Secure Bank App',
      'category': 'Flutter',
      'description': 'A highly secure banking application with end-to-end encryption, biometric authentication, and real-time transaction monitoring.',
      'techStack': ['Flutter', 'Dart', 'Firebase', 'Encryption'],
      'image': 'https://images.unsplash.com/photo-1563986768609-322da13575f3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
      'github': 'https://github.com',
      'live': 'https://example.com',
    },
    {
      'title': 'Enterprise ERP System',
      'category': '.NET',
      'description': 'A comprehensive enterprise resource planning system built with ASP.NET Core, featuring a modular architecture and role-based access control.',
      'techStack': ['ASP.NET Core', 'C#', 'SQL Server', 'Entity Framework'],
      'image': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
      'github': 'https://github.com',
      'live': 'https://example.com',
    },
    {
      'title': 'Vulnerability Scanner',
      'category': 'Cybersecurity',
      'description': 'An automated network vulnerability scanner that identifies open ports, outdated software, and potential security risks based on OWASP guidelines.',
      'techStack': ['Python', 'Nmap API', 'Socket', 'Regex'],
      'image': 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
      'github': 'https://github.com',
      'live': null,
    },
    {
      'title': 'AI Sales Predictor',
      'category': 'AI',
      'description': 'A machine learning model that predicts future sales trends based on historical data, seasonal factors, and marketing spend.',
      'techStack': ['Python', 'Pandas', 'Scikit-Learn', 'Matplotlib'],
      'image': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
      'github': 'https://github.com',
      'live': 'https://example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProjects = _selectedCategory == 'All'
        ? _projects
        : _projects.where((p) => p['category'] == _selectedCategory).toList();

    return VisibilityDetector(
      key: const Key('projects-section'),
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
                const SizedBox(height: 40),
                if (_isVisible) ...[
                  _buildFilterTabs(isMobile),
                  const SizedBox(height: 60),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProjects.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 80),
                    itemBuilder: (context, index) {
                      return _buildProjectCard(filteredProjects[index], index, isMobile)
                          .animate(key: ValueKey('${_selectedCategory}_$index'))
                          .fade(duration: 600.ms, delay: (200 * index).ms)
                          .slideY(begin: 0.1, end: 0);
                    },
                  ),
                ],
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
          'Featured Projects',
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

  Widget _buildFilterTabs(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          bool isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              borderRadius: BorderRadius.circular(30),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ).animate().fade(delay: 300.ms),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, int index, bool isMobile) {
    bool isEven = index % 2 == 0;
    
    if (isMobile) {
      return _buildMobileProjectCard(project);
    }
    
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          // Image
          Positioned(
            left: isEven ? 0 : null,
            right: isEven ? null : 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: AppColors.surface,
                child: Image.network(
                  project['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.image, size: 50, color: AppColors.surfaceLight),
                  ),
                ),
              ),
            ),
          ),
          
          // Content Card
          Positioned(
            left: isEven ? null : 0,
            right: isEven ? 0 : null,
            top: 40,
            bottom: 40,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: _buildProjectContent(project, CrossAxisAlignment.start),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMobileProjectCard(Map<String, dynamic> project) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.network(
              project['image'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.image, size: 50, color: AppColors.surfaceLight),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: _buildProjectContent(project, CrossAxisAlignment.start),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProjectContent(Map<String, dynamic> project, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          project['category'],
          style: const TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project['title'],
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          project['description'],
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: AppColors.textSecondary,
          ),
          textAlign: alignment == CrossAxisAlignment.end ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: alignment == CrossAxisAlignment.end ? WrapAlignment.end : WrapAlignment.start,
          children: (project['techStack'] as List<String>).map((tech) {
            return Text(
              tech,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            );
          }).toList(),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: alignment == CrossAxisAlignment.end ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (project['github'] != null)
              IconButton(
                onPressed: () => launchUrl(Uri.parse(project['github'])),
                icon: const Icon(Icons.code, color: Colors.white),
                tooltip: 'View Source Code',
              ),
            if (project['live'] != null) ...[
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => launchUrl(Uri.parse(project['live'])),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('Live Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
