import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/extensions.dart';
import '../../../data/models/experience_model.dart';

class TimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;
  final bool isFirst;

  const TimelineItem({
    super.key,
    required this.experience,
    this.isLast = false,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimelineIndicator(context),
        const SizedBox(width: 16),
        Expanded(
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildTimelineIndicator(BuildContext context) {
    return Column(
      children: [
        if (!isFirst) ...[
          Container(
            width: 2,
            height: 20,
            color: context.colorScheme.outline.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.primary,
            border: Border.all(
              color: context.colorScheme.surface,
              width: 3,
            ),
          ),
        ),
        if (!isLast) ...[
          const SizedBox(height: 8),
          Container(
            width: 2,
            height: 20,
            color: context.colorScheme.outline.withOpacity(0.3),
          ),
        ],
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconForType(experience.type),
                    size: 20,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        experience.company,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    experience.duration,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (experience.description.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                experience.description,
                style: context.textTheme.bodyMedium,
              ),
            ],
            if (experience.skills.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: experience.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      skill,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(ExperienceType type) {
    switch (type) {
      case ExperienceType.education:
        return Icons.school_rounded;
      case ExperienceType.work:
        return Icons.work_rounded;
      case ExperienceType.certification:
        return Icons.verified_rounded;
      case ExperienceType.project:
        return Icons.code_rounded;
      case ExperienceType.course:
        return Icons.menu_book_rounded;
    }
  }
}
