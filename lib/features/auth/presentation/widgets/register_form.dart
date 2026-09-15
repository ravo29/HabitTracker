import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habittracker/core/constants/app_theme.dart';
import 'package:habittracker/core/services/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterForm extends ConsumerStatefulWidget {
  final VoidCallback onSwitchToLogin;

  const RegisterForm({super.key, required this.onSwitchToLogin});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  static final _borderRadius = BorderRadius.circular(14);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final success = await ref.read(authProvider.notifier).register(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      if (!mounted) return;

      if (success) {
        context.go('/home');
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Une erreur est survenue lors de l'inscription"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: WhatsAppColors.primaryGreen),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(color: Color(0xFFD8E7E2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(color: Color(0xFFD8E7E2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(
          color: WhatsAppColors.accentGreen,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Créer un compte',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF173B5A),
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rejoignez-nous et commencez votre aventure.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 16),
          ),
          const SizedBox(height: 34),
          LayoutBuilder(
            builder: (context, constraints) {
              final firstName = TextFormField(
                controller: _firstNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _decoration('Prénom', Icons.person_outline_rounded),
                validator: (val) =>
                    val != null && val.trim().isNotEmpty ? null : 'Requis',
              );
              final lastName = TextFormField(
                controller: _lastNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _decoration('Nom', Icons.person_outline_rounded),
                validator: (val) =>
                    val != null && val.trim().isNotEmpty ? null : 'Requis',
              );

              if (constraints.maxWidth < 520) {
                return Column(
                  children: [
                    firstName,
                    const SizedBox(height: 16),
                    lastName,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: firstName),
                  const SizedBox(width: 16),
                  Expanded(child: lastName),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _decoration('Email', Icons.mail_outline_rounded),
            validator: (val) =>
                val != null && val.contains('@') ? null : 'Email invalide',
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _decoration('Mot de passe', Icons.lock_outline_rounded)
                .copyWith(
              suffixIcon: IconButton(
                tooltip: _obscurePassword
                    ? 'Afficher le mot de passe'
                    : 'Masquer le mot de passe',
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.blueGrey.shade400,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (val) =>
                val != null && val.length >= 6 ? null : 'Au moins 6 caractères',
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirm,
            decoration: _decoration(
              'Confirmer le mot de passe',
              Icons.lock_outline_rounded,
            ).copyWith(
              suffixIcon: IconButton(
                tooltip: _obscureConfirm
                    ? 'Afficher le mot de passe'
                    : 'Masquer le mot de passe',
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.blueGrey.shade400,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ),
            validator: (val) => val == _passwordController.text
                ? null
                : 'Les mots de passe ne correspondent pas',
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 58,
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : _submit,
              icon: _isSubmitting
                  ? const SizedBox.shrink()
                  : const Icon(Icons.login_rounded),
              label: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "S'inscrire",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: WhatsAppColors.accentGreen,
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: WhatsAppColors.accentGreen.withValues(alpha: 0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(child: Divider(color: Colors.blueGrey.shade100)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Ou se connecter avec',
                  style: TextStyle(
                    color: Colors.blueGrey.shade400,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.blueGrey.shade100)),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 58,
            child: OutlinedButton(
              onPressed: () async {
                final success =
                    await ref.read(authProvider.notifier).loginWithGoogle();
                if (!context.mounted) return;
                if (!success) return;

                context.go('/home');
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFD8E7E2)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/google_logo.png',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Continuer avec Google',
                    style: TextStyle(
                      color: Color(0xFF173B5A),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: widget.onSwitchToLogin,
            child: const Text(
              'Déjà un compte ? Se connecter',
              style: TextStyle(color: WhatsAppColors.primaryGreen),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_rounded,
                size: 18,
                color: WhatsAppColors.accentGreen,
              ),
              const SizedBox(width: 8),
              Text(
                'Votre sécurité est notre priorité',
                style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}