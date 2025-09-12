import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/cubite/heme_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/about_page.dart';
import 'presentation/pages/journey_page.dart';
import 'presentation/pages/services_page.dart';
import 'presentation/pages/projects_page.dart';
import 'presentation/pages/project_gallery_page.dart';
import 'presentation/pages/achievements_page.dart';
import 'presentation/pages/contact_page.dart';
import 'presentation/pages/splash_page.dart';
import 'core/widgets/adaptive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(prefs),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Abdelrahman Emad - Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: themeMode,
            routerConfig: _router,
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    const primaryBlue = Color(0xFF0D47A1);
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF0B0B0B),
      surfaceContainerHighest: const Color(0xFF121212),
      background: const Color(0xFF0B0B0B),
      onSurface: Colors.white,
      onBackground: Colors.white,
      primary: primaryBlue,
      onPrimary: Colors.white,
      secondary: const Color(0xFF1976D2),
      onSecondary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: scheme.surfaceContainerHighest,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.6)),
          foregroundColor: scheme.onSurface,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    const primaryBlue = Color(0xFF0D47A1);
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF0B0B0B),
      surfaceContainerHighest: const Color(0xFF121212),
      background: const Color(0xFF0B0B0B),
      onSurface: Colors.white,
      onBackground: Colors.white,
      primary: primaryBlue,
      onPrimary: Colors.white,
      secondary: const Color(0xFF1976D2),
      onSecondary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: scheme.surfaceContainerHighest,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.6)),
          foregroundColor: scheme.onSurface,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) => _buildPageWithTransition(
        const SplashPage(),
        state,
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return AdaptiveLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const HomePage(),
            state,
          ),
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const AboutPage(),
            state,
          ),
        ),
        GoRoute(
          path: '/journey',
          name: 'journey',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const JourneyPage(),
            state,
          ),
        ),
        GoRoute(
          path: '/services',
          name: 'services',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const ServicesPage(),
            state,
          ),
        ),
        GoRoute(
          path: '/projects',
          name: 'projects',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const ProjectsPage(),
            state,
          ),
        ),
        GoRoute(
          path: '/project/:id',
          name: 'project',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return _buildPageWithTransition(
              ProjectGalleryPage(projectId: id),
              state,
            );
          },
        ),
        GoRoute(
          path: '/achievements',
          name: 'achievements',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const AchievementsPage(),
            state,
          ),
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          pageBuilder: (context, state) => _buildPageWithTransition(
            const ContactPage(),
            state,
          ),
        ),
      ],
    ),
  ],
);

Page<void> _buildPageWithTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        ),
      );
    },

  );
}