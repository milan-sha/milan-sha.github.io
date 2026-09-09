import 'package:flutter/foundation.dart';

import '../../../../data/repositories/github_repository.dart';
import '../../../../data/repositories/profile_repository.dart';
import '../../../../data/services/url_launch_service.dart';
import '../../../../domain/models/github_profile.dart';
import '../../../../domain/models/profile.dart';
import '../../../../domain/models/project.dart';
import '../../../../domain/models/result.dart';

class PortfolioViewModel extends ChangeNotifier {
  PortfolioViewModel({
    required ProfileRepository profileRepository,
    required GithubRepository githubRepository,
    required UrlLaunchService urlLaunchService,
  }) : _profileRepository = profileRepository,
       _githubRepository = githubRepository,
       _urls = urlLaunchService;

  final ProfileRepository _profileRepository;
  final GithubRepository _githubRepository;
  final UrlLaunchService _urls;

  late final Profile profile = _profileRepository.getProfile();

  String _activeSection = 'intro';
  String get activeSection => _activeSection;

  String _projectFilter = 'All';
  String get projectFilter => _projectFilter;

  GithubProfile? _github;
  GithubProfile? get github => _github;

  bool _githubLoading = false;
  bool get githubLoading => _githubLoading;

  String? _githubError;
  String? get githubError => _githubError;

  String name = '';
  String email = '';
  String subject = '';
  String message = '';
  String? formError;
  String? formStatus;
  bool sending = false;

  List<Project> get visibleProjects {
    if (_projectFilter == 'All') return profile.projects;
    return profile.projects
        .where((project) => project.category == _projectFilter)
        .toList(growable: false);
  }

  Future<void> load() async {
    _githubLoading = true;
    _githubError = null;
    notifyListeners();

    final result = await _githubRepository.getProfile(profile.githubUsername);
    switch (result) {
      case Ok(:final value):
        _github = value;
      case Err(:final message):
        _githubError = message;
    }

    _githubLoading = false;
    notifyListeners();
  }

  void setActiveSection(String id) {
    if (_activeSection == id) return;
    _activeSection = id;
    notifyListeners();
  }

  void setProjectFilter(String category) {
    if (_projectFilter == category) return;
    _projectFilter = category;
    notifyListeners();
  }

  Future<void> openUrl(String url) => _urls.open(url);

  Future<void> openResume() => _urls.open(profile.resumeUrl);

  Future<void> sendNote() async {
    formError = null;
    formStatus = null;

    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    final trimmedSubject = subject.trim();
    final trimmedMessage = message.trim();

    if (trimmedName.isEmpty) {
      formError = 'Add your name.';
      notifyListeners();
      return;
    }
    if (!_looksLikeEmail(trimmedEmail)) {
      formError = 'Use a real email so a reply can find you.';
      notifyListeners();
      return;
    }
    if (trimmedSubject.isEmpty) {
      formError = 'Give the note a subject.';
      notifyListeners();
      return;
    }
    if (trimmedMessage.isEmpty) {
      formError = 'Write the note before sending.';
      notifyListeners();
      return;
    }

    sending = true;
    notifyListeners();

    final opened = await _urls.mail(
      to: profile.email,
      subject: trimmedSubject,
      body: 'From $trimmedName <$trimmedEmail>\n\n$trimmedMessage',
    );

    sending = false;
    formStatus = opened
        ? 'Opening your mail app.'
        : 'Mail app did not open. Write to ${profile.email}.';
    notifyListeners();
  }

  bool _looksLikeEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }
}