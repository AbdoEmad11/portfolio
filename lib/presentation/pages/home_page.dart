import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/helpers.dart';
import '../widgets/home_view/hero_section.dart';
import '../widgets/home_view/stats_section.dart';
import '../widgets/home_view/tech_marquee.dart';
import '../widgets/home_view/featured_projects_section.dart';
import '../widgets/home_view/skills_overview_section.dart';
import '../widgets/home_view/contact_cta_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimations() {
    if (!_hasAnimated) {
      _fadeController.forward();
      _hasAnimated = true;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          );
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Hero Section
          const HeroSection(),

          // Tech marquee
          const TechMarquee(),

          // Stats Section
          const StatsSection(),

          // Skills Overview
          const SkillsOverviewSection(),

          // Featured Projects
          const FeaturedProjectsSection(),

          // Contact CTA
          const ContactCTASection(),

          // Footer
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: context.responsivePadding(
        mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        tablet: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        desktop: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        largeDesktop: const EdgeInsets.symmetric(horizontal: 40, vertical: 56),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.surfaceVariant.withOpacity(0.5),
            context.colorScheme.surfaceVariant.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
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
              // Main footer content
              context.isDesktop ? _buildDesktopFooter() : _buildMobileFooter(),

              const SizedBox(height: 32),

              // Divider
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      context.colorScheme.outline.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Copyright
              Text(
                '© 2025 ${AppConstants.name}. Built with Flutter & Dart ❤️',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Flutter badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF2196F3),
                      const Color(0xFF03DAC6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.flutter_dash,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Powered by Flutter',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      children: [
        // Left side - Info
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s Build Something Amazing Together',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Ready to bring your ideas to life with Flutter? Let\'s create beautiful, high-performance apps that work seamlessly across all platforms.',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildSocialButton(
                    icon: Icons.email_rounded,
                    onTap: () => AppHelpers.launchEmail(AppConstants.email),
                    tooltip: 'Email',
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: Icons.work_rounded,
                    onTap: () => AppHelpers.launchURL(AppConstants.linkedIn),
                    tooltip: 'LinkedIn',
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: Icons.code_rounded,
                    onTap: () => AppHelpers.launchURL(AppConstants.github),
                    tooltip: 'GitHub',
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right side - Quick links
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Links',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              _buildFooterLink('About Me', '/about'),
              _buildFooterLink('My Projects', '/projects'),
              _buildFooterLink('Services', '/services'),
              _buildFooterLink('Contact', '/contact'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        Text(
          'Let\'s Build Something Amazing Together',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Ready to bring your ideas to life with Flutter? Let\'s create beautiful, high-performance apps that work seamlessly across all platforms.',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.email_rounded,
              onTap: () => AppHelpers.launchEmail(AppConstants.email),
              tooltip: 'Email',
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.work_rounded,
              onTap: () => AppHelpers.launchURL(AppConstants.linkedIn),
              tooltip: 'LinkedIn',
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.code_rounded,
              onTap: () => AppHelpers.launchURL(AppConstants.github),
              tooltip: 'GitHub',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Text(
          text,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.primary.withOpacity(0.1),
            ),
            child: FaIcon(
              icon,
              size: 20,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}