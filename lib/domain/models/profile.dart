import 'package:flutter/widgets.dart';

import 'certification.dart';
import 'nav_destination.dart';
import 'project.dart';
import 'skill_category.dart';
import 'social_link.dart';

@immutable
class Profile {
  const Profile({
    required this.name,
    required this.shortName,
    required this.location,
    required this.roles,
    required this.thesis,
    required this.aboutLead,
    required this.aboutBody,
    required this.portraitAsset,
    required this.email,
    required this.resumeUrl,
    required this.githubUsername,
    required this.destinations,
    required this.socials,
    required this.skills,
    required this.projectCategories,
    required this.projects,
    required this.certifications,
  });

  final String name;
  final String shortName;
  final String location;
  final List<String> roles;
  final String thesis;
  final String aboutLead;
  final List<String> aboutBody;
  final String portraitAsset;
  final String email;
  final String resumeUrl;
  final String githubUsername;
  final List<NavDestination> destinations;
  final List<SocialLink> socials;
  final List<SkillCategory> skills;
  final List<String> projectCategories;
  final List<Project> projects;
  final List<Certification> certifications;
}