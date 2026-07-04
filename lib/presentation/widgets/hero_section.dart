import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../core/theme/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
              Text(
                "> const developer = 'Milan Sha';",
                style: GoogleFonts.firaCode(
                  textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isMobile ? 28 : 48,
                    fontWeight: FontWeight.w900,
                    color: AppColors.accent,
                  ),
                ),
              ).animate().fade(duration: 800.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
              
              Wrap(
                children: [
                  Text(
                    "> developer.role = '",
                    style: GoogleFonts.firaCode(
                      textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: isMobile ? 18 : 28,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  DefaultTextStyle(
                    style: GoogleFonts.firaCode(
                      textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: isMobile ? 18 : 28,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
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
                  Text(
                    "';",
                    style: GoogleFonts.firaCode(
                      textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: isMobile ? 18 : 28,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ).animate().fade(delay: 400.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: isMobile ? double.infinity : 600,
                child: Text(
                  "// I build scalable, secure, and user-friendly applications that solve real-world problems. With expertise spanning mobile, backend, and cybersecurity, I turn ideas into impactful software.",
                  style: GoogleFonts.firaCode(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      fontSize: isMobile ? 14 : 16,
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ).animate().fade(delay: 800.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 50),
              
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('View Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      side: const BorderSide(color: AppColors.accent, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Download Resume', style: TextStyle(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.bold)),
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
