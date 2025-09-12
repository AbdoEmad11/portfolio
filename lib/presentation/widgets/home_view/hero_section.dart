import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/custom_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  late AnimationController _typewriterController;
  late Animation<int> _typewriterAnimation;

  final List<String> _typewriterTexts = [
    'Flutter Developer',
    'Software Engineer',
    'Flutter Developer',
    'Software Engineer',

  ];

  int _currentTextIndex = 0;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startTypewriterEffect();
  }

  void _setupAnimations() {
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _typewriterController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  void _startTypewriterEffect() {
    _typeNextText();
  }

  void _typeNextText() async {
    final currentText = _typewriterTexts[_currentTextIndex];

    // Type forward
    for (int i = 0; i <= currentText.length; i++) {
      if (mounted) {
        setState(() {
          _displayText = currentText.substring(0, i);
        });
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

    // Wait
    await Future.delayed(const Duration(seconds: 2));

    // Type backward
    for (int i = currentText.length; i >= 0; i--) {
      if (mounted) {
        setState(() {
          _displayText = currentText.substring(0, i);
        });
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }

    // Move to next text
    if (mounted) {
      _currentTextIndex = (_currentTextIndex + 1) % _typewriterTexts.length;
      await Future.delayed(const Duration(milliseconds: 500));
      _typeNextText();
    }
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _typewriterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated blue gradient background
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _floatingController,
            builder: (context, _) {
              final t = _floatingController.value;
              final begin = Alignment(-0.8 + 0.6 * t, -1.0);
              final end = Alignment(1.0, 0.6 - 0.6 * t);
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: begin,
                    end: end,
                    colors: const [
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF0B0B0B),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              );
            },
          ),
        ),

        // Subtle vignette overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.transparent,
                  Colors.black.withOpacity(0.25),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Foreground content
        Positioned.fill(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveValue(
                  mobile: 16,
                  tablet: 24,
                  desktop: 32,
                ),
              ),
              child: context.isDesktop
                  ? _buildDesktopLayout()
                  : _buildMobileLayout(),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildGradientBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          context.colorScheme.primary.withOpacity(0.05),
          context.colorScheme.secondary.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(
          mobile: 1200,
          tablet: 1400,
          desktop: 1600,
          largeDesktop: 1800,
        ),
      ),
      height: context.responsiveValue(
        mobile: context.height * 0.85,
        tablet: context.height * 0.9,
        desktop: context.height * 0.85,
        largeDesktop: context.height * 0.8,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: context.responsiveValue(
                  mobile: 3,
                  tablet: 3,
                  desktop: 3,
                  largeDesktop: 4,
                ).round(),
                child: _buildContent(),
              ),
              SizedBox(
                width: context.responsiveValue(
                  mobile: 48,
                  tablet: 56,
                  desktop: 64,
                  largeDesktop: 72,
                ),
              ),
              Expanded(
                flex: context.responsiveValue(
                  mobile: 2,
                  tablet: 2,
                  desktop: 2,
                  largeDesktop: 3,
                ).round(),
                child: _buildVisualElement(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildVisualElement(),
            const SizedBox(height: 32),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final glassColor = Colors.white.withOpacity(context.isDesktop ? 0.06 : 0.08);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? 24 : 16,
            vertical: context.isDesktop ? 24 : 16,
          ),
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: context.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting
        TweenAnimationBuilder<double>(
          duration: AppConstants.mediumAnimation,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Text(
            AppHelpers.getGreeting(),
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
          ),
        ),

        const SizedBox(height: 8),

        // Name
        TweenAnimationBuilder<double>(
          duration: AppConstants.mediumAnimation,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Text(
            "I'm ${AppConstants.name}",
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
          ),
        ),

        const SizedBox(height: 16),

        // Animated title
        Container(
          height: 60,
          alignment: context.isDesktop
              ? Alignment.centerLeft
              : Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _displayText,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 2,
                height: 32,
                margin: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: AnimatedBuilder(
                  animation: _floatingController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: (_floatingController.value * 2) % 2 > 1 ? 1.0 : 0.0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Description
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              AppConstants.summary.trim(),
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
              textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Action buttons
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
        ),

        const SizedBox(height: 32),

        // Social links
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1200),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
        ),
      ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisualElement() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: child,
        );
      },
      child: Center(
        child: Container(
          width: context.responsiveValue(
            mobile: 220,
            tablet: 280,
            desktop: 320,
          ),
          height: context.responsiveValue(
            mobile: 220,
            tablet: 280,
            desktop: 320,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0D47A1), // Deep Blue
                Color(0xFF1976D2), // Primary Blue
                Color(0xFF42A5F5), // Light Blue
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1976D2).withOpacity(0.45),
                blurRadius: 40,
                offset: const Offset(0, 15),
              ),
              BoxShadow(
                color: const Color(0xFF0D47A1).withOpacity(0.25),
                blurRadius: 60,
                offset: const Offset(0, 25),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo holder background
              Container(
                width: context.responsiveValue(
                  mobile: 92,
                  tablet: 112,
                  desktop: 136,
                ),
                height: context.responsiveValue(
                  mobile: 92,
                  tablet: 112,
                  desktop: 136,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Static decorative rings (web-safe)
              ...List.generate(3, (index) {
                return Container(
                  width: context.responsiveValue(
                    mobile: 120 + (index * 20),
                    tablet: 150 + (index * 25),
                    desktop: 180 + (index * 30),
                  ),
                  height: context.responsiveValue(
                    mobile: 120 + (index * 20),
                    tablet: 150 + (index * 25),
                    desktop: 180 + (index * 30),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08 - (index * 0.02)),
                      width: 1.5,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: FaIcon(
            icon,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}