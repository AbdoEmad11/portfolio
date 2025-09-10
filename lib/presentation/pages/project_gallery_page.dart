import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/extensions.dart';
import '../../data/models/project_model.dart';

class ProjectGalleryPage extends StatefulWidget {
  final String projectId;

  const ProjectGalleryPage({super.key, required this.projectId});

  @override
  State<ProjectGalleryPage> createState() => _ProjectGalleryPageState();
}

class _ProjectGalleryPageState extends State<ProjectGalleryPage> {
  late final Project project;
  late final PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    project = ProjectData.projects.firstWhere((p) => p.id == widget.projectId);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goPrev(int total) {
    if (currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  void _goNext(int total) {
    if (currentIndex < total - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = project.galleryImages.isNotEmpty
        ? project.galleryImages
        : [if (project.imageUrl != null) project.imageUrl!];

    final aspect = context.isDesktop
        ? 16 / 9
        : (context.isTablet ? 4 / 3 : 3 / 2);

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          DismissIntent: CallbackAction<DismissIntent>(onInvoke: (intent) {
            Navigator.of(context).maybePop();
            return null;
          }),
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(project.title),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).maybePop(),
              tooltip: 'Back',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Close',
              ),
            ],
          ),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveValue(mobile: 16, tablet: 24, desktop: 32),
                vertical: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  // Main gallery viewer with arrows and zoom
                  AspectRatio(
                    aspectRatio: aspect,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: 'project-image-${project.id}',
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (i) => setState(() => currentIndex = i),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  switchInCurve: Curves.easeOutCubic,
                                  switchOutCurve: Curves.easeInCubic,
                                  child: InteractiveViewer(
                                    key: ValueKey<int>(index),
                                    minScale: 1,
                                    maxScale: 4,
                                    boundaryMargin: const EdgeInsets.all(40),
                                    child: Image.asset(
                                      images[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Left arrow
                          Positioned(
                            left: 8,
                            top: 0,
                            bottom: 0,
                            child: _NavButton(
                              onTap: () => _goPrev(images.length),
                              icon: Icons.chevron_left,
                              enabled: currentIndex > 0,
                            ),
                          ),
                          // Right arrow
                          Positioned(
                            right: 8,
                            top: 0,
                            bottom: 0,
                            child: _NavButton(
                              onTap: () => _goNext(images.length),
                              icon: Icons.chevron_right,
                              enabled: currentIndex < images.length - 1,
                            ),
                          ),

                          // Page indicator
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${currentIndex + 1} / ${images.length}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Thumbnails grid/list responsive
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 800;
                      if (isWide) {
                        // grid thumbnails on wide screens
                        final thumbHeight = 100.0;
                        final crossAxisCount = (constraints.maxWidth / 180).floor().clamp(4, 8);
                        return SizedBox(
                          height: thumbHeight + 8,
                          child: GridView.builder(
                            primary: false,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 170,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              final selected = index == currentIndex;
                              return _Thumb(
                                imagePath: images[index],
                                selected: selected,
                                onTap: () {
                                  setState(() => currentIndex = index);
                                  _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
                                },
                              );
                            },
                          ),
                        );
                      }
                      // mobile: horizontal list
                      return SizedBox(
                        height: 90,
                        child: ListView.separated(
                          primary: false,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final selected = index == currentIndex;
                            return _Thumb(
                              imagePath: images[index],
                              selected: selected,
                              onTap: () {
                                setState(() => currentIndex = index);
                                _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Brief details
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      project.title,
                      style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      project.description,
                      style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class _NavButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool enabled;

  const _NavButton({required this.onTap, required this.icon, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(enabled ? 0.35 : 0.15),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  const _Thumb({required this.imagePath, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 160,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? context.colorScheme.primary : context.colorScheme.outline.withOpacity(0.3),
            width: selected ? 2 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}


