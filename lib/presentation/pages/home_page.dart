import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/certifications_section.dart';
import '../widgets/github_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/particle_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'certifications': GlobalKey(),
    'github': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollToSection(String keyName) {
    final key = _sectionKeys[keyName];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with Parallax and Particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                // Calculate parallax offset
                double offset = 0;
                if (_scrollController.hasClients) {
                  offset = _scrollController.offset * 0.3; // 30% speed for parallax
                }
                
                return Transform.translate(
                  offset: Offset(0, offset),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2072&auto=format&fit=crop'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.background.withValues(alpha: 0.7),
                            AppColors.background.withValues(alpha: 0.95),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          
          Positioned.fill(
            child: ParticleBackground(child: const SizedBox.expand()),
          ),
          
          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  key: _sectionKeys['home'], 
                  child: HeroSection(
                    onViewProjects: () => _scrollToSection('projects'),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(key: _sectionKeys['about'], child: const AboutSection()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(key: _sectionKeys['skills'], child: const SkillsSection()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(key: _sectionKeys['projects'], child: const ProjectsSection()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(key: _sectionKeys['certifications'], child: const CertificationsSection()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(key: _sectionKeys['github'], child: const GithubSection()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(key: _sectionKeys['contact'], child: const ContactSection()),
              ),
              const SliverToBoxAdapter(
                child: FooterSection(),
              ),
            ],
          ),
          
          // Navigation Bar (Floating/Sticky)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3), // Glassmorphism background
            border: Border(bottom: BorderSide(color: AppColors.surfaceLight.withValues(alpha: 0.3))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PORTFOLIO', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
              Row(
                children: [
                  _navItem('Home', 'home'),
                  _navItem('About', 'about'),
                  _navItem('Skills', 'skills'),
                  _navItem('Projects', 'projects'),
                  _navItem('Contact', 'contact'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, String keyName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => _scrollToSection(keyName),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
