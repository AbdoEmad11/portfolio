import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/experience_model.dart';
import '../widgets/journey_view/timeline_item.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: AppConstants.longAnimation,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildTimeline(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        vertical: context.responsiveValue(
          mobile: 32,
          tablet: 48,
          desktop: 64,
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primary.withOpacity(0.1),
            context.colorScheme.secondary.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
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
                child: Column(
                  children: [
                    Text(
                      'My Journey',
                      style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colorScheme.primary,
                            context.colorScheme.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'The path that led me to become a Flutter Developer',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              ...ExperienceData.timelineExperiences.asMap().entries.map((entry) {
                final index = entry.key;
                final experience = entry.value;
                return TimelineItem(
                  experience: experience,
                  isLast: index == ExperienceData.timelineExperiences.length - 1,
                  isFirst: index == 0,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}