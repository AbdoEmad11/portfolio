import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/skill_model.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _fadeController = AnimationController(
      duration: AppConstants.mediumAnimation,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          );
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(),
          _buildContentSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: context.isDesktop
              ? _buildDesktopHero()
              : _buildMobileHero(),
        ),
      ),
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildHeroContent(),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _buildHeroImage(),
        ),
      ],
    );
  }

  Widget _buildMobileHero() {
    return Column(
      children: [
        _buildHeroImage(),
        const SizedBox(height: 32),
        _buildHeroContent(),
      ],
    );
  }

  Widget _buildHeroContent() {
    return Column(
      crossAxisAlignment: context.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          'About Me',
          style: context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        ),

        const SizedBox(height: 16),

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

        const SizedBox(height: 24),

        Text(
          AppConstants.summary,
          style: context.textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        ),

        const SizedBox(height: 24),

        _buildPersonalInfo(),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Center(
      child: Container(
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.primary,
              context.colorScheme.secondary,
              context.colorScheme.tertiary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'AE',
            style: TextStyle(
              fontSize: context.responsiveValue(
                mobile: 48,
                tablet: 60,
                desktop: 72,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    final info = [
      {'icon': Icons.person, 'label': 'Name', 'value': AppConstants.name},
      {'icon': Icons.location_on, 'label': 'Location', 'value': 'Egypt'},
      {'icon': Icons.email, 'label': 'Email', 'value': AppConstants.email},
      {'icon': Icons.phone, 'label': 'Phone', 'value': AppConstants.phone},
    ];

    return Column(
      crossAxisAlignment: context.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: info.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisSize: context.isDesktop
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              Icon(
                item['icon'] as IconData,
                size: 20,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                '${item['label']}: ',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Flexible(
                child: Text(
                  item['value'] as String,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContentSection() {
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildTabBar(),
              const SizedBox(height: 32),
              _buildTabContent(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: context.colorScheme.onPrimary,
        unselectedLabelColor: context.colorScheme.onSurfaceVariant,
        indicator: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Skills'),
          Tab(text: 'Languages'),
          Tab(text: 'Interests'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height: 400,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildSkillsTab(),
          _buildLanguagesTab(),
          _buildInterestsTab(),
        ],
      ),
    );
  }

  Widget _buildSkillsTab() {
    final skillsByCategory = <SkillCategory, List<SkillModel>>{};
    for (final skill in SkillsData.skills) {
      skillsByCategory.putIfAbsent(skill.category, () => []).add(skill);
    }

    return SingleChildScrollView(
      child: Column(
        children: skillsByCategory.entries.map((entry) {
          return _buildSkillCategory(entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Widget _buildSkillCategory(SkillCategory category, List<SkillModel> skills) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skills.first.categoryString,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) {
              return _buildSkillChip(skill);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(SkillModel skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getSkillColor(skill.category).withOpacity(0.15),
            _getSkillColor(skill.category).withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: _getSkillColor(skill.category).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _getSkillColor(skill.category).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getSkillIcon(skill.category),
            size: 16,
            color: _getSkillColor(skill.category),
          ),
          const SizedBox(width: 8),
          Text(
            skill.name,
            style: context.textTheme.bodyMedium?.copyWith(
              color: _getSkillColor(skill.category),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getSkillColor(skill.category).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              skill.levelString,
              style: context.textTheme.bodySmall?.copyWith(
                color: _getSkillColor(skill.category),
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagesTab() {
    final languages = [
      {'name': 'Arabic', 'level': 'Native', 'flag': '🇪🇬', 'color': const Color(0xFF4CAF50)},
      {'name': 'English', 'level': 'Professional Working Proficiency', 'flag': '🇺🇸', 'color': const Color(0xFF2196F3)},
    ];

    return Column(
      children: languages.map((lang) {
        final color = lang['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.2),
                      color.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Text(
                  lang['flag'] as String,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang['name'] as String,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lang['level'] as String,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInterestsTab() {
    final interests = [
      {'name': 'Mobile Development', 'icon': Icons.phone_android, 'color': const Color(0xFF2196F3)},
      {'name': 'UI/UX Design', 'icon': Icons.design_services, 'color': const Color(0xFF4CAF50)},
      {'name': 'Technology Trends', 'icon': Icons.trending_up, 'color': const Color(0xFFFF9800)},
      {'name': 'Problem Solving', 'icon': Icons.psychology, 'color': const Color(0xFF9C27B0)},
      {'name': 'Learning', 'icon': Icons.school, 'color': const Color(0xFF00BCD4)},
      {'name': 'Team Collaboration', 'icon': Icons.groups, 'color': const Color(0xFF8BC34A)},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = context.responsiveValue(
          mobile: 2,
          tablet: 3,
          desktop: 3,
        ).round();
        final childAspectRatio = context.responsiveValue(
          mobile: 1.2,
          tablet: 1.3,
          desktop: 1.4,
        );

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: interests.length,
          itemBuilder: (context, index) {
            final interest = interests[index];
            final color = interest['color'] as Color;
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.1),
                    color.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.2),
                          color.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Icon(
                      interest['icon'] as IconData,
                      size: 28,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    interest['name'] as String,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        );
      },
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