import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../core/theme/app_colors.dart';
import 'terminal_window.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
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
                isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
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
          'About Me',
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

  Widget _buildDesktopLayout() {
    if (!_isVisible) return const SizedBox();
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 2,
          child: _buildImageOrDecoration(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    if (!_isVisible) return const SizedBox();
    
    return Column(
      children: [
        _buildImageOrDecoration(),
        const SizedBox(height: 40),
        _buildTextContent(),
      ],
    );
  }
  Widget _buildTextContent() {
    // Get isMobile from screen width since it's not passed down
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '<AboutMe />',
          style: GoogleFonts.firaCode(
            textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 32 : 48,
            ),
          ),
        ).animate().fade(duration: 800.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 20),
        Text(
          "I enjoy building scalable, secure, and user-friendly applications that solve real-world problems. I have developed multiple projects across different domains, including mobile applications, backend systems, web applications, and database-driven solutions.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ).animate().fade(delay: 300.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 20),
        Text(
          "I hold the Certified Ethical Hacker (CEH) certification from EC-Council, giving me a strong understanding of secure software development, ethical hacking, vulnerability assessment, penetration testing concepts, and cybersecurity best practices.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ).animate().fade(delay: 400.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 20),
        Text(
          "I also have experience using Python for automation and scripting projects.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ).animate().fade(delay: 500.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 20),
        Text(
          "I am a continuous learner who has learned to do fun projects, exploring emerging technologies and improving my engineering skills through hands-on development. My goal is to build impactful software while continuously growing as a developer.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.accent,
            fontStyle: FontStyle.italic,
          ),
        ).animate().fade(delay: 600.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildImageOrDecoration() {
    return TerminalWindow(
      title: 'profile.jpg',
      child: Container(
        height: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ).animate().fade(duration: 800.ms, delay: 200.ms).scale(begin: const Offset(0.9, 0.9), duration: 800.ms);
  }
}
