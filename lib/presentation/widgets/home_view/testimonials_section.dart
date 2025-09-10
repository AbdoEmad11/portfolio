import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_button.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 20,
          tablet: 32,
          desktop: 48,
        ),
        vertical: context.responsiveValue(
          mobile: 60,
          tablet: 80,
          desktop: 100,
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
          child: Column(
            children: [
              _buildSectionHeader(context),
              SizedBox(height: context.responsiveValue(
                mobile: 40,
                tablet: 50,
                desktop: 60,
              )),
              _buildAchievementsGrid(context),
              const SizedBox(height: 40),
              _buildViewAllButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Achievements & Recognition',
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
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
        const SizedBox(height: 20),
        Text(
          'Proud moments and professional milestones',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAchievementsGrid(BuildContext context) {
    final achievements = [
      {
        'title': 'Digital Egypt Pioneers Initiative',
        'subtitle': 'Cross-Platform Mobile Development Trainee',
        'description': 'Selected for prestigious government initiative focusing on advanced Flutter development',
        'icon': Icons.emoji_events_rounded,
        'color': const Color(0xFFFFD700),
        'period': '2025',
        'type': 'Program',
      },
      {
        'title': 'Computer Science Degree',
        'subtitle': 'Mansoura University',
        'description': 'Pursuing Bachelor\'s degree with focus on software engineering and mobile development',
        'icon': Icons.school_rounded,
        'color': const Color(0xFF2196F3),
        'period': '2021-2025',
        'type': 'Education',
      },
      {
        'title': 'Flutter Expertise',
        'subtitle': 'Cross-Platform Development',
        'description': 'Specialized in building high-performance mobile and web applications using Flutter',
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF03DAC6),
        'period': '2+ Years',
        'type': 'Experience',
      },
      {
        'title': 'Project Portfolio',
        'subtitle': '10+ Completed Projects',
        'description': 'Successfully delivered multiple mobile and web applications across various domains',
        'icon': Icons.work_rounded,
        'color': const Color(0xFF4CAF50),
        'period': 'Ongoing',
        'type': 'Projects',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = context.responsiveValue(
          mobile: 1,
          tablet: 2,
          desktop: 2,
          largeDesktop: 4,
        ).round();
        
        final childAspectRatio = context.responsiveValue(
          mobile: 1.3,
          tablet: 1.2,
          desktop: 1.1,
          largeDesktop: 1.0,
        );

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: context.responsiveValue(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
            mainAxisSpacing: context.responsiveValue(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            return _buildAchievementCard(context, achievements[index], index);
          },
        );
      },
    );
  }

  Widget _buildAchievementCard(BuildContext context, Map<String, dynamic> achievement, int index) {
    final color = achievement['color'] as Color;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and type
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.2),
                      color.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  achievement['icon'] as IconData,
                  color: color,
                  size: 24,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: color.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  achievement['type'] as String,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Title
          Text(
            achievement['title'] as String,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Subtitle
          Text(
            achievement['subtitle'] as String,
            style: context.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Description
          Expanded(
            child: Text(
              achievement['description'] as String,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Period
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: context.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                achievement['period'] as String,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return CustomButton.outlined(
      text: 'View All Achievements',
      icon: const Icon(Icons.star_outline_rounded),
      onPressed: () => context.go('/achievements'),
      size: ButtonSize.large,
    );
  }
}
