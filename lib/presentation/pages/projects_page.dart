import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/custom_button.dart';
import '../../data/models/project_model.dart';
import '../widgets/projects_view/project_card.dart';
import '../widgets/projects_view/project_filter_chip.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String _selectedCategory = 'All';
  List<Project> _filteredProjects = ProjectData.projects;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _filterProjects(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredProjects = ProjectData.projects;
      } else {
        _filteredProjects = ProjectData.projects
            .where((project) => _getCategoryString(project.category) == category)
            .toList();
      }
    });
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

  ProjectCategory _getCategoryFromString(String category) {
    switch (category) {
      case 'Mobile App':
        return ProjectCategory.mobile;
      case 'Web App':
        return ProjectCategory.web;
      case 'Desktop':
        return ProjectCategory.desktop;
      case 'Game':
        return ProjectCategory.game;
      case 'AI/ML':
        return ProjectCategory.ai;
      default:
        return ProjectCategory.mobile;
    }
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
              _buildFilterSection(),
              _buildProjectsGrid(),
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
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: 1,
            child: Column(
              children: [
                Text(
                  'My Projects',
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
                  'Explore my portfolio of Flutter applications and projects',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        vertical: 24,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Filter by Category',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: ProjectData.categories.map((category) {
                  return ProjectFilterChip(
                    category: _getCategoryFromString(category),
                    isSelected: _selectedCategory == category,
                    onTap: () => _filterProjects(category),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid() {
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
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: _filteredProjects.isEmpty
              ? _buildEmptyState()
              : _buildProjectsList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(
            Icons.folder_outlined,
            size: 64,
            color: context.colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    if (context.isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemCount: _filteredProjects.length,
        itemBuilder: (context, index) {
          return ProjectCard(
            project: _filteredProjects[index],
            onTap: () => _showProjectDetails(_filteredProjects[index]),
          );
        },
      );
    }

    return Column(
      children: _filteredProjects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < _filteredProjects.length - 1 ? 24 : 0,
          ),
          child: ProjectCard(
            project: project,
            onTap: () => _showProjectDetails(project),
          ),
        );
      }).toList(),
    );
  }

  void _showProjectDetails(Project project) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Project details',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: _buildProjectDetailsDialog(project),
        );
      },
    );
  }

  Widget _buildProjectDetailsDialog(Project project) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 40,
          desktop: 80,
        ),
        vertical: 40,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: context.responsiveValue(
            mobile: double.infinity,
            tablet: 600,
            desktop: 800,
          ),
          maxHeight: context.height * 0.8,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getCategoryString(project.category),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: context.colorScheme.onPrimaryContainer,
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.imageUrl != null && project.imageUrl!.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Hero(
                          tag: 'project-image-${project.id}',
                          child: AspectRatio(
                            aspectRatio: 16/9,
                            child: Image.asset(
                              project.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Description
                    Text(
                      'About This Project',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      project.longDescription,
                      style: context.textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Technologies
                    Text(
                      'Technologies Used',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: context.colorScheme.primary.withOpacity(0.2),
                            ),
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

                    if (project.completedDate != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Completed',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${project.completedDate!.month}/${project.completedDate!.year}',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  if (project.githubUrl != null) ...[
                    Expanded(
                      child: CustomButton.outlined(
                        text: 'View Code',
                        icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                        onPressed: () => AppHelpers.launchURL(project.githubUrl!),
                      ),
                    ),
                  ],
                  if (project.demoUrl != null) ...[
                    if (project.githubUrl != null) const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton.filled(
                        text: 'Live Demo',
                        icon: const Icon(Icons.launch),
                        onPressed: () => AppHelpers.launchURL(project.demoUrl!),
                      ),
                    ),
                  ],
                  if (project.githubUrl == null && project.demoUrl == null)
                    Expanded(
                      child: CustomButton.filled(
                        text: 'Close',
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}