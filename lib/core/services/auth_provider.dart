import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isLoggedIn;
  final String? email;
  final String? firstName;
  final String? lastName;

  const AuthState({
    required this.isLoggedIn,
    this.email,
    this.firstName,
    this.lastName,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier()
      : super(_stateFromUser(Supabase.instance.client.auth.currentUser)) {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      state = _stateFromUser(data.session?.user);
    });
  }

  final _client = Supabase.instance.client;

  static AuthState _stateFromUser(User? user) {
    final metadata = user?.userMetadata ?? const <String, dynamic>{};
    return AuthState(
      isLoggedIn: user != null,
      email: user?.email,
      firstName: metadata['first_name'] as String?,
      lastName: metadata['last_name'] as String?,
    );
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      final response = await _client.auth.signUp(
        email: cleanEmail,
        password: password,
        data: {
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
        },
      );
      state = _stateFromUser(response.user);
      return response.user != null;
    } catch (e) {
      debugPrint('Erreur Inscription Supabase: $e');
      rethrow;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      final response = await _client.auth.signInWithPassword(
        email: cleanEmail,
        password: password,
      );
      state = _stateFromUser(response.user);
      return response.user != null;
    } catch (e) {
      debugPrint('Erreur Connexion Supabase: $e');
      rethrow;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      return await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.habittracker://login-callback/',
      );
    } catch (e) {
      debugPrint('Erreur Google Sign-In: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
    state = const AuthState(isLoggedIn: false);
  }
}