import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/models/project_model.dart';

class FeaturedProjectsSection extends StatefulWidget {
  const FeaturedProjectsSection({super.key});

  @override
  State<FeaturedProjectsSection> createState() => _FeaturedProjectsSectionState();
}

class _FeaturedProjectsSectionState extends State<FeaturedProjectsSection> {

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
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.3),
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
              _buildProjectsGrid(),
              const SizedBox(height: 32),
              _buildViewAllButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'Featured Projects',
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
          'Some of my latest work that I\'m proud of',
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProjectsGrid() {
    final featuredProjects = ProjectData.projects.where((p) => p.isFeatured).toList();

    if (context.isDesktop) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: featuredProjects.asMap().entries.map((entry) {
              final index = entry.key;
              final project = entry.value;
              return Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: index == 0 ? 0 : 8,
                  ).copyWith(
                    left: index == 0 ? 0 : 8,
                    right: index == featuredProjects.length - 1 ? 0 : 8,
                  ),
                  child: _buildProjectCard(project, index),
                ),
              );
            }).toList(),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: featuredProjects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < featuredProjects.length - 1 ? 24 : 0,
              ),
              child: _buildProjectCard(project, index),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    final projectColor = _getProjectColor(index);
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: projectColor.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: projectColor.withOpacity(0.1),
            blurRadius: 25,
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
          // Project image or colorful placeholder
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: (project.imageUrl?.isNotEmpty ?? false)
                  ? Image.asset(
                      project.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            projectColor.withOpacity(0.9),
                            projectColor.withOpacity(0.7),
                            projectColor.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getProjectIcon(project.category),
                              size: 48,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getCategoryString(project.category),
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
          ),

          // Project content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  project.title,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  project.description,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                // Technologies
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.take(4).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            projectColor.withOpacity(0.15),
                            projectColor.withOpacity(0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: projectColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tech,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: projectColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (project.technologies.length > 4) ...[
                  const SizedBox(height: 8),
                  Text(
                    '+${project.technologies.length - 4} more',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                // Action buttons
                Row(
                  children: [
                    Flexible(
                      child: CustomButton.filled(
                        text: 'View Details',
                        icon: const Icon(Icons.visibility),
                        onPressed: () => context.push('/project/${project.id}'),
                        size: ButtonSize.medium,
                      ),
                    ),
                    if (project.githubUrl != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              projectColor.withOpacity(0.1),
                              projectColor.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: projectColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => AppHelpers.launchURL(project.githubUrl!),
                          icon: FaIcon(
                            FontAwesomeIcons.github,
                            color: projectColor,
                            size: 18,
                          ),
                          tooltip: 'View on GitHub',
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllButton() {
    return CustomButton.outlined(
      text: 'View All Projects',
      icon: const Icon(Icons.arrow_forward),
      onPressed: () => context.go('/projects'),
      size: ButtonSize.large,
    );
  }

  Color _getProjectColor(int index) {
    final colors = [
      const Color(0xFF2196F3),
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
      const Color(0xFF9C27B0),
    ];
    return colors[index % colors.length];
  }

  IconData _getProjectIcon(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return Icons.phone_android_rounded;
      case ProjectCategory.web:
        return Icons.language_rounded;
      case ProjectCategory.desktop:
        return Icons.desktop_windows_rounded;
      case ProjectCategory.game:
        return Icons.sports_esports_rounded;
      case ProjectCategory.ai:
        return Icons.psychology_rounded;
    }
  }

  String _getCategoryString(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return 'Mobile App';
      case ProjectCategory.web:
        return 'Web App';
      case ProjectCategory.desktop:
        return 'Desktop';
      case ProjectCategory.game:
        return 'Game';
      case ProjectCategory.ai:
        return 'AI/ML';
    }
  }
}