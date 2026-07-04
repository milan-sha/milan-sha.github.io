import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/theme/app_colors.dart';
import 'terminal_window.dart';

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
      'image': 'https://images.unsplash.com/photo-1606811841689-23dfddce3e95?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'E-commerce App',
      'category': 'Flutter',
      'description': 'A full-featured e-commerce application with product catalog, shopping cart, and secure checkout.',
      'techStack': ['Flutter', 'Dart', 'Hive', 'State Management'],
      'image': 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Password Strength Checker',
      'category': 'Cybersecurity',
      'description': 'An application that evaluates password strength and checks against known breached password databases.',
      'techStack': ['Cybersecurity', 'Security Assessment'],
      'image': 'https://images.unsplash.com/photo-1614064641913-6b110b471978?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Paper Cups Website PenTest',
      'category': 'Cybersecurity',
      'description': 'Conducted a comprehensive vulnerability assessment and penetration test for a paper cups and materials manufacturing website.',
      'techStack': ['Pen Testing', 'Vulnerability Assessment', 'OWASP'],
      'image': 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'WiFi People Locating',
      'category': 'Fun Projects',
      'description': 'A fun experimental project utilizing WiFi signals and network packets to estimate people locations in a localized area.',
      'techStack': ['Network Analysis', 'Python', 'WiFi Locating'],
      'image': 'https://images.unsplash.com/photo-1524661135-423995f22d0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Enterprise Company Projects',
      'category': '.NET',
      'description': 'Developed and maintained various enterprise-level company projects using ASP.NET Core and related technologies.',
      'techStack': ['ASP.NET Core', 'C#', 'SQL Server'],
      'image': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
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
          '<Projects />',
          style: GoogleFonts.firaCode(
            textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: isMobile ? 32 : 48,
            ),
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
    bool isReversed = index % 2 != 0;
    
    if (isMobile) {
      return _buildMobileProjectCard(project);
    }
    
    return SizedBox(
      height: 450,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isReversed)
            Expanded(
              flex: 6,
              child: TerminalWindow(
                title: '${project['title'].toString().toLowerCase().replaceAll(' ', '_')}.exe',
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(project['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ).animate().fade(delay: 200.ms).slideX(begin: -0.1, end: 0),
            ),
          
          if (!isReversed) const SizedBox(width: 60),
          
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: _buildProjectContent(project, isReversed ? CrossAxisAlignment.start : CrossAxisAlignment.end),
            ),
          ),
          
          if (isReversed) const SizedBox(width: 60),
          
          if (isReversed)
            Expanded(
              flex: 6,
              child: TerminalWindow(
                title: '${project['title'].toString().toLowerCase().replaceAll(' ', '_')}.exe',
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(project['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ).animate().fade(delay: 200.ms).slideX(begin: 0.1, end: 0),
            ),
        ],
      ),
    );
  }
  
  Widget _buildMobileProjectCard(Map<String, dynamic> project) {
    return TerminalWindow(
      title: '${project['title'].toString().toLowerCase().replaceAll(' ', '_')}.exe',
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
          style: GoogleFonts.firaCode(
            textStyle: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project['title'],
          style: GoogleFonts.firaCode(
            textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          project['description'],
          style: GoogleFonts.firaCode(
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: AppColors.textSecondary,
            ),
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
              '[$tech]',
              style: GoogleFonts.firaCode(
                textStyle: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: alignment == CrossAxisAlignment.end ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              onPressed: () => launchUrl(Uri.parse('https://github.com/milan-sha')),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: Text('<View Project />', style: GoogleFonts.firaCode()),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
