import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants.dart';
import '../utils/extensions.dart';
import '../../presentation/cubite/heme_cubit.dart';
import 'custom_app_bar.dart';

class AdaptiveLayout extends StatefulWidget {
  final Widget child;

  const AdaptiveLayout({
    super.key,
    required this.child,
  });

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final location = GoRouterState.of(context).uri.path;
    final index = AppConstants.navigationItems
        .indexWhere((item) => item.route == location);
    if (index != -1 && index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return _buildMobileLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppConstants.navigationItems[_selectedIndex].label,
        showBackButton: false,
        actions: [
          _buildThemeToggleButton(),
          const SizedBox(width: 8),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildNavigationRail(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                _buildDesktopAppBar(),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: context.colorScheme.primary,
        unselectedItemColor: context.colorScheme.onSurfaceVariant,
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        items: AppConstants.navigationItems.map((item) {
          final isSelected = AppConstants.navigationItems.indexOf(item) == _selectedIndex;
          return BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: AppConstants.shortAnimation,
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                key: ValueKey(isSelected),
              ),
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavigationRail() {
    return Container(
      width: context.responsiveValue(
        mobile: 280,
        tablet: 300,
        desktop: 320,
        largeDesktop: 350,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          _buildProfileHeader(),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: AppConstants.navigationItems.length,
              itemBuilder: (context, index) {
                final item = AppConstants.navigationItems[index];
                final isSelected = index == _selectedIndex;

                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _onItemTapped(index),
                      child: AnimatedContainer(
                        duration: AppConstants.shortAnimation,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected
                              ? context.colorScheme.primaryContainer
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            AnimatedSwitcher(
                              duration: AppConstants.shortAnimation,
                              child: Icon(
                                isSelected ? item.activeIcon : item.icon,
                                key: ValueKey(isSelected),
                                color: isSelected
                                    ? context.colorScheme.onPrimaryContainer
                                    : context.colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  color: isSelected
                                      ? context.colorScheme.onPrimaryContainer
                                      : context.colorScheme.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildThemeToggleButton(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  context.colorScheme.primary,
                  context.colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                'AE',
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            AppConstants.title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            AppConstants.navigationItems[_selectedIndex].label,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          _buildThemeToggleButton(),
        ],
      ),
    );
  }

  Widget _buildThemeToggleButton() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;
        return IconButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: AnimatedSwitcher(
            duration: AppConstants.shortAnimation,
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              key: ValueKey(isDark),
              size: 20,
            ),
          ),
          tooltip: isDark ? 'Light Mode' : 'Dark Mode',
        );
      },
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      final route = AppConstants.navigationItems[index].route;
      // Update the selected index first for immediate visual feedback
      setState(() {
        _selectedIndex = index;
      });
      // Navigate with a slight delay to ensure smooth transition
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          context.go(route);
        }
      });
    }
  }
}