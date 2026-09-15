import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

abstract class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Common strings
  String get appTitle;
  String get settings;
  String get themeMode;
  String get language;
  String get french;
  String get english;

  // Auth strings
  String get login;
  String get register;
  String get email;
  String get password;
  String get forgotPassword;
  String get loginButton;
  String get registerButton;
  String get logout;

  // Navigation strings
  String get home;
  String get today;
  String get statistics;
  String get calendar;

  // Habit strings
  String get addHabit;
  String get editHabit;
  String get deleteHabit;
  String get habitTitle;
  String get habitDescription;
  String get targetDays;
  String get currentStreak;
  String get completionRate;

  // Common actions
  String get save;
  String get cancel;
  String get delete;
  String get confirm;

  // Onboarding strings
  String get onboardingTitle1;
  String get onboardingDesc1;
  String get onboardingTitle2;
  String get onboardingDesc2;
  String get onboardingTitle3;
  String get onboardingDesc3;
  String get skip;
  String get next;
  String get start;

  // Theme strings
  String get lightTheme;
  String get darkTheme;
  String get systemTheme;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return AppLocalizationsEn();
      case 'fr':
        return AppLocalizationsFr();
      default:
        return AppLocalizationsEn();
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}