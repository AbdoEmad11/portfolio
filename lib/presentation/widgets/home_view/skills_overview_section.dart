import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/models/skill_model.dart';

class SkillsOverviewSection extends StatefulWidget {
  const SkillsOverviewSection({super.key});

  @override
  State<SkillsOverviewSection> createState() => _SkillsOverviewSectionState();
}

class _SkillsOverviewSectionState extends State<SkillsOverviewSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _skillAnimations;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    final topSkills = SkillsData.topSkills.take(6).toList();
    _skillAnimations = List.generate(
      topSkills.length,
          (index) => Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          index * 0.15,
          0.6 + (index * 0.15),
          curve: Curves.easeOut,
        ),
      )),
    );

    // Start animation after a delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildSectionHeader(),
              SizedBox(height: context.responsiveValue(
                mobile: 32,
                tablet: 40,
                desktop: 48,
              )),
              _buildSkillsGrid(),
              const SizedBox(height: 32),
              _buildViewAllButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return TweenAnimationBuilder<double>(
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
            'My Skills',
            style: context.textTheme.displaySmall?.copyWith(
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
            'Technologies and tools I work with',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid() {
    final topSkills = SkillsData.topSkills.take(6).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = context.responsiveValue(
          mobile: 2,
          tablet: 3,
          desktop: 3,
          largeDesktop: 4,
        ).round();
        
        final childAspectRatio = context.responsiveValue(
          mobile: 0.85,
          tablet: 0.95,
          desktop: 1.05,
          largeDesktop: 1.1,
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
              largeDesktop: 28,
            ),
            mainAxisSpacing: context.responsiveValue(
              mobile: 16,
              tablet: 20,
              desktop: 24,
              largeDesktop: 28,
            ),
          ),
          itemCount: topSkills.length,
          itemBuilder: (context, index) {
            return _buildSkillCard(topSkills[index], index);
          },
        );
      },
    );
  }

  Widget _buildSkillCard(SkillModel skill, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getSkillColor(skill.category).withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _getSkillColor(skill.category).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Skill icon with modern design
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getSkillColor(skill.category).withOpacity(0.2),
                        _getSkillColor(skill.category).withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getSkillIcon(skill.category),
                      size: 28,
                      color: _getSkillColor(skill.category),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Skill name
                Text(
                  skill.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Skill level with modern badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getSkillColor(skill.category).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getSkillColor(skill.category).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    skill.levelString,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: _getSkillColor(skill.category),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),

                if (skill.description != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    skill.description!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildViewAllButton() {
    return TweenAnimationBuilder<double>(
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
      child: CustomButton.outlined(
        text: 'View All Skills',
        icon: const Icon(Icons.arrow_forward),
        onPressed: () => context.go('/about'),
        size: ButtonSize.large,
      ),
    );
  }

  Color _getSkillColor(SkillCategory category) {
    switch (category) {
      case SkillCategory.programming:
        return const Color(0xFF2196F3);
      case SkillCategory.framework:
        return const Color(0xFF4CAF50);
      case SkillCategory.architecture:
        return const Color(0xFFFF9800);
      case SkillCategory.tools:
        return const Color(0xFF9C27B0);
      case SkillCategory.soft:
        return const Color(0xFFF44336);
      case SkillCategory.database:
        return const Color(0xFF00BCD4);
      case SkillCategory.testing:
        return const Color(0xFF8BC34A);
      case SkillCategory.deployment:
        return const Color(0xFF607D8B);
      default:
        return context.colorScheme.primary;
    }
  }

  IconData _getSkillIcon(SkillCategory category) {
    switch (category) {
      case SkillCategory.programming:
        return Icons.code_rounded;
      case SkillCategory.framework:
        return Icons.extension_rounded;
      case SkillCategory.architecture:
        return Icons.architecture_rounded;
      case SkillCategory.tools:
        return Icons.build_rounded;
      case SkillCategory.soft:
        return Icons.psychology_rounded;
      case SkillCategory.database:
        return Icons.storage_rounded;
      case SkillCategory.testing:
        return Icons.bug_report_rounded;
      case SkillCategory.deployment:
        return Icons.cloud_upload_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
