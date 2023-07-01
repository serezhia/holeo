import 'package:go_router/go_router.dart';
import 'package:holeo/src/feature/sample/widget/sample_screen.dart';

/// The configuration of app routes.
class AppRouter {
  AppRouter();

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SampleScreen(),
      ),
    ],
  );
}
