import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/global.dart';
import 'core/generated/translations.g.dart';
import 'core/providers.dart';
import 'presentation/shared/widgets/loading_widget.dart';
import 'presentation/modules/splash/splash_view.dart';
import 'presentation/routes/router.dart';
import 'presentation/shared/controllers/theme_controller.dart';
import 'presentation/shared/theme.dart';

final appStartupProvider = FutureProvider<void>(
  (ref) async {
    ref.onDispose(
      () {
        ref.invalidate(sharedPreferencesProvider);
        ref.invalidate(packageInfoProvider);
      },
    );
    await ref.watch(sharedPreferencesProvider.future);
    await ref.watch(packageInfoProvider.future);
  },
);

/// This widget ensures that the async initializations are done before the app starts
class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => const ClimbAroundApp(),
      error: (e, __) => SplashView(
        error: e.toString(),
      ),
      loading: () => const LoadingWidget(),
    );
  }
}

/// The main app, once the async dependencies have been initialized
class ClimbAroundApp extends ConsumerWidget {
  const ClimbAroundApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: Global.appName,
      // Localizations
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      // Theme
      theme: AppTheme.getTheme(ref.watch(themeControllerProvider).darkMode),
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
