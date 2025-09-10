import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/custom_button.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: AppConstants.longAnimation,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
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
              _buildServicesGrid(),
              _buildProcessSection(),
              _buildCTASection(),
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
          child: TweenAnimationBuilder<double>(
            duration: AppConstants.mediumAnimation,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                Text(
                  'My Services',
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
                  'Comprehensive Flutter development services to bring your ideas to life',
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

  Widget _buildServicesGrid() {
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
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.responsiveValue(
                mobile: 1,
                tablet: 2,
                desktop: 2,
              ).round(),
              childAspectRatio: context.responsiveValue(
                mobile: 1.2,
                tablet: 1.1,
                desktop: 1.3,
              ),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: AppConstants.services.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300 + (index * 150)),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: _buildServiceCard(AppConstants.services[index], index),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, String> service, int index) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getServiceColor(index),
                  _getServiceColor(index).withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _getServiceIcon(service['icon']!),
              size: 32,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 24),

          // Title
          Text(
            service['title']!,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Expanded(
            child: Text(
              service['description']!,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Features list
          Column(
            children: _getServiceFeatures(service['icon']!).map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: _getServiceColor(index),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSection() {
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
              TweenAnimationBuilder<double>(
                duration: AppConstants.mediumAnimation,
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      'My Process',
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
                      'How I work to deliver exceptional results',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              _buildProcessSteps(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessSteps() {
    final steps = [
      {
        'title': 'Discovery',
        'description': 'Understanding your requirements, target audience, and project goals',
        'icon': Icons.search,
      },
      {
        'title': 'Design',
        'description': 'Creating wireframes, UI designs, and defining the user experience',
        'icon': Icons.design_services,
      },
      {
        'title': 'Development',
        'description': 'Building the app with clean architecture and best practices',
        'icon': Icons.code,
      },
      {
        'title': 'Testing',
        'description': 'Comprehensive testing to ensure quality and performance',
        'icon': Icons.bug_report,
      },
      {
        'title': 'Deployment',
        'description': 'Publishing to app stores and ensuring smooth launch',
        'icon': Icons.rocket_launch,
      },
    ];

    if (context.isDesktop) {
      return Row(
        children: steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return Expanded(
            child: _buildProcessStep(step, index),
          );
        }).toList(),
      );
    }

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < steps.length - 1 ? 24 : 0,
          ),
          child: _buildProcessStep(step, index),
        );
      }).toList(),
    );
  }

  Widget _buildProcessStep(Map<String, dynamic> step, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            margin: context.isDesktop
                ? const EdgeInsets.symmetric(horizontal: 12)
                : EdgeInsets.zero,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                // Step number
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.colorScheme.primary,
                        context.colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Icon
                Icon(
                  step['icon'] as IconData,
                  size: 32,
                  color: context.colorScheme.primary,
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  step['title'] as String,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  step['description'] as String,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCTASection() {
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
          constraints: const BoxConstraints(maxWidth: 800),
          child: TweenAnimationBuilder<double>(
            duration: AppConstants.mediumAnimation,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                Text(
                  'Ready to Start Your Project?',
                  style: context.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  'Let\'s discuss your ideas and create something amazing together',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CustomButton.filled(
                      text: 'Get In Touch',
                      icon: const Icon(Icons.contact_mail),
                      onPressed: () => context.go('/contact'),
                      size: ButtonSize.large,
                    ),
                    CustomButton.outlined(
                      text: 'View Projects',
                      icon: const Icon(Icons.folder),
                      onPressed: () => context.go('/projects'),
                      size: ButtonSize.large,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getServiceColor(int index) {
    final colors = [
      const Color(0xFF2196F3),
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
      const Color(0xFF9C27B0),
    ];
    return colors[index % colors.length];
  }

  IconData _getServiceIcon(String iconName) {
    switch (iconName) {
      case 'mobile':
        return Icons.phone_android;
      case 'design':
        return Icons.design_services;
      case 'firebase':
        return Icons.cloud;
      case 'api':
        return Icons.api;
      default:
        return Icons.code;
    }
  }

  List<String> _getServiceFeatures(String iconName) {
    switch (iconName) {
      case 'mobile':
        return [
          'iOS & Android apps',
          'Responsive design',
          'Native performance',
          'App store deployment'
        ];
      case 'design':
        return [
          'User interface design',
          'User experience optimization',
          'Material Design',
          'Custom animations'
        ];
      case 'firebase':
        return [
          'User authentication',
          'Real-time database',
          'Cloud storage',
          'Push notifications'
        ];
      case 'api':
        return [
          'REST API integration',
          'Data synchronization',
          'Error handling',
          'Offline support'
        ];
      default:
        return [];
    }
  }
}