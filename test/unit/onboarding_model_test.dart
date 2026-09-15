import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingItem', () {
    test('should create OnboardingItem with required parameters', () {
      const item = OnboardingItem(
        title: 'Welcome',
        description: 'Description here',
        badgeText: 'About',
      );

      expect(item.title, 'Welcome');
      expect(item.description, 'Description here');
      expect(item.badgeText, 'About');
    });

    test('should handle long titles', () {
      const longTitle = 'This is a very long title for testing purposes';
      const item = OnboardingItem(
        title: longTitle,
        description: 'Description',
        badgeText: 'Test',
      );

      expect(item.title.length, longTitle.length);
    });

    test('should handle long descriptions', () {
      const longDescription = 'This is a very long description that should be handled properly by the UI components to ensure proper display and user experience';
      const item = OnboardingItem(
        title: 'Test',
        description: longDescription,
        badgeText: 'Test',
      );

      expect(item.description.length, longDescription.length);
    });

    test('should handle special characters in badge text', () {
      const specialBadge = 'Émojis & Symbols! @#\$%';
      const item = OnboardingItem(
        title: 'Test',
        description: 'Description',
        badgeText: specialBadge,
      );

      expect(item.badgeText, specialBadge);
    });

    test('should handle empty strings', () {
      const item = OnboardingItem(
        title: '',
        description: '',
        badgeText: '',
      );

      expect(item.title, '');
      expect(item.description, '');
      expect(item.badgeText, '');
    });
  });
}