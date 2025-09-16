import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
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
  late AnimationController _particleController;
  late AnimationController _waveController;
  late AnimationController _typewriterController;
  late AnimationController _glowController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _glowAnimation;

  // Simplified subtitle
  static const String _subtitle = 'Flutter Developer';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    // No typewriter; keep it sleek
  }

  void _setupAnimations() {
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _waveController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -15.0,
      end: 15.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    ));

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.linear,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  void _startTypewriterEffect() {}

  @override
  void dispose() {
    _floatingController.dispose();
    _particleController.dispose();
    _waveController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Deep space black background
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000), // Pure black
                  Color(0xFF0A0A0A), // Very dark gray
                  Color(0xFF000000), // Pure black
                ],
              ),
            ),
          ),
        ),

        // Animated wave background
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, _) {
              return CustomPaint(
                painter: WavePainter(_waveAnimation.value),
              );
            },
          ),
        ),

        // Advanced particle system
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _particleAnimation,
            builder: (context, _) {
              return CustomPaint(
                painter: AdvancedParticlePainter(_particleAnimation.value),
              );
            },
          ),
        ),

        // Grid overlay
        Positioned.fill(
          child: CustomPaint(
            painter: GridPainter(),
          ),
        ),

        // Main content
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveValue(
                mobile: 16,
                tablet: 24,
                desktop: 32,
              ),
              vertical: context.responsiveValue(
                mobile: 48,
                tablet: 64,
                desktop: 80,
              ),
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.responsiveValue(
                    mobile: 1200,
                    tablet: 1400,
                    desktop: 1600,
                    largeDesktop: 1800,
                  ),
                ),
                child: context.isDesktop
                    ? _buildDesktopLayout()
                    : _buildMobileLayout(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildContent(),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 2,
          child: _buildEnhancedVisual(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildEnhancedVisual(),
        const SizedBox(height: 40),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.10),
                Colors.blue.withOpacity(0.06),
                Colors.white.withOpacity(0.04),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF1E88E5).withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E88E5).withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: context.isDesktop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              // Greeting with glow effect
              AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF64B5F6).withOpacity(0.3),
                          blurRadius: 20 * _glowAnimation.value,
                          spreadRadius: 5 * _glowAnimation.value,
                        ),
                      ],
                    ),
                    child: Text(
                      AppHelpers.getGreeting(),
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF64B5F6),
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: const Color(0xFF1E88E5).withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Name with enhanced styling
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF1E88E5),
                    Color(0xFF64B5F6),
                    Color(0xFFBBDEFB),
                  ],
                ).createShader(bounds),
                child: Text(
                  "I'm ${AppConstants.name}",
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // Single clean subtitle
              Container(
                alignment: context.isDesktop ? Alignment.centerLeft : Alignment.center,
                child: Text(
                  _subtitle,
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFF42A5F5),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF1E88E5).withOpacity(0.35),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              // Enhanced description
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  AppConstants.summary.trim(),
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    height: 1.8,
                    fontSize: 16,
                  ),
                  textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              // Enhanced action buttons
              Wrap(
                alignment: context.isDesktop
                    ? WrapAlignment.start
                    : WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildEnhancedButton(
                    text: 'View My Projects',
                    icon: Icons.folder_outlined,
                    isPrimary: true,
                    onPressed: () => context.go('/projects'),
                  ),
                  _buildEnhancedButton(
                    text: 'Get In Touch',
                    icon: Icons.contact_mail_outlined,
                    isPrimary: false,
                    onPressed: () => context.go('/contact'),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Enhanced social links
              Row(
                mainAxisAlignment: context.isDesktop
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  _buildEnhancedSocialIcon(
                    FontAwesomeIcons.github,
                        () => AppHelpers.launchURL(AppConstants.github),
                  ),
                  const SizedBox(width: 20),
                  _buildEnhancedSocialIcon(
                    FontAwesomeIcons.linkedin,
                        () => AppHelpers.launchURL(AppConstants.linkedIn),
                  ),
                  const SizedBox(width: 20),
                  _buildEnhancedSocialIcon(
                    FontAwesomeIcons.envelope,
                        () => AppHelpers.launchEmail(AppConstants.email),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: isPrimary ? [
              BoxShadow(
                color: const Color(0xFF1E88E5).withOpacity(0.4 * _glowAnimation.value),
                blurRadius: 20 * _glowAnimation.value,
                spreadRadius: 2 * _glowAnimation.value,
                offset: const Offset(0, 8),
              ),
            ] : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: isPrimary
                      ? const LinearGradient(
                    colors: [
                      Color(0xFF1E88E5),
                      Color(0xFF1976D2),
                      Color(0xFF0D47A1),
                    ],
                  )
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  border: isPrimary
                      ? null
                      : Border.all(
                    color: const Color(0xFF1E88E5),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedSocialIcon(IconData icon, VoidCallback onTap) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E88E5).withOpacity(0.2 * _glowAnimation.value),
                blurRadius: 15 * _glowAnimation.value,
                spreadRadius: 2 * _glowAnimation.value,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1E88E5).withOpacity(0.2),
                      const Color(0xFF0D47A1).withOpacity(0.1),
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFF1E88E5).withOpacity(0.3),
                  ),
                ),
                child: FaIcon(
                  icon,
                  size: 20,
                  color: const Color(0xFF64B5F6),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedVisual() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                AnimatedBuilder(
                  animation: _glowAnimation,
                  builder: (context, child) {
                    return Container(
                      width: context.responsiveValue(
                        mobile: 300,
                        tablet: 350,
                        desktop: 400,
                      ) * _glowAnimation.value,
                      height: context.responsiveValue(
                        mobile: 300,
                        tablet: 350,
                        desktop: 400,
                      ) * _glowAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.transparent,
                            const Color(0xFF1E88E5).withOpacity(0.1),
                            const Color(0xFF0D47A1).withOpacity(0.2),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Main visual element
                Container(
                  width: context.responsiveValue(
                    mobile: 280,
                    tablet: 320,
                    desktop: 360,
                  ),
                  height: context.responsiveValue(
                    mobile: 280,
                    tablet: 320,
                    desktop: 360,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFF1E88E5),
                        Color(0xFF1976D2),
                        Color(0xFF0D47A1),
                        Color(0xFF000051),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E88E5).withOpacity(0.4),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                      BoxShadow(
                        color: const Color(0xFF0D47A1).withOpacity(0.3),
                        blurRadius: 80,
                        offset: const Offset(0, 30),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Flutter logo
                      Container(
                        width: context.responsiveValue(
                          mobile: 120,
                          tablet: 140,
                          desktop: 160,
                        ),
                        height: context.responsiveValue(
                          mobile: 120,
                          tablet: 140,
                          desktop: 160,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.flutter_dash,
                          size: context.responsiveValue(
                            mobile: 80,
                            tablet: 95,
                            desktop: 110,
                          ),
                          color: Colors.white,
                        ),
                      ),

                      // Rotating orbits
                      ...List.generate(4, (index) {
                        return TweenAnimationBuilder<double>(
                          duration: Duration(seconds: 4 + (index * 2)),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.rotate(
                              angle: value * 2 * 3.14159 * (index.isEven ? 1 : -1),
                              child: Container(
                                width: context.responsiveValue(
                                  mobile: 140 + (index * 25),
                                  tablet: 160 + (index * 30),
                                  desktop: 180 + (index * 35),
                                ),
                                height: context.responsiveValue(
                                  mobile: 140 + (index * 25),
                                  tablet: 160 + (index * 30),
                                  desktop: 180 + (index * 35),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF64B5F6).withOpacity(0.2 - (index * 0.04)),
                                    width: 2,
                                  ),
                                ),
                                child: index == 0 ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF64B5F6),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF64B5F6).withOpacity(0.5),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ) : null,
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Enhanced Particle Painter with multiple particle types
class AdvancedParticlePainter extends CustomPainter {
  final double animationValue;

  AdvancedParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(42);

    // Floating particles
    for (int i = 0; i < 100; i++) {
      final x = (random.nextDouble() * size.width + animationValue * 80) % size.width;
      final y = (random.nextDouble() * size.height + animationValue * 40) % size.height;
      final radius = random.nextDouble() * 3 + 1;
      final opacity = random.nextDouble() * 0.6 + 0.2;

      paint.color = const Color(0xFF1E88E5).withOpacity(opacity * 0.3);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Connection lines
    final points = <Offset>[];
    for (int i = 0; i < 50; i++) {
      final x = (random.nextDouble() * size.width + animationValue * 60) % size.width;
      final y = (random.nextDouble() * size.height + animationValue * 30) % size.height;
      points.add(Offset(x, y));
    }

    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final distance = (points[i] - points[j]).distance;
        if (distance < 150) {
          final linePaint = Paint()
            ..color = const Color(0xFF1E88E5).withOpacity(0.1 * (1 - distance / 150))
            ..strokeWidth = 1;
          canvas.drawLine(points[i], points[j], linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Wave background painter
class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 5; i++) {
      final path = Path();
      final amplitude = 30 + (i * 10);
      final frequency = 0.02 + (i * 0.005);
      final phase = animationValue * 2 * math.pi + (i * math.pi / 3);

      path.moveTo(0, size.height / 2);

      for (double x = 0; x <= size.width; x += 5) {
        final y = size.height / 2 + amplitude * math.sin(frequency * x + phase);
        path.lineTo(x, y);
      }

      paint.color = const Color(0xFF1E88E5).withOpacity(0.1 - (i * 0.02));
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Grid overlay painter
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E88E5).withOpacity(0.05)
      ..strokeWidth = 1;

    const spacing = 50.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}