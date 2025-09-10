enum SkillLevel { beginner, intermediate, advanced, expert }

enum SkillCategory {
  programming,
  framework,
  database,
  tools,
  soft,
  architecture,
  testing,
  deployment
}

class SkillModel {
  final String name;
  final SkillLevel level;
  final SkillCategory category;
  final String? description;
  final String? iconPath;
  final int percentage; // 0-100 for progress indicators
  final List<String> relatedProjects;

  const SkillModel({
    required this.name,
    required this.level,
    required this.category,
    this.description,
    this.iconPath,
    required this.percentage,
    this.relatedProjects = const [],
  });

  String get levelString {
    switch (level) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }

  String get categoryString {
    switch (category) {
      case SkillCategory.programming:
        return 'Programming Languages';
      case SkillCategory.framework:
        return 'Frameworks & Libraries';
      case SkillCategory.database:
        return 'Databases';
      case SkillCategory.tools:
        return 'Tools & Platforms';
      case SkillCategory.soft:
        return 'Soft Skills';
      case SkillCategory.architecture:
        return 'Architecture & Patterns';
      case SkillCategory.testing:
        return 'Testing';
      case SkillCategory.deployment:
        return 'Deployment & DevOps';
    }
  }
}

// Sample skills data
class SkillsData {
  static List<SkillModel> get skills => [
    // Programming Languages
    SkillModel(
      name: 'Dart',
      level: SkillLevel.expert,
      category: SkillCategory.programming,
      percentage: 95,
      description: 'Primary language for Flutter development',
      relatedProjects: ['Portfolio App', 'E-commerce App'],
    ),
    SkillModel(
      name: 'JavaScript',
      level: SkillLevel.intermediate,
      category: SkillCategory.programming,
      percentage: 75,
      description: 'Web development and Flutter web integration',
    ),
    SkillModel(
      name: 'Python',
      level: SkillLevel.intermediate,
      category: SkillCategory.programming,
      percentage: 70,
      description: 'Backend services and automation scripts',
    ),

    // Flutter & Cross-Platform
    SkillModel(
      name: 'Flutter',
      level: SkillLevel.expert,
      category: SkillCategory.framework,
      percentage: 95,
      description: 'Cross-platform mobile and web development',
      relatedProjects: ['Portfolio App', 'E-commerce App'],
    ),
    SkillModel(
      name: 'Flutter Web',
      level: SkillLevel.advanced,
      category: SkillCategory.framework,
      percentage: 85,
      description: 'Web applications with Flutter',
      relatedProjects: ['Portfolio App'],
    ),
    SkillModel(
      name: 'Responsive Design',
      level: SkillLevel.advanced,
      category: SkillCategory.framework,
      percentage: 90,
      description: 'Adaptive UIs for all screen sizes',
    ),

    // State Management
    SkillModel(
      name: 'Bloc/Cubit',
      level: SkillLevel.expert,
      category: SkillCategory.framework,
      percentage: 95,
      description: 'Advanced state management patterns',
      relatedProjects: ['Portfolio App', 'E-commerce App'],
    ),
    SkillModel(
      name: 'Provider',
      level: SkillLevel.advanced,
      category: SkillCategory.framework,
      percentage: 85,
      description: 'Simple state management solution',
    ),
    SkillModel(
      name: 'Riverpod',
      level: SkillLevel.intermediate,
      category: SkillCategory.framework,
      percentage: 75,
      description: 'Modern state management library',
    ),

    // Backend & APIs
    SkillModel(
      name: 'Firebase',
      level: SkillLevel.advanced,
      category: SkillCategory.framework,
      percentage: 90,
      description: 'Backend-as-a-Service platform',
      relatedProjects: ['E-commerce App'],
    ),
    SkillModel(
      name: 'RESTful APIs',
      level: SkillLevel.advanced,
      category: SkillCategory.tools,
      percentage: 90,
      description: 'API integration and consumption',
      relatedProjects: ['Portfolio App', 'E-commerce App'],
    ),
    SkillModel(
      name: 'GraphQL',
      level: SkillLevel.intermediate,
      category: SkillCategory.tools,
      percentage: 70,
      description: 'Query language for APIs',
    ),

    // Architecture & Patterns
    SkillModel(
      name: 'Clean Architecture',
      level: SkillLevel.expert,
      category: SkillCategory.architecture,
      percentage: 95,
      description: 'Scalable and maintainable code architecture',
      relatedProjects: ['Portfolio App', 'E-commerce App'],
    ),
    SkillModel(
      name: 'MVVM Pattern',
      level: SkillLevel.expert,
      category: SkillCategory.architecture,
      percentage: 95,
      description: 'Model-View-ViewModel architectural pattern',
      relatedProjects: ['Portfolio App'],
    ),
    SkillModel(
      name: 'SOLID Principles',
      level: SkillLevel.advanced,
      category: SkillCategory.architecture,
      percentage: 90,
      description: 'Object-oriented design principles',
    ),

    // UI/UX & Design
    SkillModel(
      name: 'Material Design 3',
      level: SkillLevel.expert,
      category: SkillCategory.framework,
      percentage: 95,
      description: 'Modern Material Design implementation',
      relatedProjects: ['Portfolio App'],
    ),
    SkillModel(
      name: 'Custom Widgets',
      level: SkillLevel.expert,
      category: SkillCategory.framework,
      percentage: 90,
      description: 'Building reusable UI components',
    ),
    SkillModel(
      name: 'Animations',
      level: SkillLevel.advanced,
      category: SkillCategory.framework,
      percentage: 85,
      description: 'Smooth and engaging user animations',
    ),

    // Tools & Platforms
    SkillModel(
      name: 'Git & GitHub',
      level: SkillLevel.expert,
      category: SkillCategory.tools,
      percentage: 95,
      description: 'Version control and collaboration',
      relatedProjects: ['Portfolio App', 'E-commerce App'],
    ),
    SkillModel(
      name: 'VS Code',
      level: SkillLevel.expert,
      category: SkillCategory.tools,
      percentage: 95,
      description: 'Primary IDE for Flutter development',
    ),
    SkillModel(
      name: 'Android Studio',
      level: SkillLevel.advanced,
      category: SkillCategory.tools,
      percentage: 85,
      description: 'Android development and debugging',
    ),

    // Testing
    SkillModel(
      name: 'Unit Testing',
      level: SkillLevel.advanced,
      category: SkillCategory.testing,
      percentage: 85,
      description: 'Testing individual functions and methods',
    ),
    SkillModel(
      name: 'Widget Testing',
      level: SkillLevel.advanced,
      category: SkillCategory.testing,
      percentage: 80,
      description: 'Testing UI components and interactions',
    ),
    SkillModel(
      name: 'Integration Testing',
      level: SkillLevel.intermediate,
      category: SkillCategory.testing,
      percentage: 70,
      description: 'End-to-end application testing',
    ),

    // Soft Skills
    SkillModel(
      name: 'Problem Solving',
      level: SkillLevel.expert,
      category: SkillCategory.soft,
      percentage: 95,
      description: 'Analytical thinking and solution development',
    ),
    SkillModel(
      name: 'Team Collaboration',
      level: SkillLevel.advanced,
      category: SkillCategory.soft,
      percentage: 90,
      description: 'Working effectively in team environments',
    ),
    SkillModel(
      name: 'Communication',
      level: SkillLevel.advanced,
      category: SkillCategory.soft,
      percentage: 85,
      description: 'Clear and effective communication skills',
    ),
    SkillModel(
      name: 'Adaptability',
      level: SkillLevel.expert,
      category: SkillCategory.soft,
      percentage: 95,
      description: 'Quick learning and adaptation to new technologies',
    ),
  ];

  static List<SkillModel> getSkillsByCategory(SkillCategory category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  static List<SkillCategory> get categories => SkillCategory.values;

  static List<SkillModel> get topSkills => skills
      .where((skill) => skill.percentage >= 80)
      .toList()
    ..sort((a, b) => b.percentage.compareTo(a.percentage));
}