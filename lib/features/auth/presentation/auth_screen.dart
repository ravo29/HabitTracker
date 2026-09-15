import 'package:flutter/material.dart';
import 'package:habittracker/core/constants/app_theme.dart';
import 'package:habittracker/features/auth/presentation/widgets/login_form.dart';
import 'package:habittracker/features/auth/presentation/widgets/register_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFF7FCFA),
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 420;
              final horizontalPadding = isCompact ? 14.0 : 32.0;
              final verticalPadding = isCompact ? 14.0 : 24.0;
              final availableHeight =
                  constraints.maxHeight - (verticalPadding * 2);

              return Stack(
                children: [
                  Positioned(
                    top: -90,
                    left: -80,
                    child: Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        color:
                            WhatsAppColors.accentGreen.withValues(alpha: 0.18),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(180),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -55,
                    bottom: -80,
                    child: Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        color:
                            WhatsAppColors.lightGreen.withValues(alpha: 0.14),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(180),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 620,
                          minHeight: availableHeight > 0 ? availableHeight : 0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              isCompact ? 18 : 36,
                              isCompact ? 24 : 34,
                              isCompact ? 18 : 36,
                              isCompact ? 24 : 34,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.96),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: WhatsAppColors.primaryGreen
                                      .withValues(alpha: 0.10),
                                  blurRadius: 30,
                                  offset: const Offset(0, 14),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Semantics(
                                  label: 'Logo HabitTracker Pro',
                                  image: true,
                                  child: Image.asset(
                                    'assets/images/logotracker.png',
                                    width: isCompact ? 72 : 94,
                                    height: isCompact ? 72 : 94,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: isCompact ? 22 : 30),
                                _showLogin
                                    ? LoginForm(
                                        onSwitchToRegister: () {
                                          setState(() => _showLogin = false);
                                        },
                                      )
                                    : RegisterForm(
                                        onSwitchToLogin: () {
                                          setState(() => _showLogin = true);
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
