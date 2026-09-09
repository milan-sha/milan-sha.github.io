import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/portfolio/view_models/portfolio_view_model.dart';
import '../../features/portfolio/views/portfolio_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          return PortfolioPage(viewModel: context.read<PortfolioViewModel>());
        },
      ),
    ],
  );
}