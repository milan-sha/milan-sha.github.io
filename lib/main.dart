import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/github_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/services/github_api_service.dart';
import 'data/services/url_launch_service.dart';
import 'ui/core/router/app_router.dart';
import 'ui/core/theme/app_theme.dart';
import 'ui/features/portfolio/view_models/portfolio_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final githubApi = GithubApiService();
  const urls = UrlLaunchService();
  final profileRepository = const ProfileRepository();
  final githubRepository = GithubRepository(api: githubApi);

  runApp(
    MultiProvider(
      providers: [
        Provider<GithubApiService>.value(value: githubApi),
        Provider<UrlLaunchService>.value(value: urls),
        Provider<ProfileRepository>.value(value: profileRepository),
        Provider<GithubRepository>.value(value: githubRepository),
        ChangeNotifierProvider(
          create: (context) => PortfolioViewModel(
            profileRepository: context.read<ProfileRepository>(),
            githubRepository: context.read<GithubRepository>(),
            urlLaunchService: context.read<UrlLaunchService>(),
          ),
        ),
      ],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Milan Sha',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.night,
      routerConfig: AppRouter.router,
    );
  }
}