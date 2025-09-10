import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  final List<StatItem> _stats = [
    StatItem(
      title: 'Projects Completed',
      value: '10+',
      icon: Icons.work_rounded,
      color: const Color(0xFF2196F3),
    ),
    StatItem(
      title: 'Years Experience',
      value: '2+',
      icon: Icons.schedule_rounded,
      color: const Color(0xFF4CAF50),
    ),
    StatItem(
      title: 'Technologies',
      value: '15+',
      icon: Icons.code_rounded,
      color: const Color(0xFFFF9800),
    ),
    StatItem(
      title: 'Happy Clients',
      value: '5+',
      icon: Icons.people_rounded,
      color: const Color(0xFF9C27B0),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controllers = List.generate(
      _stats.length,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    // Start animations with staggered delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
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
          child: context.isDesktop
              ? _buildDesktopLayout()
              : _buildMobileLayout(),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: _stats.asMap().entries.map((entry) {
        final index = entry.key;
        final stat = entry.value;
        return Expanded(
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.scale(
                scale: _animations[index].value,
                child: _buildStatCard(stat, index),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = context.isTablet ? 4 : 2;
        final childAspectRatio = context.isTablet ? 1.3 : 1.1;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _stats.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.scale(
                  scale: _animations[index].value,
                  child: _buildStatCard(_stats[index], index),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard(StatItem stat, int index) {
    return Container(
      margin: context.isDesktop
          ? const EdgeInsets.symmetric(horizontal: 8)
          : EdgeInsets.zero,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            stat.color.withOpacity(0.15),
            stat.color.withOpacity(0.08),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: stat.color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: stat.color.withOpacity(0.2),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with animated background
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 1000 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        stat.color.withOpacity(0.3),
                        stat.color.withOpacity(0.2),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: stat.color.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    stat.icon,
                    size: 32,
                    color: stat.color,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Animated value
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 1200 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    stat.value,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: stat.color,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // Title
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 1400 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 10 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    stat.title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}