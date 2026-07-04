import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/theme/app_colors.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> _certs = [
    {
      'title': 'Certified Ethical Hacker (CEH)',
      'issuer': 'EC-Council',
      'icon': Icons.security,
      'color': Colors.redAccent,
    },
    {
      'title': 'Flutter Development',
      'issuer': 'Google / Udemy',
      'icon': Icons.phone_android,
      'color': AppColors.primary,
    },
    {
      'title': '.NET Development Certification',
      'issuer': 'Microsoft',
      'icon': Icons.desktop_windows,
      'color': AppColors.secondary,
    },
    {
      'title': 'AI & Machine Learning',
      'issuer': 'Coursera',
      'icon': Icons.psychology,
      'color': AppColors.accent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('certs-section'),
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
                      crossAxisCount: isMobile ? 1 : (sizingInformation.isTablet ? 2 : 4),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: isMobile ? 2 : 1.2,
                    ),
                    itemCount: _certs.length,
                    itemBuilder: (context, index) {
                      return _buildCertCard(_certs[index])
                          .animate()
                          .fade(delay: (150 * index).ms)
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
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
          'Certifications',
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

  Widget _buildCertCard(Map<String, dynamic> cert) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            cert['icon'],
            size: 60,
            color: cert['color'],
          ),
          const SizedBox(height: 20),
          Text(
            cert['title'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            cert['issuer'],
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
