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
  late AnimationController _backgroundController;
  late AnimationController _floatingController;
  late AnimationController _textController;
  late AnimationController _particleController;

  late Animation<double> _backgroundAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Background gradient animation
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    // Floating elements animation
    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -20.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Text entrance animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutBack,
    ));

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_particleController);
  }

  void _startAnimations() {
    _textController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _floatingController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Animated background
          _buildAnimatedBackground(),
          
          // Floating particles
          _buildFloatingParticles(),
          
          // Main content
          _buildMainContent(),
          
          // Floating code elements
          _buildFloatingCodeElements(),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF0F0F23),
                  const Color(0xFF1A1A3E),
                  _backgroundAnimation.value,
                )!,
                Color.lerp(
                  const Color(0xFF1A1A3E),
                  const Color(0xFF2D1B69),
                  _backgroundAnimation.value,
                )!,
                Color.lerp(
                  const Color(0xFF2D1B69),
                  const Color(0xFF0F0F23),
                  _backgroundAnimation.value,
                )!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: GridPainter(
              animation: _backgroundAnimation,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingParticles() {
    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            animation: _particleAnimation,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(
            mobile: 20,
            tablet: 32,
            desktop: 48,
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
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Content
        Expanded(
          flex: 3,
          child: _buildContent(),
        ),
        
        SizedBox(width: context.responsiveValue(
          mobile: 32,
          tablet: 48,
          desktop: 64,
        )),
        
        // Right side - Creative Visual
        Expanded(
          flex: 2,
          child: _buildCreativeVisual(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCreativeVisual(),
        SizedBox(height: context.responsiveValue(
          mobile: 40,
          tablet: 50,
        )),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _textAnimation.value)),
          child: Opacity(
            opacity: _textAnimation.value,
            child: Column(
              crossAxisAlignment: context.isDesktop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Creative greeting
                _buildCreativeGreeting(),
                
                const SizedBox(height: 24),
                
                // Main heading with typewriter effect
                _buildMainHeading(),
                
                const SizedBox(height: 20),
                
                // Animated subtitle
                _buildAnimatedSubtitle(),
                
                const SizedBox(height: 32),
                
                // Description with fade-in
                _buildDescription(),
                
                const SizedBox(height: 40),
                
                // Interactive skill tags
                _buildInteractiveSkills(),
                
                const SizedBox(height: 40),
                
                // Action buttons with hover effects
                _buildActionButtons(),
                
                const SizedBox(height: 32),
                
                // Social links with animations
                _buildAnimatedSocialLinks(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreativeGreeting() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00D4FF).withOpacity(0.2),
            const Color(0xFF0099CC).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFF00D4FF).withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: const Color(0xFF00D4FF),
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            'Creative Flutter Developer',
            style: context.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF00D4FF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainHeading() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Hello, I'm ",
            style: context.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          TextSpan(
            text: AppConstants.name.split(' ').first,
            style: context.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              background: Paint()
                ..shader = const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
    );
  }

  Widget _buildAnimatedSubtitle() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value * 0.5),
          child: Text(
            'Building the Future with Flutter',
            style: context.textTheme.headlineMedium?.copyWith(
              color: const Color(0xFF00D4FF),
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _buildDescription() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Text(
        'I craft exceptional digital experiences using Flutter. From mobile apps to web platforms, I bring ideas to life with clean code, beautiful designs, and cutting-edge technology.',
        style: context.textTheme.bodyLarge?.copyWith(
          color: Colors.white.withOpacity(0.8),
          height: 1.6,
        ),
        textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
      ),
    );
  }

  Widget _buildInteractiveSkills() {
    final skills = ['Flutter', 'Dart', 'Firebase', 'Clean Architecture', 'UI/UX'];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 800 + (index * 200)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00D4FF).withOpacity(0.2),
                      const Color(0xFF0099CC).withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF00D4FF).withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  skill,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF00D4FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 20,
      runSpacing: 16,
      alignment: context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        _buildAnimatedButton(
          text: 'Explore My Work',
          icon: Icons.rocket_launch_rounded,
          onPressed: () => context.go('/projects'),
          isPrimary: true,
        ),
        _buildAnimatedButton(
          text: 'Let\'s Connect',
          icon: Icons.chat_rounded,
          onPressed: () => context.go('/contact'),
          isPrimary: false,
        ),
      ],
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatingAnimation.value * 0.3),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isPrimary
                        ? const LinearGradient(
                            colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(30),
                    border: isPrimary
                        ? null
                        : Border.all(
                            color: const Color(0xFF00D4FF).withOpacity(0.5),
                            width: 2,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: (isPrimary ? const Color(0xFF00D4FF) : const Color(0xFF00D4FF))
                            .withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onPressed,
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              color: isPrimary ? Colors.white : const Color(0xFF00D4FF),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              text,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: isPrimary ? Colors.white : const Color(0xFF00D4FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAnimatedSocialLinks() {
    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'action': () => AppHelpers.launchURL(AppConstants.github),
        'color': const Color(0xFF00D4FF),
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'action': () => AppHelpers.launchURL(AppConstants.linkedIn),
        'color': const Color(0xFF0099CC),
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'action': () => AppHelpers.launchEmail(AppConstants.email),
        'color': const Color(0xFF00D4FF),
      },
    ];

    return Row(
      mainAxisAlignment: context.isDesktop
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: socialLinks.asMap().entries.map((entry) {
        final index = entry.key;
        final social = entry.value;
        
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 1200 + (index * 200)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        (social['color'] as Color).withOpacity(0.2),
                        (social['color'] as Color).withOpacity(0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (social['color'] as Color).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: social['action'] as VoidCallback,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: FaIcon(
                          social['icon'] as IconData,
                          size: 22,
                          color: social['color'] as Color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCreativeVisual() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Container(
            width: context.responsiveValue(
              mobile: 300,
              tablet: 350,
              desktop: 400,
            ),
            height: context.responsiveValue(
              mobile: 300,
              tablet: 350,
              desktop: 400,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF00D4FF).withOpacity(0.3),
                        const Color(0xFF0099CC).withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                
                // Main circle
                Container(
                  width: context.responsiveValue(
                    mobile: 200,
                    tablet: 250,
                    desktop: 300,
                  ),
                  height: context.responsiveValue(
                    mobile: 200,
                    tablet: 250,
                    desktop: 300,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF00D4FF),
                        Color(0xFF0099CC),
                        Color(0xFF0066CC),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withOpacity(0.5),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Flutter logo
                      Icon(
                        Icons.flutter_dash,
                        size: context.responsiveValue(
                          mobile: 80,
                          tablet: 100,
                          desktop: 120,
                        ),
                        color: Colors.white,
                      ),
                      
                      // Rotating rings
                      ...List.generate(3, (index) {
                        return TweenAnimationBuilder<double>(
                          duration: Duration(seconds: 8 + index * 2),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.rotate(
                              angle: value * 2 * 3.14159,
                              child: Container(
                                width: context.responsiveValue(
                                  mobile: 120 + (index * 30),
                                  tablet: 150 + (index * 40),
                                  desktop: 180 + (index * 50),
                                ),
                                height: context.responsiveValue(
                                  mobile: 120 + (index * 30),
                                  tablet: 150 + (index * 40),
                                  desktop: 180 + (index * 50),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2 - (index * 0.05)),
                                    width: 2,
                                  ),
                                ),
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

  Widget _buildFloatingCodeElements() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _particleAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: CodeElementPainter(
              animation: _particleAnimation,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

// Custom painters for visual effects
class GridPainter extends CustomPainter {
  final Animation<double> animation;

  GridPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withOpacity(0.1)
      ..strokeWidth = 1;

    final spacing = 50.0;
    final offset = animation.value * spacing;

    // Draw grid lines
    for (double x = -offset; x < size.width + spacing; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    for (double y = -offset; y < size.height + spacing; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticlePainter extends CustomPainter {
  final Animation<double> animation;

  ParticlePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withOpacity(0.6);

    // Draw floating particles
    for (int i = 0; i < 20; i++) {
      final x = (i * 100.0 + animation.value * 50) % size.width;
      final y = (i * 80.0 + animation.value * 30) % size.height;
      final radius = 2.0 + (i % 3);

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CodeElementPainter extends CustomPainter {
  final Animation<double> animation;

  CodeElementPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final codeElements = ['<Flutter>', 'Dart', 'Widget', 'State', 'Build'];
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withOpacity(0.3);

    for (int i = 0; i < codeElements.length; i++) {
      final x = (i * 200.0 + animation.value * 100) % size.width;
      final y = (i * 150.0 + animation.value * 80) % size.height;

      textPainter.text = TextSpan(
        text: codeElements[i],
        style: TextStyle(
          color: const Color(0xFF00D4FF).withOpacity(0.3),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x, y),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}