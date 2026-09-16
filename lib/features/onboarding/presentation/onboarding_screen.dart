import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  double _pageValue = 0.0;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      title: 'Bienvenue sur HabitTracker Pro',
      description:
          'Votre compagnon quotidien pour construire des habitudes saines, suivre vos objectifs de santé et maintenir une routine équilibrée.',
      badgeText: 'À Propos',
    ),
    OnboardingItem(
      title: 'Suivi & Statistiques Précises',
      description:
          'Visualisez votre constance en temps réel, calculez vos séries (streaks) et observez votre progression grâce à des graphiques détaillés.',
      badgeText: 'Fonctionnalités',
    ),
    OnboardingItem(
      title: 'Rappels & Discipline',
      description:
          'Recevez des notifications personnalisées au bon moment pour ne jamais rompre la chaîne et atteindre une hygiène de vie optimale.',
      badgeText: 'Engagement',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (!_pageController.hasClients) return;
      final page = _pageController.page;
      if (page != null) {
        setState(() => _pageValue = page);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);

    if (!mounted) return;

    if (mounted) context.go('/auth');
  }

  bool get _isLastPage => _currentIndex == _items.length - 1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logotracker.png',
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.track_changes_rounded);
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'HabitTracker',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
        actions: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _isLastPage ? 0.0 : 1.0,
            child: IgnorePointer(
              ignoring: _isLastPage,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: Text(
                  'Passer',
                  style: TextStyle(
                    color:
                        isDark ? Colors.white70 : WhatsAppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              WhatsAppColors.accentGreen.withValues(
                alpha: (isDark ? 0.08 : 0.04) +
                    (_pageValue / (_items.length - 1)) * 0.03,
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final animationHeight =
                  constraints.maxHeight < 620 ? 130.0 : 210.0;

              return Column(
                children: [
                  Builder(
                    builder: (context) {
                      final wobble =
                          1.0 - (0.02 * (_pageValue - _currentIndex).abs());
                      return Transform.scale(
                        scale: wobble.clamp(0.97, 1.0),
                        child: Semantics(
                          label: 'Animation de chargement médical',
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            height: animationHeight,
                            decoration: BoxDecoration(
                              color: WhatsAppColors.accentGreen
                                  .withValues(alpha: isDark ? 0.1 : 0.08),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Lottie.asset(
                              'assets/animations/medical loading (1).json',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _items.length,
                      onPageChanged: (index) {
                        setState(() => _currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        final item = _items[index];

                        final distance = (_pageValue - index);
                        final opacity =
                            (1 - distance.abs() * 1.1).clamp(0.0, 1.0);
                        final slide = distance * 40;

                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Opacity(
                            opacity: opacity,
                            child: Transform.translate(
                              offset: Offset(slide, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedScale(
                                    duration: const Duration(milliseconds: 300),
                                    scale: _currentIndex == index ? 1.0 : 0.9,
                                    curve: Curves.easeOutBack,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: WhatsAppColors.accentGreen
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        item.badgeText.toUpperCase(),
                                        style: const TextStyle(
                                          color: WhatsAppColors.primaryGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    item.title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          height: 1.15,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          height: 1.5,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black87,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            _items.length,
                            (index) {
                              final active = _currentIndex == index;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                                margin: const EdgeInsets.only(right: 8),
                                height: 8,
                                width: active ? 28 : 8,
                                decoration: BoxDecoration(
                                  color: active
                                      ? WhatsAppColors.accentGreen
                                      : Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            },
                          ),
                        ),

                        FilledButton(
                          onPressed: () {
                            if (!_isLastPage) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeOutCubic,
                              );
                            } else {
                              _completeOnboarding();
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                                child: Text(
                                  _isLastPage ? 'Commencer' : 'Suivant',
                                  key: ValueKey(_isLastPage),
                                ),
                              ),
                              const SizedBox(width: 6),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                                child: Icon(
                                  _isLastPage
                                      ? Icons.arrow_forward_rounded
                                      : Icons.chevron_right_rounded,
                                  key: ValueKey(_isLastPage),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class OnboardingItem {
  final String title;
  final String description;
  final String badgeText;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.badgeText,
  });
}
