import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/custom_button.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: AppConstants.longAnimation,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimations() {
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
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          );
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildHeader(),
          _buildAchievementsSection(),
          _buildCertificationsSection(),
          _buildContactSection(),
        ],
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
        vertical: 32,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primary.withOpacity(0.1),
            context.colorScheme.secondary.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Achievements & Certifications',
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'My professional journey and recognition in the tech industry',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Achievements',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildAchievementCard(
            icon: Icons.school_rounded,
            title: 'Bachelor\'s in Computer Science',
            subtitle: 'Mansoura University • 2021-2025',
            description: 'Successfully completed comprehensive computer science program with focus on software development and algorithms.',
            isCompleted: true,
          ),
          const SizedBox(height: 16),
          _buildAchievementCard(
            icon: Icons.code_rounded,
            title: 'Flutter Developer Trainee',
            subtitle: 'Digital Egypt Pioneers Initiative (DEPI) • Jun 2025-Dec 2025',
            description: 'Selected for prestigious government initiative program focusing on mobile app development with Flutter framework.',
            isCompleted: false,
          ),
          const SizedBox(height: 16),
          _buildAchievementCard(
            icon: Icons.emoji_events_rounded,
            title: 'Mobile App Development Certification',
            subtitle: 'CCIC • 2024',
            description: 'Certified in Mobile App Development with Flutter, demonstrating expertise in cross-platform development.',
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Skills & Expertise',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildSkillChip('Dart', Icons.code_rounded),
              _buildSkillChip('Flutter', Icons.phone_android_rounded),
              _buildSkillChip('Firebase', Icons.local_fire_department_rounded),
              _buildSkillChip('REST APIs', Icons.language_rounded),
              _buildSkillChip('Bloc/Cubit', Icons.layers_rounded),
              _buildSkillChip('MVVM', Icons.account_tree_rounded),
              _buildSkillChip('Clean Architecture', Icons.architecture_rounded),
              _buildSkillChip('Git', Icons.code_rounded),
              _buildSkillChip('OOP', Icons.widgets_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required bool isCompleted,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isCompleted
                    ? context.colorScheme.primary.withOpacity(0.1)
                    : context.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isCompleted
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isCompleted)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Completed',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: context.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 8),
          Text(
            skill,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        vertical: 32,
      ),
      child: Column(
        children: [
          Text(
            'Ready to work together?',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s discuss your next project and how I can help bring your ideas to life.',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Get In Touch',
            onPressed: () => context.go('/contact'),
            icon: Icon(FontAwesomeIcons.envelope),
          ),
        ],
      ),
    );
  }
}
