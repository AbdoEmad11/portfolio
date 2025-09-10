import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/custom_button.dart';

class ContactCTASection extends StatefulWidget {
  const ContactCTASection({super.key});

  @override
  State<ContactCTASection> createState() => _ContactCTASectionState();
}

class _ContactCTASectionState extends State<ContactCTASection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: TweenAnimationBuilder<double>(
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
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.all(context.responsiveValue(
                  mobile: 32,
                  tablet: 40,
                  desktop: 48,
                )),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colorScheme.primary,
                      context.colorScheme.secondary,
                      context.colorScheme.tertiary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Ready to Start a Project?',
                      style: context.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Description
                    Text(
                      'Let\'s work together to bring your ideas to life. I\'m always excited to take on new challenges and create amazing mobile experiences.',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Action buttons
                    context.isMobile
                        ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Get In Touch',
                            icon: const Icon(Icons.contact_mail),
                            onPressed: () => context.go('/contact'),
                            size: ButtonSize.large,
                            backgroundColor: Colors.white,
                            foregroundColor: context.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton.outlined(
                            text: 'Download CV',
                            icon: const FaIcon(FontAwesomeIcons.download, size: 16),
                            onPressed: _downloadCV,
                            size: ButtonSize.large,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: 'Get In Touch',
                          icon: const Icon(Icons.contact_mail),
                          onPressed: () => context.go('/contact'),
                          size: ButtonSize.large,
                          backgroundColor: Colors.white,
                          foregroundColor: context.colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        CustomButton.outlined(
                          text: 'Download CV',
                          icon: const FaIcon(FontAwesomeIcons.download, size: 16),
                          onPressed: _downloadCV,
                          size: ButtonSize.large,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _downloadCV() {
    // In a real app, this would download the CV
    AppHelpers.showSnackBar(
      context,
      'CV download feature would be implemented here',
      backgroundColor: context.colorScheme.primary,
    );
  }
}