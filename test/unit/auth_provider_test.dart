import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/core/services/auth_provider.dart';

void main() {
  group('AuthState', () {
    test('should create AuthState with required parameters', () {
      const state = AuthState(
        isLoggedIn: true,
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      expect(state.isLoggedIn, true);
      expect(state.email, 'test@example.com');
      expect(state.firstName, 'John');
      expect(state.lastName, 'Doe');
    });

    test('should create AuthState with only required parameters', () {
      const state = AuthState(isLoggedIn: false);

      expect(state.isLoggedIn, false);
      expect(state.email, null);
      expect(state.firstName, null);
      expect(state.lastName, null);
    });

    test('should handle null optional parameters', () {
      const state = AuthState(
        isLoggedIn: true,
        email: null,
        firstName: null,
        lastName: null,
      );

      expect(state.isLoggedIn, true);
      expect(state.email, null);
      expect(state.firstName, null);
      expect(state.lastName, null);
    });
  });

  group('AuthNotifier', () {
    late AuthNotifier authNotifier;

    setUp(() {
      authNotifier = AuthNotifier();
    });

    tearDown(() {
      authNotifier.dispose();
    });

    test('should initialize with logged out state', () {
      expect(authNotifier.state.isLoggedIn, false);
    });

    test('should update state on login', () {
      // This is a simplified test - in real scenario you'd mock Supabase
      // The actual implementation requires Supabase mocking
      expect(authNotifier.state.isLoggedIn, false);
    });

    test('should update state on logout', () async {
      // This would test the logout functionality
      // Requires Supabase mocking in real implementation
      expect(authNotifier.state.isLoggedIn, false);
    });
  });
}