import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/core/services/settings_providers.dart';

void main() {
  group('ThemeModeNotifier', () {
    late ThemeModeNotifier themeModeNotifier;

    setUp(() {
      themeModeNotifier = ThemeModeNotifier();
    });

    tearDown(() {
      themeModeNotifier.dispose();
    });

    test('should initialize with system theme mode', () {
      expect(themeModeNotifier.state, ThemeMode.system);
    });

    test('should update theme mode to light', () async {
      await themeModeNotifier.setThemeMode(ThemeMode.light);
      expect(themeModeNotifier.state, ThemeMode.light);
    });

    test('should update theme mode to dark', () async {
      await themeModeNotifier.setThemeMode(ThemeMode.dark);
      expect(themeModeNotifier.state, ThemeMode.dark);
    });

    test('should update theme mode to system', () async {
      await themeModeNotifier.setThemeMode(ThemeMode.system);
      expect(themeModeNotifier.state, ThemeMode.system);
    });

    test('should handle theme mode transitions', () async {
      await themeModeNotifier.setThemeMode(ThemeMode.light);
      expect(themeModeNotifier.state, ThemeMode.light);

      await themeModeNotifier.setThemeMode(ThemeMode.dark);
      expect(themeModeNotifier.state, ThemeMode.dark);

      await themeModeNotifier.setThemeMode(ThemeMode.system);
      expect(themeModeNotifier.state, ThemeMode.system);
    });
  });

  group('LocaleNotifier', () {
    late LocaleNotifier localeNotifier;

    setUp(() {
      localeNotifier = LocaleNotifier();
    });

    tearDown(() {
      localeNotifier.dispose();
    });

    test('should initialize with null locale', () {
      expect(localeNotifier.state, null);
    });

    test('should update locale to French', () async {
      await localeNotifier.setLocale(const Locale('fr'));
      expect(localeNotifier.state?.languageCode, 'fr');
    });

    test('should update locale to English', () async {
      await localeNotifier.setLocale(const Locale('en'));
      expect(localeNotifier.state?.languageCode, 'en');
    });

    test('should handle locale transitions', () async {
      await localeNotifier.setLocale(const Locale('fr'));
      expect(localeNotifier.state?.languageCode, 'fr');

      await localeNotifier.setLocale(const Locale('en'));
      expect(localeNotifier.state?.languageCode, 'en');
    });

    test('should handle locale with country code', () async {
      await localeNotifier.setLocale(const Locale('fr', 'FR'));
      expect(localeNotifier.state?.languageCode, 'fr');
      expect(localeNotifier.state?.countryCode, 'FR');
    });
  });
}