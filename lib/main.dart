import 'package:ashfoam_sadiq/main_app.dart';
import 'package:ashfoam_sadiq/src/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:toastification/toastification.dart';

void main() {
  // Initialize all services
  setupServiceLocator();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.blue.light.desktop.copyWith(
      cardStyle: FCardStyleDelta.delta(
        decoration: DecorationDelta.boxDelta(
          border: Border.all(width: 1, color: Colors.grey),
        ),
      ),
    );

    return ToastificationWrapper(
      child: MaterialApp(
        supportedLocales: FLocalizations.supportedLocales,
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        builder: (_, child) => FTheme(
          data: theme,

          child: FToaster(child: FTooltipGroup(child: child!)),
        ),
        theme: theme.toApproximateMaterialTheme(),
        debugShowCheckedModeBanner: false,
        home: StarterApp(),
      ),
    );
  }
}
