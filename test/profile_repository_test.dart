import 'package:flutter_test/flutter_test.dart';
import 'package:profile_web/data/repositories/profile_repository.dart';

void main() {
  test('returns Milan profile with real sections', () {
    const repository = ProfileRepository();
    final profile = repository.getProfile();

    expect(profile.name, 'Milan Sha');
    expect(profile.githubUsername, 'milan-sha');
    expect(profile.email, 'milanshamon@gmail.com');
    expect(profile.projects, isNotEmpty);
    expect(profile.skills.length, 5);
    expect(profile.certifications.first.mark, 'CEH');
    expect(profile.destinations.map((item) => item.id), contains('work'));
  });
}