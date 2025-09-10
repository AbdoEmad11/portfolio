import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/models/skill_model.dart';

class CreativeSkillsSection extends StatefulWidget {
  const CreativeSkillsSection({super.key});

  @override
  State<CreativeSkillsSection> createState() => _CreativeSkillsSectionState();
}

class _CreativeSkillsSectionState extends State<CreativeSkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _rotationController;
  late List<Animation<double>> _skillAnimations;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    final topSkills = SkillsData.topSkills.take(8).toList();
    _skillAnimations = List.generate(
      topSkills.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.1,
            0.5 + (index * 0.1),
            curve: Curves.easeOutBack,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1A3E),
            const Color(0xFF2D1B69),
            const Color(0xFF1A1A3E),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(
            mobile: 20,
            tablet: 32,
            desktop: 48,
          ),
          vertical: context.responsiveValue(
            mobile: 80,
            tablet: 100,
            desktop: 120,
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
                  mobile: 50,
                  tablet: 60,
                  desktop: 80,
                )),
                _buildSkillsShowcase(context),
                const SizedBox(height: 50),
                _buildViewAllButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Technical Arsenal',
          style: context.textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Tools and technologies that power my creations',
          style: context.textTheme.titleLarge?.copyWith(
            color: const Color(0xFF00D4FF),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSkillsShowcase(BuildContext context) {
    final topSkills = SkillsData.topSkills.take(8).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (context.isDesktop) {
          return _buildDesktopLayout(context, topSkills);
        } else {
          return _buildMobileLayout(context, topSkills);
        }
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, List<SkillModel> skills) {
    return Row(
      children: [
        // Left side - Main skills
        Expanded(
          flex: 2,
          child: _buildMainSkillsGrid(context, skills.take(4).toList()),
        ),
        
        SizedBox(width: context.responsiveValue(
          mobile: 32,
          tablet: 48,
          desktop: 64,
        )),
        
        // Right side - Additional skills and visual
        Expanded(
          child: Column(
            children: [
              _buildAdditionalSkills(context, skills.skip(4).toList()),
              const SizedBox(height: 40),
              _buildSkillsVisual(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<SkillModel> skills) {
    return Column(
      children: [
        _buildMainSkillsGrid(context, skills.take(4).toList()),
        const SizedBox(height: 40),
        _buildAdditionalSkills(context, skills.skip(4).toList()),
        const SizedBox(height: 40),
        _buildSkillsVisual(context),
      ],
    );
  }

  Widget _buildMainSkillsGrid(BuildContext context, List<SkillModel> skills) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return _buildMainSkillCard(context, skills[index], index);
      },
    );
  }

  Widget _buildMainSkillCard(BuildContext context, SkillModel skill, int index) {
    final color = _getSkillColor(skill.category);
    
    return AnimatedBuilder(
      animation: _skillAnimations[index],
      builder: (context, child) {
        return Transform.scale(
          scale: _skillAnimations[index].value,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A1A3E).withOpacity(0.8),
                  const Color(0xFF2D1B69).withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Skill icon with glow effect
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.3),
                        color.withOpacity(0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    _getSkillIcon(skill.category),
                    size: 28,
                    color: color,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Skill name
                Text(
                  skill.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // Skill level
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: color.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    skill.levelString,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdditionalSkills(BuildContext context, List<SkillModel> skills) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A3E).withOpacity(0.8),
            const Color(0xFF2D1B69).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D4FF).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Skills',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              final color = _getSkillColor(skill.category);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.2),
                      color.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: color.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  skill.name,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsVisual(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Container(
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer rotating ring
              Transform.rotate(
                angle: _rotationController.value * 2 * 3.14159,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00D4FF).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
              
              // Middle ring
              Transform.rotate(
                angle: -_rotationController.value * 2 * 3.14159,
                child: Container(
                  width: context.responsiveValue(
                    mobile: 150,
                    tablet: 180,
                    desktop: 220,
                  ),
                  height: context.responsiveValue(
                    mobile: 150,
                    tablet: 180,
                    desktop: 220,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF0099CC).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
              
              // Inner circle
              Container(
                width: context.responsiveValue(
                  mobile: 100,
                  tablet: 120,
                  desktop: 140,
                ),
                height: context.responsiveValue(
                  mobile: 100,
                  tablet: 120,
                  desktop: 140,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF00D4FF),
                      Color(0xFF0099CC),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.code_rounded,
                  size: context.responsiveValue(
                    mobile: 40,
                    tablet: 50,
                    desktop: 60,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go('/about'),
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'View All Skills',
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
  }

  Color _getSkillColor(SkillCategory category) {
    switch (category) {
      case SkillCategory.programming:
        return const Color(0xFF00D4FF);
      case SkillCategory.framework:
        return const Color(0xFF0099CC);
      case SkillCategory.architecture:
        return const Color(0xFF0066CC);
      case SkillCategory.tools:
        return const Color(0xFF00BFFF);
      case SkillCategory.soft:
        return const Color(0xFF00D4FF);
      case SkillCategory.database:
        return const Color(0xFF0099CC);
      case SkillCategory.testing:
        return const Color(0xFF0066CC);
      case SkillCategory.deployment:
        return const Color(0xFF00BFFF);
      default:
        return const Color(0xFF00D4FF);
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
