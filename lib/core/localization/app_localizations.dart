import 'dart:ui';
import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

class AppLocalizations {
  const AppLocalizations._(this.locale);

  final Locale locale;

  static AppLocalizations of(Locale locale) {
    return AppLocalizations._(locale);
  }

  static const Map<String, Map<String, String>> _values = {
    'en': appLocalizationsEn,
    'ar': appLocalizationsAr,
  };

  String _text(String key) {
    final lang = _values[locale.languageCode] ?? _values['en']!;
    return lang[key] ?? _values['en']![key] ?? key;
  }

  String get adminLogin => _text('adminLogin');
  String get email => _text('email');
  String get password => _text('password');
  String get requiredField => _text('required');
  String get minimum6Characters => _text('min6');
  String get login => _text('login');
  String get createAccount => _text('createAccount');
  String get loginFailed => _text('loginFailed');
  String get noInternetTitle => _text('noInternetTitle');
  String get noInternetSubtitle => _text('noInternetSubtitle');
  String get tryAgain => _text('tryAgain');
  String get noInternetRetryFailed => _text('noInternetRetryFailed');
}
