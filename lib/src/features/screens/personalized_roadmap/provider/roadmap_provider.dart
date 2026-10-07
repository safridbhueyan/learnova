import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/roadmap_model.dart';

class RoadmapNotifier extends Notifier<List<RoadmapPhaseModel>> {
  @override
  List<RoadmapPhaseModel> build() {
    return const [
      RoadmapPhaseModel(
        phaseNumber: 1,
        title: "Dart Advanced Concepts & Null Safety",
        subtitle: "Master asynchronous Dart streams, generics, isolators, and functional operators.",
        status: "completed",
        estimatedDuration: "1 Week",
        topics: ["Streams & StreamTransformers", "Dart Isolates & Multithreading", "Extension Types"],
        resources: [
          ResourceItem(title: "Official Dart Asynchronous Programming Guide", type: "Documentation", estimatedTime: "2 hrs", url: "https://dart.dev/codelabs/async-await"),
          ResourceItem(title: "Advanced Dart 3 Masterclass", type: "Video", estimatedTime: "3.5 hrs", url: "https://youtube.com"),
        ],
        project: RecommendedProject(
          title: "Reactive Data Stream Analyzer",
          difficulty: "Beginner",
          description: "Build a CLI / Flutter widget that parses dynamic JSON streams in real-time.",
          targetSkills: ["Dart Streams", "Isolates", "Error Handling"],
        ),
      ),
      RoadmapPhaseModel(
        phaseNumber: 2,
        title: "Flutter Advanced UI & Custom Animations",
        subtitle: "Create smooth 60fps custom painters, implicit/explicit animations, and complex slivers.",
        status: "completed",
        estimatedDuration: "2 Weeks",
        topics: ["CustomPainter & Canvas API", "AnimationController & Hero", "Nested CustomScrollView"],
        resources: [
          ResourceItem(title: "Flutter CustomPainter Deep Dive", type: "Article", estimatedTime: "1.5 hrs", url: "https://flutter.dev"),
          ResourceItem(title: "Modern UI Animations in Flutter", type: "Course", estimatedTime: "4 hrs", url: "https://udemy.com"),
        ],
        project: RecommendedProject(
          title: "Animated Crypto Analytics Dashboard",
          difficulty: "Intermediate",
          description: "Develop a dark-mode interactive dashboard with live canvas charts and glassmorphism.",
          targetSkills: ["Flutter Animations", "CustomPainter", "Responsive Layout"],
        ),
      ),
      RoadmapPhaseModel(
        phaseNumber: 3,
        title: "REST API Integration & Dio Networking",
        subtitle: "Implement resilient API calls, JSON serialization with freezed, interceptors, and caching.",
        status: "inProgress",
        estimatedDuration: "2 Weeks",
        topics: ["Dio HTTP Client", "JSON Key Mapper", "Auth Token Refresh Interceptor", "Offline Caching"],
        resources: [
          ResourceItem(title: "Robust Networking in Flutter with Dio", type: "Video", estimatedTime: "2.5 hrs", url: "https://youtube.com"),
          ResourceItem(title: "Handling Network Exceptions & Retry Logic", type: "Practice", estimatedTime: "3 hrs", url: "https://github.com"),
        ],
        project: RecommendedProject(
          title: "Real-time Job Market Pulse App",
          difficulty: "Intermediate",
          description: "Build a mobile client connecting to live backend REST API for student job matching.",
          targetSkills: ["Dio API", "Token Refresh", "State Notifier"],
        ),
      ),
      RoadmapPhaseModel(
        phaseNumber: 4,
        title: "Clean Architecture & Feature Slicing",
        subtitle: "Decouple presentation, domain business rules, and data repository implementations.",
        status: "upcoming",
        estimatedDuration: "3 Weeks",
        topics: ["Domain Entities & Use Cases", "Repository Pattern", "Data Source Mocking", "Dependency Injection"],
        resources: [
          ResourceItem(title: "Reso Coder Clean Architecture Guide", type: "Article Series", estimatedTime: "5 hrs", url: "https://resocoder.com"),
          ResourceItem(title: "Architecting Enterprise Flutter Apps", type: "Course", estimatedTime: "6 hrs", url: "https://youtube.com"),
        ],
        project: RecommendedProject(
          title: "Learnova Offline-First Career Grooming Engine",
          difficulty: "Advanced",
          description: "Refactor core student assessment logic into Clean Architecture layers.",
          targetSkills: ["Clean Architecture", "Use Cases", "Repository Pattern"],
        ),
      ),
      RoadmapPhaseModel(
        phaseNumber: 5,
        title: "Automated Testing (Unit, Widget & Integration)",
        subtitle: "Ensure product reliability with high test coverage using Mocktail and IntegrationTest.",
        status: "upcoming",
        estimatedDuration: "2 Weeks",
        topics: ["Unit Tests for Riverpod Notifiers", "Widget Test Harnessing", "Integration Tests with Driver"],
        resources: [
          ResourceItem(title: "Testing Flutter Applications Handbook", type: "Documentation", estimatedTime: "3 hrs", url: "https://docs.flutter.dev/testing"),
        ],
        project: RecommendedProject(
          title: "Suite of Test Cases for Student Skill Matrix",
          difficulty: "Advanced",
          description: "Achieve 80%+ test coverage for skill gap calculations and job recommendation engines.",
          targetSkills: ["Mocktail", "Widget Testing", "Coverage Reports"],
        ),
      ),
      RoadmapPhaseModel(
        phaseNumber: 6,
        title: "Production Deployment & CI/CD Pipelines",
        subtitle: "Automate app bundle signing, Play Store submission, and error tracking with Sentry.",
        status: "upcoming",
        estimatedDuration: "1 Week",
        topics: ["Fastlane / Codemagic", "App Signing & Obfuscation", "Firebase Crashlytics Integration"],
        resources: [
          ResourceItem(title: "Flutter Release & Deployment Guide", type: "Documentation", estimatedTime: "2 hrs", url: "https://flutter.dev/docs/deployment"),
        ],
        project: RecommendedProject(
          title: "Production Release of Learnova v1.0",
          difficulty: "Job-Ready",
          description: "Deploy production build to Google Play Console testing track with automated CI pipeline.",
          targetSkills: ["CI/CD", "Play Store Release", "Crashlytics"],
        ),
      ),
    ];
  }

  void togglePhaseStatus(int phaseNumber) {
    state = state.map((phase) {
      if (phase.phaseNumber == phaseNumber) {
        String newStatus = phase.status == "completed" ? "inProgress" : "completed";
        return phase.copyWith(status: newStatus);
      }
      return phase;
    }).toList();
  }
}

final roadmapProvider = NotifierProvider<RoadmapNotifier, List<RoadmapPhaseModel>>(RoadmapNotifier.new);
