import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_button.dart';

class ServicesPreviewSection extends StatelessWidget {
  const ServicesPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(
            mobile: 20,
            tablet: 32,
            desktop: 48,
          ),
          vertical: context.responsiveValue(
            mobile: 60,
            tablet: 80,
            desktop: 100,
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
                  mobile: 40,
                  tablet: 50,
                  desktop: 60,
                )),
                _buildServicesGrid(context),
                const SizedBox(height: 40),
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
          'Services I Offer',
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
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
        const SizedBox(height: 20),
        Text(
          'Comprehensive solutions for your digital needs',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'title': 'Mobile App Development',
        'description': 'Cross-platform mobile applications using Flutter and Dart for iOS and Android',
        'icon': Icons.phone_android_rounded,
        'color': const Color(0xFF2196F3),
        'features': ['iOS & Android', 'Cross-Platform', 'Native Performance'],
      },
      {
        'title': 'Web Application Development',
        'description': 'Modern, responsive web applications that work seamlessly across all devices',
        'icon': Icons.language_rounded,
        'color': const Color(0xFF4CAF50),
        'features': ['Responsive Design', 'PWA Support', 'Fast Loading'],
      },
      {
        'title': 'Backend Integration',
        'description': 'Firebase, RESTful APIs, and cloud services integration for robust applications',
        'icon': Icons.cloud_rounded,
        'color': const Color(0xFFFF9800),
        'features': ['Firebase', 'REST APIs', 'Real-time Data'],
      },
      {
        'title': 'UI/UX Design',
        'description': 'Beautiful, intuitive user interfaces following Material Design principles',
        'icon': Icons.design_services_rounded,
        'color': const Color(0xFF9C27B0),
        'features': ['Material Design', 'User Research', 'Prototyping'],
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = context.responsiveValue(
          mobile: 1,
          tablet: 2,
          desktop: 2,
          largeDesktop: 4,
        ).round();
        
        final childAspectRatio = context.responsiveValue(
          mobile: 1.2,
          tablet: 1.1,
          desktop: 1.0,
          largeDesktop: 0.9,
        );

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: context.responsiveValue(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
            mainAxisSpacing: context.responsiveValue(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _buildServiceCard(context, services[index], index);
          },
        );
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service, int index) {
    final color = service['color'] as Color;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
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
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.2),
                  color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              service['icon'] as IconData,
              color: color,
              size: 28,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Title
          Text(
            service['title'] as String,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Description
          Text(
            service['description'] as String,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Features
          ...(service['features'] as List<String>).map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return CustomButton.outlined(
      text: 'View All Services',
      icon: const Icon(Icons.arrow_forward_rounded),
      onPressed: () => context.go('/services'),
      size: ButtonSize.large,
    );
  }
}
