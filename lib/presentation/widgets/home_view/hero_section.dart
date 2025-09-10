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
      decoration: _buildGradientBackground(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(
            mobile: 16,
            tablet: 24,
            desktop: 32,
          ),
        ),
        child: context.isDesktop
            ? _buildDesktopLayout()
            : _buildMobileLayout(),
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          context.colorScheme.primary.withOpacity(0.05),
          context.colorScheme.secondary.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(
          mobile: 1200,
          tablet: 1400,
          desktop: 1600,
          largeDesktop: 1800,
        ),
      ),
      height: context.responsiveValue(
        mobile: context.height * 0.85,
        tablet: context.height * 0.9,
        desktop: context.height * 0.85,
        largeDesktop: context.height * 0.8,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: context.responsiveValue(
                  mobile: 3,
                  tablet: 3,
                  desktop: 3,
                  largeDesktop: 4,
                ).round(),
                child: _buildContent(),
              ),
              SizedBox(
                width: context.responsiveValue(
                  mobile: 48,
                  tablet: 56,
                  desktop: 64,
                  largeDesktop: 72,
                ),
              ),
              Expanded(
                flex: context.responsiveValue(
                  mobile: 2,
                  tablet: 2,
                  desktop: 2,
                  largeDesktop: 3,
                ).round(),
                child: _buildVisualElement(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          _buildVisualElement(),
          const SizedBox(height: 32),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: context.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting
        Text(
          AppHelpers.getGreeting(),
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        ),

        const SizedBox(height: 8),

        // Name
        Text(
          "I'm ${AppConstants.name}",
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        ),

        const SizedBox(height: 16),

        // Title
        Text(
          'Flutter Developer',
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        ),

        const SizedBox(height: 24),

        // Description
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            AppConstants.summary.trim(),
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
            textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
          ),
        ),

        const SizedBox(height: 32),

        // Action buttons
        Wrap(
          alignment: context.isDesktop
              ? WrapAlignment.start
              : WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            Flexible(
              child: CustomButton.filled(
                text: 'View My Projects',
                icon: const Icon(Icons.folder_outlined),
                onPressed: () => context.go('/projects'),
                size: ButtonSize.large,
              ),
            ),
            Flexible(
              child: CustomButton.outlined(
                text: 'Get In Touch',
                icon: const Icon(Icons.contact_mail_outlined),
                onPressed: () => context.go('/contact'),
                size: ButtonSize.large,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Social links
        Row(
          mainAxisAlignment: context.isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            _buildSocialIcon(
              FontAwesomeIcons.github,
                  () => AppHelpers.launchURL(AppConstants.github),
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              FontAwesomeIcons.linkedin,
                  () => AppHelpers.launchURL(AppConstants.linkedIn),
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              FontAwesomeIcons.envelope,
                  () => AppHelpers.launchEmail(AppConstants.email),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVisualElement() {
    return Center(
      child: Container(
        width: context.responsiveValue(
          mobile: 220,
          tablet: 280,
          desktop: 320,
        ),
        height: context.responsiveValue(
          mobile: 220,
          tablet: 280,
          desktop: 320,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2196F3), // Flutter Blue
              Color(0xFF03DAC6), // Flutter Teal
              Color(0xFF4CAF50), // Material Green
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2196F3).withOpacity(0.4),
              blurRadius: 40,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: const Color(0xFF03DAC6).withOpacity(0.2),
              blurRadius: 60,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.flutter_dash,
            size: context.responsiveValue(
              mobile: 60,
              tablet: 75,
              desktop: 90,
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: FaIcon(
            icon,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}