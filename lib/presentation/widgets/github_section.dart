import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import 'hover_3d_card.dart';

class GithubSection extends StatefulWidget {
  const GithubSection({super.key});

  @override
  State<GithubSection> createState() => _GithubSectionState();
}

class _GithubSectionState extends State<GithubSection> {
  bool _isVisible = false;
  
  // Placeholder data - replace with actual API fetch later
  final Map<String, dynamic> _githubStats = {
    'username': 'milan-sha',
    'public_repos': 15,
    'followers': 10,
    'following': 5,
    'stars': 20,
  };

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('github-section'),
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
                  Hover3dCard(
                    depth: 8.0,
                    child: _buildGithubCard(isMobile),
                  )
                      .animate()
                      .fade(duration: 800.ms)
                      .slideY(begin: 0.2, end: 0),
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
          'GitHub Activity',
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

  Widget _buildGithubCard(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          FaIcon(FontAwesomeIcons.github, size: 80, color: AppColors.textPrimary),
          const SizedBox(height: 20),
          Text(
            '@${_githubStats['username']}',
            style: const TextStyle(
              fontSize: 24,
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: isMobile ? 20 : 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildStatItem('Repositories', _githubStats['public_repos'].toString(), Icons.book),
              _buildStatItem('Stars', _githubStats['stars'].toString(), Icons.star),
              _buildStatItem('Followers', _githubStats['followers'].toString(), Icons.people),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse('https://github.com/${_githubStats['username']}')),
            icon: const FaIcon(FontAwesomeIcons.github),
            label: const Text('Visit GitHub Profile'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 24),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
