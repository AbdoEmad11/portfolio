import 'package:flutter/material.dart';

class AppConstants {
  // Personal Information
  static const String name = 'Abdelrahman Emad Mosbah';
  static const String title = 'Flutter Developer';
  static const String phone = '(+20) 01227213578';
  static const String email = 'abdelrahmanemad581@gmail.com';
  static const String linkedIn = 'https://www.linkedin.com/in/abdelrahman-emad100';
  static const String github = 'https://github.com/AbdoEmad11';

  // Summary
  static const String summary = '''
Passionate Flutter Developer specializing in creating beautiful, high-performance cross-platform applications for mobile and web. Expert in Dart programming, Material Design 3, and building responsive UIs that work seamlessly across iOS, Android, and Web platforms. Skilled in state management (Bloc/Cubit), Firebase integration, RESTful APIs, and implementing clean architecture patterns. Committed to delivering exceptional user experiences through modern Flutter development practices and pixel-perfect designs.
''';

  // Education
  static const String education = '''
Bachelor's degree in Computer Science
Faculty of Computers and Information, Mansoura University – Egypt
2021 – 2025
''';

  // Experience
  static const String experience = '''
Cross-Platform Mobile Development Trainee – Flutter
Digital Egypt Pioneers Initiative (DEPI)
June 2025 – December 2025

• Completed immersive, hands-on training in Dart, Flutter, advanced UI/UX, and cross-platform deployment for Android and iOS.
• Built a real-world capstone application, applying best practices in Git, GitHub unit testing, and clean architecture.
• Integrated Firebase, responsive design principles, and functional documentation into app development workflow
• Strengthened communication, team collaboration, and problem-solving through structured soft skills and prompt engineering sessions
''';

  // Skills Lists
  static const List<String> programmingLanguages = [
    'Dart',
    'C#',
    'Python',
  ];

  static const List<String> technicalSkills = [
    'Flutter SDK',
    'Cross-Platform Development',
    'Object-Oriented Programming (OOP)',
    'SOLID Principles',
    'Design Patterns',
    'Bloc & Cubit',
    'MVVM Architecture',
    'Clean Architecture',
    'RESTful APIs',
    'Firebase',
    'Git & GitHub',
    'HTTP & Dio',
    'Postman',
  ];

  static const List<String> softSkills = [
    'Problem Solving',
    'Adaptability',
    'Fast learner',
    'Creativity',
    'Time Management',
    'Team Collaboration',
    'Critical Thinking',
    'Communication',
  ];

  // Services
  static const List<Map<String, String>> services = [
    {
      'title': 'Mobile App Development',
      'description': 'Cross-platform mobile applications using Flutter and Dart',
      'icon': 'mobile'
    },
    {
      'title': 'UI/UX Design',
      'description': 'Modern, responsive, and user-friendly interface design',
      'icon': 'design'
    },
    {
      'title': 'Firebase Integration',
      'description': 'Backend services, authentication, and real-time database',
      'icon': 'firebase'
    },
    {
      'title': 'API Integration',
      'description': 'RESTful APIs integration and data management',
      'icon': 'api'
    },
  ];

  // Navigation Items
  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      label: 'Home',
      route: '/',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    NavigationItem(
      label: 'About',
      route: '/about',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
    NavigationItem(
      label: 'Journey',
      route: '/journey',
      icon: Icons.timeline_outlined,
      activeIcon: Icons.timeline_rounded,
    ),
    NavigationItem(
      label: 'Services',
      route: '/services',
      icon: Icons.work_outline_rounded,
      activeIcon: Icons.work_rounded,
    ),
    NavigationItem(
      label: 'Projects',
      route: '/projects',
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder_rounded,
    ),
    NavigationItem(
      label: 'Achievements',
      route: '/achievements',
      icon: Icons.star_outline_rounded,
      activeIcon: Icons.star_rounded,
    ),
    NavigationItem(
      label: 'Contact',
      route: '/contact',
      icon: Icons.contact_mail_outlined,
      activeIcon: Icons.contact_mail_rounded,
    ),
  ];

  // Breakpoints
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;
  static const double largeDesktopBreakpoint = 1920;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
}

class NavigationItem {
  final String label;
  final String route;
  final IconData icon;
  final IconData activeIcon;

  const NavigationItem({
    required this.label,
    required this.route,
    required this.icon,
    required this.activeIcon,
  });
}

// Color Schemes
class AppColors {
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color secondaryBlue = Color(0xFF1976D2);
  static const Color accentBlue = Color(0xFF03DAC6);

  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color darkBackground = Color(0xFF121212);

  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E1E1E);
}