import 'package:flutter/material.dart';
import 'package:holeo/src/core/localization/app_localization.dart';
import 'package:holeo/src/core/router/app_router_scope.dart';
import 'package:holeo/src/core/theme/color_schemes.dart';

/// A widget which is responsible for providing the app context.
class AppContext extends StatefulWidget {
  const AppContext({super.key});

  @override
  State<AppContext> createState() => _AppContextState();
}

class _AppContextState extends State<AppContext> {
  @override
  Widget build(BuildContext context) {
    final router = AppRouterScope.of(context);
    return MaterialApp.router(
      routerConfig: router.router,
      supportedLocales: AppLocalization.supportedLocales,
      localizationsDelegates: AppLocalization.localizationsDelegates,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      locale: const Locale('es'),
    );
  }
}
