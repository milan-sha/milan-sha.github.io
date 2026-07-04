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

  final List<String> _categories = ['All', 'Flutter', '.NET', 'Cybersecurity', 'Fun Projects'];

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Smile Dental App',
      'category': 'Flutter',
      'description': 'A comprehensive dental clinic application to manage staff and medical equipments.',
      'techStack': ['Flutter', 'Dart', 'Firebase'],
    },
    {
      'title': 'E-commerce App',
      'category': 'Flutter',
      'description': 'A full-featured e-commerce application with product catalog, shopping cart, and secure checkout.',
      'techStack': ['Flutter', 'Dart', 'Hive', 'State Management'],
    },
    {
      'title': 'Password Strength Checker',
      'category': 'Cybersecurity',
      'description': 'An application that evaluates password strength and checks against known breached password databases.',
      'techStack': ['Cybersecurity', 'Security Assessment'],
    },
    {
      'title': 'Paper Cups Website PenTest',
      'category': 'Cybersecurity',
      'description': 'Conducted a comprehensive vulnerability assessment and penetration test for a paper cups and materials manufacturing website.',
      'techStack': ['Pen Testing', 'Vulnerability Assessment', 'OWASP'],
    },
    {
      'title': 'WiFi People Locating',
      'category': 'Fun Projects',
      'description': 'A fun experimental project utilizing WiFi signals and network packets to estimate people locations in a localized area.',
      'techStack': ['Network Analysis', 'Python', 'WiFi Locating'],
    },
    {
      'title': 'Enterprise Company Projects',
      'category': '.NET',
      'description': 'Developed and maintained various enterprise-level company projects using ASP.NET Core and related technologies.',
      'techStack': ['ASP.NET Core', 'C#', 'SQL Server'],
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
                  Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    children: List.generate(filteredProjects.length, (index) {
                      return SizedBox(
                        width: isMobile ? double.infinity : (MediaQuery.of(context).size.width - 230) / 2,
                        child: _buildProjectCard(filteredProjects[index], index, isMobile)
                            .animate(key: ValueKey('${_selectedCategory}_$index'))
                            .fade(duration: 600.ms, delay: (100 * index).ms)
                            .slideY(begin: 0.1, end: 0),
                      );
                    }),
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
    // Generate colors based on category
    Color primaryGradientColor;
    Color secondaryGradientColor;
    
    switch (project['category']) {
      case 'Flutter':
        primaryGradientColor = Colors.blue.shade900.withOpacity(0.7);
        secondaryGradientColor = Colors.blue.shade500.withOpacity(0.5);
        break;
      case 'Cybersecurity':
        primaryGradientColor = Colors.red.shade900.withOpacity(0.7);
        secondaryGradientColor = Colors.orange.shade700.withOpacity(0.5);
        break;
      case '.NET':
        primaryGradientColor = Colors.purple.shade900.withOpacity(0.7);
        secondaryGradientColor = Colors.deepPurple.shade500.withOpacity(0.5);
        break;
      default:
        primaryGradientColor = Colors.green.shade900.withOpacity(0.7);
        secondaryGradientColor = Colors.teal.shade500.withOpacity(0.5);
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryGradientColor,
            AppColors.surface,
          ],
        ),
        border: Border.all(color: secondaryGradientColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryGradientColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: secondaryGradientColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: secondaryGradientColor.withOpacity(0.5)),
                      ),
                      child: Text(
                        project['category'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      project['title'],
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: isMobile ? 24 : 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      project['description'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: (project['techStack'] as List<String>).map((tech) {
                        return Text(
                          tech,
                          style: TextStyle(
                            color: secondaryGradientColor.withOpacity(0.9),
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        if (project['github'] != null)
                          IconButton(
                            onPressed: () => launchUrl(Uri.parse(project['github'])),
                            icon: const Icon(Icons.code, color: Colors.white),
                            tooltip: 'View Source Code',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
