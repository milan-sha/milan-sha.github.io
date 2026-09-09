import 'package:url_launcher/url_launcher.dart';

class UrlLaunchService {
  const UrlLaunchService();

  Future<bool> open(String url) {
    return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<bool> mail({
    required String to,
    required String subject,
    required String body,
  }) {
    final uri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {'subject': subject, 'body': body},
    );
    return launchUrl(uri);
  }
}