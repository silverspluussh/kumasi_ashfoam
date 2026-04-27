import 'package:ashfoam_sadiq/src/features/auth/login_page.dart';
import 'package:ashfoam_sadiq/src/features/auth/providers/auth_provider.dart';
import 'package:ashfoam_sadiq/main_app.dart';
import 'package:ashfoam_sadiq/src/core/config/supabase_config.dart';
import 'package:ashfoam_sadiq/src/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  setupServiceLocator();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(authStateProvider);

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
        home: sessionAsync.when(
          data: (state) {
            if (state.session != null) {
              return const StarterApp();
            }
            return const LoginPage();
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, stack) => Scaffold(
            body: Center(
              child: Text('Error initializing authentication: $error'),
            ),
          ),
        ),
      ),
    );
  }
}
