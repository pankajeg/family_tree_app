import 'dart:ui';

class AppFonts {
  AppFonts._();

  static const String english = 'Poppins';
  static const String arabic = 'Cairo';

  static String forLocale(Locale locale) {
    return locale.languageCode == 'ar' ? arabic : english;
  }
}
