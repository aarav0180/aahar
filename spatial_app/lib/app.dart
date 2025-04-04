import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      scaffoldMessengerKey: scaffoldKey,
      routerConfig: AppRoutes.appRouters,
      debugShowCheckedModeBanner: true,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      scrollBehavior: const AppScrollBehavior(),
    );
  }
}
