import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/custom_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _buildBackground(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(
              mobile: 20,
              tablet: 32,
              desktop: 48,
            ),
            vertical: context.responsiveValue(
              mobile: 40,
              tablet: 60,
              desktop: 80,
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
              child: context.isDesktop
                  ? _buildDesktopLayout()
                  : _buildMobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          context.colorScheme.surface,
          context.colorScheme.surfaceVariant.withOpacity(0.3),
          context.colorScheme.surface,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Content
        Expanded(
          flex: 3,
          child: _buildContent(),
        ),
        
        SizedBox(width: context.responsiveValue(
          mobile: 32,
          tablet: 48,
          desktop: 64,
        )),
        
        // Right side - Visual
        Expanded(
          flex: 2,
          child: _buildVisualElement(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildVisualElement(),
        SizedBox(height: context.responsiveValue(
          mobile: 32,
          tablet: 40,
        )),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: context.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Professional Badge
        _buildProfessionalBadge(),
        
        const SizedBox(height: 24),
        
        // Main Heading
        _buildMainHeading(),
        
        const SizedBox(height: 16),
        
        // Subtitle
        _buildSubtitle(),
        
        const SizedBox(height: 24),
        
        // Description
        _buildDescription(),
        
        const SizedBox(height: 32),
        
        // Key Highlights
        _buildKeyHighlights(),
        
        const SizedBox(height: 40),
        
        // Action Buttons
        _buildActionButtons(),
        
        const SizedBox(height: 32),
        
        // Social Links
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildProfessionalBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary.withOpacity(0.1),
            context.colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            color: context.colorScheme.primary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'Professional Flutter Developer',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainHeading() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Hi, I'm ",
            style: context.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: context.colorScheme.onSurface,
            ),
          ),
          TextSpan(
            text: AppConstants.name.split(' ').first,
            style: context.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
      textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Senior Flutter Developer & Cross-Platform Expert',
      style: context.textTheme.headlineSmall?.copyWith(
        color: context.colorScheme.secondary,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Text(
        'I create beautiful, high-performance mobile and web applications using Flutter. With expertise in cross-platform development, I help businesses reach their users across all devices with a single, maintainable codebase.',
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          height: 1.6,
        ),
        textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
      ),
    );
  }

  Widget _buildKeyHighlights() {
    final highlights = [
      {'icon': Icons.phone_android_rounded, 'text': 'Mobile Apps'},
      {'icon': Icons.language_rounded, 'text': 'Web Apps'},
      {'icon': Icons.desktop_windows_rounded, 'text': 'Desktop Apps'},
      {'icon': Icons.cloud_rounded, 'text': 'Cloud Integration'},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: highlights.map((highlight) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                highlight['icon'] as IconData,
                size: 16,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                highlight['text'] as String,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        CustomButton.filled(
          text: 'View My Work',
          icon: const Icon(Icons.work_outline_rounded),
          onPressed: () => context.go('/projects'),
          size: ButtonSize.large,
        ),
        CustomButton.outlined(
          text: 'Get In Touch',
          icon: const Icon(Icons.email_outlined),
          onPressed: () => context.go('/contact'),
          size: ButtonSize.large,
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    final socialLinks = [
      {
        'icon': FontAwesomeIcons.github,
        'url': AppConstants.github,
        'tooltip': 'GitHub',
        'action': () => AppHelpers.launchURL(AppConstants.github),
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'url': AppConstants.linkedIn,
        'tooltip': 'LinkedIn',
        'action': () => AppHelpers.launchURL(AppConstants.linkedIn),
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'url': AppConstants.email,
        'tooltip': 'Email',
        'action': () => AppHelpers.launchEmail(AppConstants.email),
      },
    ];

    return Row(
      mainAxisAlignment: context.isDesktop
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: socialLinks.map((social) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Tooltip(
            message: social['tooltip'] as String,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: social['action'] as VoidCallback,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: FaIcon(
                    social['icon'] as IconData,
                    size: 20,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVisualElement() {
    return Container(
      width: context.responsiveValue(
        mobile: 280,
        tablet: 320,
        desktop: 400,
      ),
      height: context.responsiveValue(
        mobile: 280,
        tablet: 320,
        desktop: 400,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primary,
            context.colorScheme.secondary,
            context.colorScheme.tertiary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: context.colorScheme.secondary.withOpacity(0.2),
            blurRadius: 60,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background pattern
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          // Main icon
          Container(
            width: context.responsiveValue(
              mobile: 120,
              tablet: 140,
              desktop: 160,
            ),
            height: context.responsiveValue(
              mobile: 120,
              tablet: 140,
              desktop: 160,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.flutter_dash,
              size: context.responsiveValue(
                mobile: 60,
                tablet: 70,
                desktop: 80,
              ),
              color: Colors.white,
            ),
          ),
          
          // Floating elements
          ...List.generate(3, (index) {
            return Positioned(
              top: context.responsiveValue(
                mobile: 40 + (index * 20),
                tablet: 50 + (index * 25),
                desktop: 60 + (index * 30),
              ),
              right: context.responsiveValue(
                mobile: 30 + (index * 15),
                tablet: 40 + (index * 20),
                desktop: 50 + (index * 25),
              ),
              child: Container(
                width: context.responsiveValue(
                  mobile: 8 + (index * 2),
                  tablet: 10 + (index * 2),
                  desktop: 12 + (index * 2),
                ),
                height: context.responsiveValue(
                  mobile: 8 + (index * 2),
                  tablet: 10 + (index * 2),
                  desktop: 12 + (index * 2),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}