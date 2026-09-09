import '../../domain/models/certification.dart';
import '../../domain/models/nav_destination.dart';
import '../../domain/models/profile.dart';
import '../../domain/models/project.dart';
import '../../domain/models/skill_category.dart';
import '../../domain/models/social_link.dart';

class ProfileRepository {
  const ProfileRepository();

  Profile getProfile() => _milan;

  static const _milan = Profile(
    name: 'Milan Sha',
    shortName: 'MS',
    location: 'Ernakulam, Kerala',
    roles: [
      'Software Engineer',
      'Flutter Developer',
      '.NET Developer',
      'Certified Ethical Hacker',
    ],
    thesis:
        'I build software that still works when someone tries to break it — on the phone, in the API, and in review.',
    aboutLead:
        'Flutter clients, .NET services, and the security instincts that keep them standing.',
    aboutBody: [
      'I design and ship applications across mobile, backend, and data — then pressure-test the seams. The CEH from EC-Council is not a costume. It is how I write: assume the happy path will be poked.',
      'Recent work includes clinic operations software, commerce flows, and quieter experiments like WI Guard, which listens to Wi-Fi signal drift to sense motion in a room.',
      'Python shows up when a job wants a sharp script. The rest of the time I am in Dart and C#, tightening the thing until it feels inevitable.',
    ],
    portraitAsset: 'image/milan profile.jpeg',
    email: 'milanshamon@gmail.com',
    resumeUrl: 'https://milan-sha.github.io/resume.pdf',
    githubUsername: 'milan-sha',
    destinations: [
      NavDestination(id: 'intro', label: 'Intro', tick: 'IN'),
      NavDestination(id: 'about', label: 'About', tick: 'AB'),
      NavDestination(id: 'skills', label: 'Range', tick: 'RG'),
      NavDestination(id: 'work', label: 'Work', tick: 'WK'),
      NavDestination(id: 'proof', label: 'Proof', tick: 'PF'),
      NavDestination(id: 'signal', label: 'Signal', tick: 'SG'),
      NavDestination(id: 'note', label: 'Note', tick: 'NT'),
    ],
    socials: [
      SocialLink(
        label: 'LinkedIn',
        url: 'https://linkedin.com/in/milansha2003',
        kind: SocialKind.linkedin,
      ),
      SocialLink(
        label: 'GitHub',
        url: 'https://github.com/milan-sha',
        kind: SocialKind.github,
      ),
      SocialLink(
        label: 'Email',
        url: 'mailto:milanshamon@gmail.com',
        kind: SocialKind.email,
      ),
    ],
    skills: [
      SkillCategory(
        title: 'Mobile',
        mark: 'FL',
        skills: [
          'Flutter',
          'Dart',
          'Firebase',
          'REST',
          'Responsive UI',
          'State management',
        ],
      ),
      SkillCategory(
        title: 'Backend',
        mark: 'NT',
        skills: [
          'ASP.NET',
          'ASP.NET Core',
          'C#',
          'Entity Framework',
          'REST APIs',
          'Auth',
        ],
      ),
      SkillCategory(
        title: 'Data',
        mark: 'DB',
        skills: [
          'SQL Server',
          'MySQL',
          'SQLite',
          'Schema design',
          'DBMS',
          'Query work',
        ],
      ),
      SkillCategory(
        title: 'Security',
        mark: 'CE',
        skills: [
          'CEH',
          'Ethical hacking',
          'Vuln assessment',
          'Pen testing',
          'Network security',
          'OWASP',
        ],
      ),
      SkillCategory(
        title: 'Bench',
        mark: 'TL',
        skills: [
          'Git',
          'GitHub',
          'VS Code',
          'Visual Studio',
          'Android Studio',
          'Figma',
          'Postman',
        ],
      ),
    ],
    projectCategories: ['All', 'Flutter', 'Security', 'Field notes'],
    projects: [
      Project(
        title: 'Smile Dental',
        category: 'Flutter',
        summary:
            'Clinic operations for Smile Dental — sterilization tracking, daily flow, and the unglamorous work that keeps a practice honest.',
        stack: ['Flutter', 'Dart', 'Firebase'],
      ),
      Project(
        title: 'Commerce app',
        category: 'Flutter',
        summary:
            'A cross-platform shop with a calm browse path and a checkout that does not flinch.',
        stack: ['Flutter', 'Dart', 'State management'],
      ),
      Project(
        title: 'Password strength tester',
        category: 'Security',
        summary:
            'A Python utility that scores brute-force and dictionary resilience, then says what to fix.',
        stack: ['Python', 'Assessment'],
      ),
      Project(
        title: 'WI Guard',
        category: 'Field notes',
        summary:
            'Turns a quiet router into a motion sensor. Reads RSSI drift. Draws a room that thought it was empty.',
        stack: ['Python', 'RF analysis'],
      ),
      Project(
        title: 'This site',
        category: 'Flutter',
        summary:
            'A Flutter web portfolio with a layered architecture, live GitHub signal, and a CI path to Pages.',
        stack: ['Flutter', 'Web', 'CI/CD'],
        href: 'https://github.com/milan-sha',
      ),
    ],
    certifications: [
      Certification(
        title: 'Certified Ethical Hacker',
        issuer: 'EC-Council',
        mark: 'CEH',
      ),
      Certification(
        title: 'Flutter development',
        issuer: 'Google / Udemy',
        mark: 'FL',
      ),
      Certification(
        title: '.NET development',
        issuer: 'Microsoft',
        mark: 'NET',
      ),
    ],
  );
}