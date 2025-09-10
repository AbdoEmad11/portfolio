import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            _buildContent(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final hasImage = (project.imageUrl?.isNotEmpty ?? false);
    final imageWidget = hasImage
        ? ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Hero(
              tag: 'project-image-${project.id}',
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    project.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                  // Soft gradient overlay for better text/icon contrast if needed later
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.08),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colorScheme.primary.withOpacity(0.1),
                  context.colorScheme.secondary.withOpacity(0.1),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                _getIconForCategory(project.category),
                size: 64,
                color: context.colorScheme.primary,
              ),
            ),
          );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: SizedBox(
        key: ValueKey<bool>(hasImage),
        height: 200,
        width: double.infinity,
        child: imageWidget,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(project.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  project.status.name.toUpperCase(),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(project.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            project.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies.take(3).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tech,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          if (project.githubUrl?.isNotEmpty == true) ...[
            _buildActionButton(
              context,
              icon: FontAwesomeIcons.github,
              label: 'Code',
              onTap: () => AppHelpers.launchURL(project.githubUrl!),
            ),
            const SizedBox(width: 8),
          ],
          if (project.demoUrl?.isNotEmpty == true) ...[
            _buildActionButton(
              context,
              icon: FontAwesomeIcons.upRightFromSquare,
              label: 'Demo',
              onTap: () => AppHelpers.launchURL(project.demoUrl!),
            ),
            const SizedBox(width: 8),
          ],
          const Spacer(),
          Text(
            project.date,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(ProjectCategory category) {
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

  Color _getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.inProgress:
        return Colors.orange;
      case ProjectStatus.planned:
        return Colors.blue;
    }
  }
}
