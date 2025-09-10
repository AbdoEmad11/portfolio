import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';
import '../../../data/models/project_model.dart';

class ProjectFilterChip extends StatelessWidget {
  final ProjectCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const ProjectFilterChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(_getCategoryName(category)),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: context.colorScheme.primaryContainer,
      checkmarkColor: context.colorScheme.onPrimaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? context.colorScheme.onPrimaryContainer
            : context.colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      side: BorderSide(
        color: isSelected
            ? context.colorScheme.primary
            : context.colorScheme.outline.withOpacity(0.3),
      ),
    );
  }

  String _getCategoryName(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return 'Mobile';
      case ProjectCategory.web:
        return 'Web';
      case ProjectCategory.desktop:
        return 'Desktop';
      case ProjectCategory.game:
        return 'Game';
      case ProjectCategory.ai:
        return 'AI/ML';
    }
  }
}
