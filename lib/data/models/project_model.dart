enum ProjectCategory { mobile, web, desktop, game, ai }
enum ProjectStatus { completed, inProgress, planned }

class Project {
  final String id;
  final String title;
  final String description;
  final String longDescription;
  final List<String> technologies;
  final String? imageUrl;
  final List<String> galleryImages;
  final String? demoUrl;
  final String? githubUrl;
  final ProjectCategory category;
  final ProjectStatus status;
  final DateTime? completedDate;
  final String date;
  final bool isFeatured;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.technologies,
    this.imageUrl,
    this.galleryImages = const [],
    this.demoUrl,
    this.githubUrl,
    required this.category,
    required this.status,
    this.completedDate,
    required this.date,
    this.isFeatured = false,
  });
}

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String longDescription;
  final List<String> technologies;
  final String? imageUrl;
  final String? projectUrl;
  final String? githubUrl;
  final String category;
  final DateTime? completedDate;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.technologies,
    this.imageUrl,
    this.projectUrl,
    this.githubUrl,
    required this.category,
    this.completedDate,
    this.isFeatured = false,
  });

  ProjectModel copyWith({
    String? id,
    String? title,
    String? description,
    String? longDescription,
    List<String>? technologies,
    String? imageUrl,
    String? projectUrl,
    String? githubUrl,
    String? category,
    DateTime? completedDate,
    bool? isFeatured,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      longDescription: longDescription ?? this.longDescription,
      technologies: technologies ?? this.technologies,
      imageUrl: imageUrl ?? this.imageUrl,
      projectUrl: projectUrl ?? this.projectUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      category: category ?? this.category,
      completedDate: completedDate ?? this.completedDate,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}

// Sample project data
class ProjectData {
  static List<Project> get projects => [
    Project(
      id: '1',
      title: 'Baseera',
      description: 'AI-Powered Book Summary & Recommendation App',
      longDescription: '''
Baseera is a comprehensive mobile application that leverages artificial intelligence to provide book summaries and personalized recommendations. Built as a graduation project, it showcases advanced Flutter development techniques and AI integration.

Key Features:
• AI-powered book summaries using Pegasus and BART models
• Personalized book recommendations
• Audio playbook functionality for listening to summaries
• Offline mode for accessing downloaded content
• Dynamic content rendering with real-time updates
• Clean architecture following MVVM principles

The app demonstrates proficiency in state management, API integration, and creating scalable, maintainable code with focus on exceptional user experience.
      ''',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'RESTful APIs',
        'Cubit',
        'Clean Architecture',
        'MVVM',
        'AI Models (Pegasus, BART)',
        'Audio Playback',
        'Offline Storage'
      ],
      category: ProjectCategory.mobile,
      status: ProjectStatus.completed,
      completedDate: DateTime(2025, 1, 15),
      date: 'Jan 2025',
      isFeatured: true,
      imageUrl: 'assets/images/baseera/8.png',
      galleryImages: [
        'assets/images/baseera/7.png',
        'assets/images/baseera/8.png',
        'assets/images/baseera/22(1).png',
        'assets/images/baseera/23.png',
        'assets/images/baseera/22.png',
        'assets/images/baseera/25(1).png',
        'assets/images/baseera/25.png',
        'assets/images/baseera/27.png',
      ],
      demoUrl: 'https://drive.google.com/file/d/1MJyB1z6p1Fw5ZacEVC0rd_g2ilR1xUSx/view',
      githubUrl: 'https://github.com/Our-GRAD-Project/flutterApplication',
    ),
    Project(
      id: '2',
      title: 'Cinema Score',
      description: 'Movie Listing & Discovery App',
      longDescription: '''
Cinema Score is a feature-rich Flutter application that provides comprehensive movie information and discovery features. The app integrates with The Movie Database (TMDb) API to deliver real-time movie data.

Key Features:
• Trending, top-rated, and upcoming movies
• Advanced search and filtering functionality
• Detailed movie information with posters, ratings, and overviews
• Custom movie models for data management
• Robust API service layer with JSON parsing
• Responsive UI with smooth animations
• Clean architecture implementation

The application demonstrates expertise in API integration, data modeling, and creating intuitive user interfaces for media consumption.
      ''',
      technologies: [
        'Flutter',
        'Dart',
        'TMDb API',
        'HTTP',
        'JSON Parsing',
        'Clean Architecture',
        'Custom Models',
        'Search & Filtering',
        'Responsive Design'
      ],
      category: ProjectCategory.mobile,
      status: ProjectStatus.completed,
      completedDate: DateTime(2024, 11, 20),
      date: 'Nov 2024',
      isFeatured: true,
      imageUrl: 'assets/images/cinema_score/8.jpg',
      galleryImages: [
        'assets/images/cinema_score/1.jpg',
        'assets/images/cinema_score/2.jpg',
        'assets/images/cinema_score/3.jpg',
        'assets/images/cinema_score/4.jpg',
        'assets/images/cinema_score/5.jpg',
        'assets/images/cinema_score/8.jpg',
      ],
      demoUrl: 'https://youtu.be/w3GDHM3-TBw?si=O7T3jxzYhf0jeGrw',
      githubUrl: 'hhttps://github.com/AbdoEmad11/cinema-scor',
    ),
  ];

  static List<ProjectModel> get legacyProjects => [
    ProjectModel(
      id: '1',
      title: 'Baseera',
      description: 'AI-Powered Book Summary & Recommendation App',
      longDescription: '''
Baseera is a comprehensive mobile application that leverages artificial intelligence to provide book summaries and personalized recommendations. Built as a graduation project, it showcases advanced Flutter development techniques and AI integration.

Key Features:
• AI-powered book summaries using Pegasus and BART models
• Personalized book recommendations
• Audio playbook functionality for listening to summaries
• Offline mode for accessing downloaded content
• Dynamic content rendering with real-time updates
• Clean architecture following MVVM principles

The app demonstrates proficiency in state management, API integration, and creating scalable, maintainable code with focus on exceptional user experience.
      ''',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'RESTful APIs',
        'Cubit',
        'Clean Architecture',
        'MVVM',
        'AI Models (Pegasus, BART)',
        'Audio Playback',
        'Offline Storage'
      ],
      category: 'Mobile App',
      completedDate: DateTime(2025, 1, 15),
      isFeatured: true,
      projectUrl: 'https://github.com/abdelrahmanemad/baseera',
      githubUrl: 'https://github.com/abdelrahmanemad/baseera',
    ),
    ProjectModel(
      id: '2',
      title: 'Cinema Score',
      description: 'Movie Listing & Discovery App',
      longDescription: '''
Cinema Score is a feature-rich Flutter application that provides comprehensive movie information and discovery features. The app integrates with The Movie Database (TMDb) API to deliver real-time movie data.

Key Features:
• Trending, top-rated, and upcoming movies
• Advanced search and filtering functionality
• Detailed movie information with posters, ratings, and overviews
• Custom movie models for data management
• Robust API service layer with JSON parsing
• Responsive UI with smooth animations
• Clean architecture implementation

The application demonstrates expertise in API integration, data modeling, and creating intuitive user interfaces for media consumption.
      ''',
      technologies: [
        'Flutter',
        'Dart',
        'TMDb API',
        'HTTP',
        'JSON Parsing',
        'Clean Architecture',
        'Custom Models',
        'Search & Filtering',
        'Responsive Design'
      ],
      category: 'Mobile App',
      completedDate: DateTime(2024, 11, 20),
      isFeatured: true,
      projectUrl: 'https://github.com/abdelrahmanemad/cinema-score',
      githubUrl: 'https://github.com/abdelrahmanemad/cinema-score',
    ),
    ProjectModel(
      id: '3',
      title: 'E-Commerce Flutter App',
      description: 'Full-featured online shopping application',
      longDescription: '''
A comprehensive e-commerce mobile application built with Flutter, featuring complete shopping functionality from product browsing to order completion.

Key Features:
• Product catalog with categories and search
• Shopping cart and wishlist functionality
• User authentication and profile management
• Order tracking and history
• Payment gateway integration
• Admin panel for inventory management
• Real-time notifications
• Multi-language support

This project showcases advanced Flutter development patterns, state management, and integration with backend services.
      ''',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'Stripe API',
        'Bloc Pattern',
        'Provider',
        'SQLite',
        'Push Notifications',
        'REST APIs'
      ],
      category: 'Mobile App',
      completedDate: DateTime(2024, 8, 10),
      isFeatured: false,
    ),
  ];

  static List<String> get categories => [
    'All',
    'Mobile App',
    'Web App',
    'Desktop',
    'Game',
    'AI/ML',
  ];
}