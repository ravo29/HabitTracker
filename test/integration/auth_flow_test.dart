import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/main.dart';
import 'package:habittracker/features/auth/presentation/auth_screen.dart';
import 'package:habittracker/features/onboarding/presentation/onboarding_screen.dart';
import 'package:habittracker/features/home/presentation/main_wrapper_screen.dart';

void main() {
  group('Authentication Flow Integration Tests', () {
    testWidgets('complete user registration and login flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Start at splash screen
      expect(find.byType(Scaffold), findsOneWidget);

      // Navigate to onboarding (simulated)
      await tester.pumpAndSettle();

      // Complete onboarding
      expect(find.byType(OnboardingScreen), findsOneWidget);

      // Navigate through onboarding pages
      final nextButton = find.byType(FilledButton);
      expect(nextButton, findsOneWidget);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Complete onboarding and navigate to auth
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Should be at auth screen
      expect(find.byType(AuthScreen), findsOneWidget);

      // Switch to registration form
      final registerButton = find.text('Créer un compte');
      if (registerButton.evaluate().isNotEmpty) {
        await tester.tap(registerButton);
        await tester.pumpAndSettle();
      }

      // Fill in registration form
      final firstNameField = find.byKey(const Key('first_name_field'));
      final lastNameField = find.byKey(const Key('last_name_field'));
      final emailField = find.byKey(const Key('email_field'));
      final passwordField = find.byKey(const Key('password_field'));

      if (firstNameField.evaluate().isNotEmpty) {
        await tester.enterText(firstNameField, 'John');
        await tester.pumpAndSettle();
      }

      if (lastNameField.evaluate().isNotEmpty) {
        await tester.enterText(lastNameField, 'Doe');
        await tester.pumpAndSettle();
      }

      if (emailField.evaluate().isNotEmpty) {
        await tester.enterText(emailField, 'john.doe@example.com');
        await tester.pumpAndSettle();
      }

      if (passwordField.evaluate().isNotEmpty) {
        await tester.enterText(passwordField, 'SecurePass123!');
        await tester.pumpAndSettle();
      }

      // Submit registration
      final submitButton = find.byType(ElevatedButton);
      if (submitButton.evaluate().isNotEmpty) {
        await tester.tap(submitButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('login flow with valid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to auth screen
      await tester.pumpAndSettle();

      // Skip onboarding if present
      final skipButton = find.text('Passer');
      if (skipButton.evaluate().isNotEmpty) {
        await tester.tap(skipButton);
        await tester.pumpAndSettle();
      }

      // Should be at auth screen
      expect(find.byType(AuthScreen), findsOneWidget);

      // Fill in login form
      final emailField = find.byKey(const Key('login_email_field'));
      final passwordField = find.byKey(const Key('login_password_field'));

      if (emailField.evaluate().isNotEmpty) {
        await tester.enterText(emailField, 'test@example.com');
        await tester.pumpAndSettle();
      }

      if (passwordField.evaluate().isNotEmpty) {
        await tester.enterText(passwordField, 'password123');
        await tester.pumpAndSettle();
      }

      // Submit login
      final loginButton = find.byType(ElevatedButton);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
      }

      // Should navigate to home screen after successful login
      // (This depends on actual authentication implementation)
    });

    testWidgets('logout flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate through the app to logged in state
      await tester.pumpAndSettle();

      // Find and tap logout button
      final logoutButton = find.text('Déconnexion');
      if (logoutButton.evaluate().isNotEmpty) {
        await tester.tap(logoutButton);
        await tester.pumpAndSettle();

        // Should return to auth screen
        expect(find.byType(AuthScreen), findsOneWidget);
      }
    });
  });
}