import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_fonts.dart';
import '../core/feedback/app_scaffold_messenger.dart';
import '../core/network/presentation/widgets/internet_status_guard.dart';
import '../core/presentation/viewmodels/app_settings_view_model.dart';
import '../features/auth/presentation/views/login_page.dart';

class FamilyTreeApp extends ConsumerWidget {
  const FamilyTreeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return MaterialApp(
      scaffoldMessengerKey: AppScaffoldMessenger.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Family Tree App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: AppColors.error,
          surface: AppColors.surface,
        ),
        fontFamily: AppFonts.forLocale(settings.locale),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      locale: settings.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return InternetStatusGuard(
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const LoginPage(),
    );
  }
}
