import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('contact-section'),
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
          'Get In Touch',
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildContactInfo().animate().fade(delay: 200.ms).slideX(begin: -0.1, end: 0),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildContactForm().animate().fade(delay: 400.ms).slideX(begin: 0.1, end: 0),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContactInfo().animate().fade(delay: 200.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 60),
        _buildContactForm().animate().fade(delay: 400.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Connect",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Whether you have a question or just want to say hi, I'll try my best to get back to you!",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        _buildContactItem(Icons.email, 'milanshamon@gmail.com'),
        const SizedBox(height: 20),
        _buildContactItem(Icons.location_on, 'Ernakulam, Kerala'),
        const SizedBox(height: 40),
        Row(
          children: [
            _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com/in/milansha2003'),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/milan-sha'),
          ],
        )
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(dynamic icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(icon, color: AppColors.textSecondary, size: 24),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildTextField('Name', Icons.person)),
                const SizedBox(width: 20),
                Expanded(child: _buildTextField('Email', Icons.email)),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField('Subject', Icons.subject),
            const SizedBox(height: 20),
            _buildTextField('Message', Icons.message, maxLines: 5),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message sent successfully!')),
                    );
                  }
                },
                child: const Text('Send Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: maxLines == 1 ? Icon(icon, color: AppColors.textSecondary) : null,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
