import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Locale Utilities', () {
    test('should create French locale', () {
      const frenchLocale = Locale('fr');
      expect(frenchLocale.languageCode, 'fr');
    });

    test('should create English locale', () {
      const englishLocale = Locale('en');
      expect(englishLocale.languageCode, 'en');
    });

    test('should create locale with country code', () {
      const locale = Locale('fr', 'FR');
      expect(locale.languageCode, 'fr');
      expect(locale.countryCode, 'FR');
    });

    test('should compare locales correctly', () {
      const locale1 = Locale('en');
      const locale2 = Locale('en');
      const locale3 = Locale('fr');

      expect(locale1 == locale2, true);
      expect(locale1 == locale3, false);
    });

    test('should handle locale toString', () {
      const locale = Locale('fr', 'FR');
      expect(locale.toString(), contains('fr'));
      expect(locale.toString(), contains('FR'));
    });

    test('should create locale from language tag', () {
      const locale = Locale.fromSubtags(languageCode: 'en', countryCode: 'US');
      expect(locale.languageCode, 'en');
      expect(locale.countryCode, 'US');
    });

    test('should handle system locale', () {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      expect(systemLocale, isNotNull);
    });
  });
}