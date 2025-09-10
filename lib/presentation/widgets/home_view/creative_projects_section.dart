import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/models/project_model.dart';

class CreativeProjectsSection extends StatefulWidget {
  const CreativeProjectsSection({super.key});

  @override
  State<CreativeProjectsSection> createState() => _CreativeProjectsSectionState();
}

class _CreativeProjectsSectionState extends State<CreativeProjectsSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _hoverController;
  late List<Animation<double>> _projectAnimations;
  
  int _hoveredIndex = -1;

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

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    final featuredProjects = ProjectData.projects.where((p) => p.isFeatured).toList();
    _projectAnimations = List.generate(
      featuredProjects.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            0.6 + (index * 0.2),
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
    _hoverController.dispose();
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
            const Color(0xFF0F0F23),
            const Color(0xFF1A1A3E),
            const Color(0xFF0F0F23),
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
                _buildProjectsShowcase(context),
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
          'Featured Creations',
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
          'Where creativity meets functionality',
          style: context.textTheme.titleLarge?.copyWith(
            color: const Color(0xFF00D4FF),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProjectsShowcase(BuildContext context) {
    final featuredProjects = ProjectData.projects.where((p) => p.isFeatured).toList();

    if (context.isDesktop) {
      return _buildDesktopGrid(context, featuredProjects);
    } else {
      return _buildMobileGrid(context, featuredProjects);
    }
  }

  Widget _buildDesktopGrid(BuildContext context, List<Project> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 12),
                child: _buildProjectCard(context, project, index),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildMobileGrid(BuildContext context, List<Project> projects) {
    return Column(
      children: projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < projects.length - 1 ? 30 : 0,
          ),
          child: _buildProjectCard(context, project, index),
        );
      }).toList(),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index) {
    final projectColor = _getProjectColor(index);
    final isHovered = _hoveredIndex == index;

    return AnimatedBuilder(
      animation: _projectAnimations[index],
      builder: (context, child) {
        return Transform.scale(
          scale: _projectAnimations[index].value,
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                _hoveredIndex = index;
              });
              _hoverController.forward();
            },
            onExit: (_) {
              setState(() {
                _hoveredIndex = -1;
              });
              _hoverController.reverse();
            },
            child: AnimatedBuilder(
              animation: _hoverController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, isHovered ? -10 * _hoverController.value : 0),
                  child: Container(
                    height: context.responsiveValue(
                      mobile: 500,
                      tablet: 550,
                      desktop: 600,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1A1A3E).withOpacity(0.8),
                          const Color(0xFF2D1B69).withOpacity(0.6),
                        ],
                      ),
                      border: Border.all(
                        color: projectColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: projectColor.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Background pattern
                          _buildBackgroundPattern(projectColor),
                          
                          // Project image/visual
                          _buildProjectVisual(context, project, projectColor),
                          
                          // Content overlay
                          _buildProjectContent(context, project, projectColor, isHovered),
                          
                          // Hover overlay
                          if (isHovered) _buildHoverOverlay(projectColor),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundPattern(Color color) {
    return Positioned.fill(
      child: CustomPaint(
        painter: PatternPainter(color: color),
      ),
    );
  }

  Widget _buildProjectVisual(BuildContext context, Project project, Color color) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: context.responsiveValue(
        mobile: 200,
        tablet: 220,
        desktop: 250,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.6),
              color.withOpacity(0.4),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Project icon
            Icon(
              _getProjectIcon(project.category),
              size: context.responsiveValue(
                mobile: 60,
                tablet: 70,
                desktop: 80,
              ),
              color: Colors.white.withOpacity(0.9),
            ),
            
            // Floating elements
            ...List.generate(3, (index) {
              return Positioned(
                top: 20 + (index * 30),
                right: 20 + (index * 20),
                child: Container(
                  width: 8 + (index * 2),
                  height: 8 + (index * 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectContent(BuildContext context, Project project, Color color, bool isHovered) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              const Color(0xFF0F0F23).withOpacity(0.9),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              project.title,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              project.description,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 16),
            
            // Technologies
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies.take(3).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: color.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 20),
            
            // Action button
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.8),
                      color.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.push('/project/${project.id}'),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'View Project',
                            style: context.textTheme.bodyMedium?.copyWith(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoverOverlay(Color color) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
        ),
      ),
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
          onTap: () => context.go('/projects'),
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Explore All Projects',
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

  Color _getProjectColor(int index) {
    final colors = [
      const Color(0xFF00D4FF),
      const Color(0xFF0099CC),
      const Color(0xFF0066CC),
      const Color(0xFF00BFFF),
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
}

class PatternPainter extends CustomPainter {
  final Color color;

  PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw diagonal lines
    for (double i = -size.height; i < size.width + size.height; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
