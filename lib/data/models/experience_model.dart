enum ExperienceType { work, education, certification, course, project }

class Experience {
  final String id;
  final String title;
  final String company;
  final String duration;
  final String description;
  final List<String> skills;
  final ExperienceType type;

  const Experience({
    required this.id,
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
    required this.skills,
    required this.type,
  });
}

class ExperienceModel {
  final String id;
  final String title;
  final String organization;
  final String? location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isOngoing;
  final ExperienceType type;
  final String description;
  final List<String> achievements;
  final List<String> skills;
  final String? certificateUrl;
  final String? organizationUrl;

  const ExperienceModel({
    required this.id,
    required this.title,
    required this.organization,
    this.location,
    required this.startDate,
    this.endDate,
    this.isOngoing = false,
    required this.type,
    required this.description,
    this.achievements = const [],
    this.skills = const [],
    this.certificateUrl,
    this.organizationUrl,
  });

  String get duration {
    final start = '${_getMonthName(startDate.month)} ${startDate.year}';
    final end = isOngoing
        ? 'Present'
        : endDate != null
        ? '${_getMonthName(endDate!.month)} ${endDate!.year}'
        : 'Present';
    return '$start - $end';
  }

  int get durationInMonths {
    final end = endDate ?? DateTime.now();
    return ((end.year - startDate.year) * 12) + (end.month - startDate.month);
  }

  String get durationString {
    final months = durationInMonths;
    if (months < 12) {
      return '$months month${months == 1 ? '' : 's'}';
    }

    final years = months ~/ 12;
    final remainingMonths = months % 12;

    if (remainingMonths == 0) {
      return '$years year${years == 1 ? '' : 's'}';
    }

    return '$years year${years == 1 ? '' : 's'} $remainingMonths month${remainingMonths == 1 ? '' : 's'}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String get typeString {
    switch (type) {
      case ExperienceType.work:
        return 'Work Experience';
      case ExperienceType.education:
        return 'Education';
      case ExperienceType.certification:
        return 'Certification';
      case ExperienceType.course:
        return 'Course';
      case ExperienceType.project:
        return 'Project';
    }
  }
}

// Sample experience data
class ExperienceData {
  static List<ExperienceModel> get experiences => [
    ExperienceModel(
      id: '1',
      title: 'Cross-Platform Mobile Development Trainee – Flutter',
      organization: 'Digital Egypt Pioneers Initiative (DEPI)',
      location: 'Egypt',
      startDate: DateTime(2025, 6),
      endDate: DateTime(2025, 12),
      type: ExperienceType.work,
      description: '''
Completed immersive, hands-on training in Dart, Flutter, advanced UI/UX, and cross-platform deployment for Android and iOS. Built a real-world capstone application, applying best practices in Git, GitHub unit testing, and clean architecture.
      ''',
      achievements: [
        'Completed immersive, hands-on training in Dart, Flutter, advanced UI/UX, and cross-platform deployment',
        'Built a real-world capstone application applying best practices',
        'Integrated Firebase, responsive design principles, and functional documentation',
        'Strengthened communication, team collaboration, and problem-solving through structured sessions'
      ],
      skills: [
        'Flutter',
        'Dart',
        'Firebase',
        'Clean Architecture',
        'Git',
        'GitHub',
        'Unit Testing',
        'UI/UX',
        'Team Collaboration'
      ],
    ),
    ExperienceModel(
      id: '2',
      title: 'Bachelor\'s degree in Computer Science',
      organization: 'Faculty of Computers and Information, Mansoura University',
      location: 'Egypt',
      startDate: DateTime(2021, 9),
      endDate: DateTime(2025, 6),
      type: ExperienceType.education,
      description: '''
Comprehensive computer science education covering fundamental and advanced topics in software development, algorithms, data structures, and computer systems.
      ''',
      achievements: [
        'Graduated with strong foundation in computer science principles',
        'Developed practical programming skills in multiple languages',
        'Completed capstone graduation project (Baseera)',
        'Maintained excellent academic performance'
      ],
      skills: [
        'Programming Fundamentals',
        'Data Structures',
        'Algorithms',
        'Software Engineering',
        'Database Systems',
        'Computer Networks',
        'Operating Systems',
        'Object-Oriented Programming'
      ],
    ),
    ExperienceModel(
      id: '3',
      title: 'Mobile Application Development with Flutter',
      organization: 'Consulting of Computers and Information Center (CCIC)',
      location: 'Egypt',
      startDate: DateTime(2024, 3),
      endDate: DateTime(2024, 8),
      type: ExperienceType.course,
      description: '''
Comprehensive Flutter development course covering Dart programming, Flutter framework, state management, and mobile app development best practices.
      ''',
      achievements: [
        'Mastered Flutter framework and Dart programming language',
        'Learned state management with Cubit',
        'Covered UI design and API integration',
        'Applied best practices for scalable app development'
      ],
      skills: [
        'Flutter',
        'Dart',
        'Cubit State Management',
        'UI Design',
        'API Integration',
        'Mobile Development'
      ],
      certificateUrl: 'https://example.com/certificate',
    ),
    ExperienceModel(
      id: '4',
      title: 'Mobile Application Development with Flutter Certification',
      organization: 'Consulting of Computers and Information Center (CCIC)',
      location: 'Egypt',
      startDate: DateTime(2024, 8),
      endDate: DateTime(2024, 8),
      type: ExperienceType.certification,
      description: '''
Official certification in Flutter mobile application development, validating skills in cross-platform mobile app development using Flutter and Dart.
      ''',
      achievements: [
        'Certified Flutter developer',
        'Validated skills in cross-platform development',
        'Demonstrated proficiency in Flutter best practices'
      ],
      skills: [
        'Flutter',
        'Cross-platform Development',
        'Mobile App Development'
      ],
      certificateUrl: 'https://example.com/flutter-certificate',
    ),
  ];

  static List<ExperienceModel> getByType(ExperienceType type) {
    return experiences.where((exp) => exp.type == type).toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  static List<ExperienceModel> get sortedByDate =>
      experiences.toList()..sort((a, b) => b.startDate.compareTo(a.startDate));

  static List<ExperienceModel> get workExperiences => getByType(ExperienceType.work);
  static List<ExperienceModel> get educationExperiences => getByType(ExperienceType.education);
  static List<ExperienceModel> get certifications => getByType(ExperienceType.certification);
  static List<ExperienceModel> get courses => getByType(ExperienceType.course);

  // Simple Experience data for timeline
  static List<Experience> get timelineExperiences => [
    Experience(
      id: '1',
      title: 'Cross-Platform Mobile Development Trainee – Flutter',
      company: 'Digital Egypt Pioneers Initiative (DEPI)',
      duration: 'Jun 2025 – Dec 2025',
      description: 'Completed immersive, hands-on training in Dart, Flutter, advanced UI/UX, and cross-platform deployment for Android and iOS. Built a real-world capstone application, applying best practices in Git, GitHub unit testing, and clean architecture.',
      skills: ['Flutter', 'Dart', 'Firebase', 'Clean Architecture', 'Git', 'GitHub', 'Unit Testing', 'UI/UX', 'Team Collaboration'],
      type: ExperienceType.work,
    ),
    Experience(
      id: '2',
      title: 'Bachelor\'s degree in Computer Science',
      company: 'Faculty of Computers and Information, Mansoura University',
      duration: '2021 – 2025',
      description: 'Comprehensive computer science education covering fundamental and advanced topics in software development, algorithms, data structures, and computer systems.',
      skills: ['Programming Fundamentals', 'Data Structures', 'Algorithms', 'Software Engineering', 'Database Systems', 'Computer Networks', 'Operating Systems', 'Object-Oriented Programming'],
      type: ExperienceType.education,
    ),
    Experience(
      id: '3',
      title: 'Mobile Application Development with Flutter Certification',
      company: 'Consulting of Computers and Information Center (CCIC)',
      duration: '2024',
      description: 'Official certification in Flutter mobile application development, validating skills in cross-platform mobile app development using Flutter and Dart.',
      skills: ['Flutter', 'Cross-platform Development', 'Mobile App Development'],
      type: ExperienceType.certification,
    ),
  ];
}