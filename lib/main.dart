import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/core/generated/translations.g.dart';
import 'app/climb_around_app.dart';

void main() async {
  // Ensure that the app starts with the device locale
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  // Prevent the app from being rotated
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: const AppStartupWidget(),
      ),
    ),
  );
}
