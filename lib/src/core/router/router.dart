import 'package:go_router/go_router.dart';
import 'package:holeo/src/feature/sample/widget/camera_screen.dart';
import 'package:holeo/src/feature/sample/widget/result_screen.dart';
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
      GoRoute(
        path: '/camera',
        builder: (context, state) => const CameraScreenBuilder(),
        routes: [
          GoRoute(
            path: 'result',
            builder: (context, state) => const ResultScreen(),
          )
        ],
      ),
    ],
  );
}
