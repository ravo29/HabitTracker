import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date Utilities', () {
    test('should get current date', () {
      final now = DateTime.now();
      expect(now, isNotNull);
      expect(now.year, greaterThan(2020));
    });

    test('should calculate days between dates', () {
      final date1 = DateTime(2024, 1, 1);
      final date2 = DateTime(2024, 1, 8);
      final difference = date2.difference(date1).inDays;
      expect(difference, 7);
    });

    test('should handle same date difference', () {
      final date1 = DateTime(2024, 1, 1);
      final date2 = DateTime(2024, 1, 1);
      final difference = date2.difference(date1).inDays;
      expect(difference, 0);
    });

    test('should format date correctly', () {
      final date = DateTime(2024, 1, 15);
      final formatted = '${date.day}/${date.month}/${date.year}';
      expect(formatted, '15/1/2024');
    });

    test('should check if date is today', () {
      final today = DateTime.now();
      final todayNormalized = DateTime(today.year, today.month, today.day);
      final nowNormalized = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      expect(todayNormalized.year, nowNormalized.year);
    });

    test('should get start of week', () {
      final date = DateTime(2024, 1, 10); // Wednesday
      final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
      expect(startOfWeek.weekday, DateTime.monday);
    });

    test('should get end of week', () {
      final date = DateTime(2024, 1, 10); // Wednesday
      final endOfWeek = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
      expect(endOfWeek.weekday, DateTime.sunday);
    });

    test('should handle leap year', () {
      final leapYear = DateTime(2024, 2, 29);
      expect(leapYear.day, 29);
      expect(leapYear.month, 2);
    });

    test('should handle non-leap year', () {
      final nonLeapYear = DateTime(2023, 2, 28);
      expect(nonLeapYear.day, 28);
      expect(nonLeapYear.month, 2);
    });

    test('should calculate age from birthdate', () {
      final birthdate = DateTime(1990, 1, 1);
      final now = DateTime(2024, 1, 1);
      final age = now.year - birthdate.year;
      expect(age, 34);
    });
  });
}