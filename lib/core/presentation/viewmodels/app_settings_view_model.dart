import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole { member, admin }

class AppSettings {
  const AppSettings({
    required this.locale,
    required this.role,
    this.accessToken,
    this.userName,
    this.userEmail,
  });

  final Locale locale;
  final UserRole role;
  final String? accessToken;
  final String? userName;
  final String? userEmail;

  bool get isRtl => locale.languageCode == 'ar';

  AppSettings copyWith({
    Locale? locale,
    UserRole? role,
    String? accessToken,
    String? userName,
    String? userEmail,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      role: role ?? this.role,
      accessToken: accessToken ?? this.accessToken,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}

class AppSettingsViewModel extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    return const AppSettings(
      locale: Locale('en'),
      role: UserRole.member, 
    );
  }

  void toggleLanguage() {
    final nextLocale =
        state.locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    state = state.copyWith(locale: nextLocale);
  }

  void setRole(UserRole role) {
    state = state.copyWith(role: role);
  }

  void setSession({
    required String accessToken,
    required String userName,
    required String userEmail,
    required UserRole role,
  }) {
    state = state.copyWith(
      accessToken: accessToken,
      userName: userName,
      userEmail: userEmail,
      role: role,
    );
  }
}

final appSettingsProvider = NotifierProvider<AppSettingsViewModel, AppSettings>(
  AppSettingsViewModel.new,
);
