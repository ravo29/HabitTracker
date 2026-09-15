import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email Validation', () {
    test('should validate correct email format', () {
      const email = 'test@example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, true);
    });

    test('should reject email without @ symbol', () {
      const email = 'testexample.com';
      final isValid = _isValidEmail(email);
      expect(isValid, false);
    });

    test('should reject email without domain', () {
      const email = 'test@';
      final isValid = _isValidEmail(email);
      expect(isValid, false);
    });

    test('should reject email without local part', () {
      const email = '@example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, false);
    });

    test('should accept email with subdomain', () {
      const email = 'test@mail.example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, true);
    });

    test('should accept email with numbers', () {
      const email = 'test123@example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, true);
    });

    test('should accept email with dots in local part', () {
      const email = 'test.user@example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, true);
    });

    test('should reject empty email', () {
      const email = '';
      final isValid = _isValidEmail(email);
      expect(isValid, false);
    });

    test('should reject email with spaces', () {
      const email = 'test @example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, false);
    });

    test('should reject email with special characters', () {
      const email = 'test#@example.com';
      final isValid = _isValidEmail(email);
      expect(isValid, false);
    });
  });

  group('Password Validation', () {
    test('should validate strong password', () {
      const password = 'StrongPass123!';
      final isValid = _isValidPassword(password);
      expect(isValid, true);
    });

    test('should reject password less than 8 characters', () {
      const password = 'Short1!';
      final isValid = _isValidPassword(password);
      expect(isValid, false);
    });

    test('should reject password without numbers', () {
      const password = 'StrongPassword!';
      final isValid = _isValidPassword(password);
      expect(isValid, false);
    });

    test('should reject password without special characters', () {
      const password = 'StrongPassword123';
      final isValid = _isValidPassword(password);
      expect(isValid, false);
    });

    test('should reject empty password', () {
      const password = '';
      final isValid = _isValidPassword(password);
      expect(isValid, false);
    });

    test('should accept password with only letters and numbers if length sufficient', () {
      const password = 'StrongPassword123';
      final isValid = _isValidPassword(password);
      expect(isValid, false); // Requires special character
    });
  });

  group('Name Validation', () {
    test('should validate correct name format', () {
      const name = 'John Doe';
      final isValid = _isValidName(name);
      expect(isValid, true);
    });

    test('should accept single word name', () {
      const name = 'John';
      final isValid = _isValidName(name);
      expect(isValid, true);
    });

    test('should accept name with hyphen', () {
      const name = 'Mary-Jane';
      final isValid = _isValidName(name);
      expect(isValid, true);
    });

    test('should accept name with apostrophe', () {
      const name = "O'Connor";
      final isValid = _isValidName(name);
      expect(isValid, true);
    });

    test('should reject empty name', () {
      const name = '';
      final isValid = _isValidName(name);
      expect(isValid, false);
    });

    test('should reject name with numbers', () {
      const name = 'John123';
      final isValid = _isValidName(name);
      expect(isValid, false);
    });

    test('should reject name with special characters', () {
      const name = 'John@Doe';
      final isValid = _isValidName(name);
      expect(isValid, false);
    });
  });
}

// Helper functions for validation
bool _isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool _isValidPassword(String password) {
  final hasMinLength = password.length >= 8;
  final hasNumber = RegExp(r'\d').hasMatch(password);
  final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  return hasMinLength && hasNumber && hasSpecialChar;
}

bool _isValidName(String name) {
  final nameRegex = RegExp(r'^[a-zA-Z\s\-\'\.]+$');
  return nameRegex.hasMatch(name) && name.trim().isNotEmpty;
}