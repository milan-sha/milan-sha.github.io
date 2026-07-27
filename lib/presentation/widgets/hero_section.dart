import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_colors.dart';
import 'glitch_text.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;

  const HeroSection({super.key, this.onViewProjects});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile = sizingInformation.isMobile;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 100,
            vertical: isMobile ? 50 : 150,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlitchText(
                text: "Hello, I'm Milan Sha",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 40 : 64,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 20),
                  ],
                ),
              ).animate().fade(duration: 800.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
              
              Wrap(
                children: [
                  Text(
                    "I am a ",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: isMobile ? 24 : 36,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: isMobile ? 24 : 36,
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Software Engineer', speed: const Duration(milliseconds: 100)),
                        TypewriterAnimatedText('Flutter Developer', speed: const Duration(milliseconds: 100)),
                        TypewriterAnimatedText('.NET Developer', speed: const Duration(milliseconds: 100)),
                        TypewriterAnimatedText('Certified Ethical Hacker (CEH)', speed: const Duration(milliseconds: 100)),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 1000),
                    ),
                  ),
                ],
              ).animate().fade(delay: 400.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: isMobile ? double.infinity : 600,
                child: Text(
                  "I build scalable, secure, and user-friendly applications that solve real-world problems. With expertise spanning mobile, backend, and cybersecurity, I turn ideas into impactful software.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
              ).animate().fade(delay: 800.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 50),
              
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  ElevatedButton(
                    onPressed: onViewProjects,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      backgroundColor: AppColors.primary,
                      shadowColor: AppColors.primary,
                      elevation: 15,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('View Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  OutlinedButton(
                    onPressed: () => launchUrl(Uri.parse('https://milan-sha.github.io/portfolio-web/resume.pdf')),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      side: const BorderSide(color: AppColors.accent, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Download Resume', style: TextStyle(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => launchUrl(Uri.parse('https://linkedin.com/in/milansha2003')),
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      color: AppColors.textSecondary,
                      iconSize: 28,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => launchUrl(Uri.parse('https://github.com/milan-sha')),
                      icon: const FaIcon(FontAwesomeIcons.github),
                      color: AppColors.textSecondary,
                      iconSize: 28,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ).animate().fade(delay: 1200.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
        );
      },
    );
  }
}
