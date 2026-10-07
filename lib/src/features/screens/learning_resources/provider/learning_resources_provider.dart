import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/learning_resource_model.dart';

class LearningResourcesState {
  final String activeCategory;
  final List<LearningResourceModel> tutorials;
  final String searchQuery;

  const LearningResourcesState({
    required this.activeCategory,
    required this.tutorials,
    required this.searchQuery,
  });

  LearningResourcesState copyWith({
    String? activeCategory,
    List<LearningResourceModel>? tutorials,
    String? searchQuery,
  }) {
    return LearningResourcesState(
      activeCategory: activeCategory ?? this.activeCategory,
      tutorials: tutorials ?? this.tutorials,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class LearningResourcesNotifier extends Notifier<LearningResourcesState> {
  @override
  LearningResourcesState build() {
    return const LearningResourcesState(
      activeCategory: "All",
      searchQuery: "",
      tutorials: [
        LearningResourceModel(
          id: "yt_01",
          title: "Flutter 3 & Dart Complete Masterclass: Zero to Hero",
          channelName: "Flutter Mapp",
          category: "Flutter & Dart",
          duration: "45 mins",
          difficulty: "Beginner",
          youtubeUrl: "https://www.youtube.com/watch?v=VPvVD8t0208",
          views: "1.2M views",
          rating: 4.9,
          keyTopics: ["Widgets", "Stateless vs Stateful", "Layout Math", "ScreenUtil"],
          summary: "Comprehensive introduction to modern Flutter 3 desktop, web, and mobile app construction using best UI practices.",
        ),
        LearningResourceModel(
          id: "yt_02",
          title: "Riverpod 2.0 Complete Architecture Guide (Notifier & AsyncNotifier)",
          channelName: "Code With Andrea",
          category: "Riverpod",
          duration: "32 mins",
          difficulty: "Intermediate",
          youtubeUrl: "https://www.youtube.com/watch?v=Zp75bgR-7F0",
          views: "450K views",
          rating: 5.0,
          keyTopics: ["NotifierProvider", "FamilyNotifier", "Ref.watch vs Ref.read", "State Persistence"],
          summary: "Learn industry-standard reactive state management using Riverpod 2.x without any setState calls.",
        ),
        LearningResourceModel(
          id: "yt_03",
          title: "Clean Architecture in Flutter: Domain, Data & Presentation Layers",
          channelName: "Reso Coder",
          category: "Clean Architecture",
          duration: "58 mins",
          difficulty: "Advanced",
          youtubeUrl: "https://www.youtube.com/watch?v=KjE212RIlhM",
          views: "890K views",
          rating: 4.9,
          keyTopics: ["Use Cases", "Repositories", "Freezed Models", "Dependency Injection"],
          summary: "Decouple your business logic, data models, and Flutter presentation UI using Clean Architecture principles.",
        ),
        LearningResourceModel(
          id: "yt_04",
          title: "Resilient Dio REST API Integration & Interceptors in Flutter",
          channelName: "Fireship",
          category: "REST API & Dio",
          duration: "25 mins",
          difficulty: "Intermediate",
          youtubeUrl: "https://www.youtube.com/watch?v=F3j7n-J98k8",
          views: "620K views",
          rating: 4.8,
          keyTopics: ["Dio Client", "Auth Interceptors", "JSON Parsing", "Offline Retry Logic"],
          summary: "Build scalable HTTP network clients with automatic token refresh, error boundary handling, and cached responses.",
        ),
        LearningResourceModel(
          id: "yt_05",
          title: "Automated Unit, Widget & Integration Testing Masterclass",
          channelName: "Very Good Ventures",
          category: "Testing",
          duration: "38 mins",
          difficulty: "Advanced",
          youtubeUrl: "https://www.youtube.com/watch?v=y3nK0gW69Hk",
          views: "310K views",
          rating: 4.9,
          keyTopics: ["Mocktail", "WidgetTester", "Golden Tests", "Integration Driver"],
          summary: "Achieve 80%+ test coverage across Riverpod providers, asynchronous data repositories, and interactive widgets.",
        ),
        LearningResourceModel(
          id: "yt_06",
          title: "Firebase Auth, Firestore & Storage Full-Stack Flutter App",
          channelName: "Academind",
          category: "Firebase & Cloud",
          duration: "1 hr 12 mins",
          difficulty: "Intermediate",
          youtubeUrl: "https://www.youtube.com/watch?v=sfA3841jA4U",
          views: "1.5M views",
          rating: 4.8,
          keyTopics: ["Firebase Auth", "Cloud Firestore", "Security Rules", "Push Notifications"],
          summary: "Connect your Flutter client to Google Cloud Firebase services for real-time data sync and authentication.",
        ),
      ],
    );
  }

  void setCategory(String category) {
    state = state.copyWith(activeCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleBookmark(String tutorialId) {
    final updated = state.tutorials.map((item) {
      if (item.id == tutorialId) {
        return item.copyWith(isBookmarked: !item.isBookmarked);
      }
      return item;
    }).toList();
    state = state.copyWith(tutorials: updated);
  }
}

final learningResourcesProvider = NotifierProvider<LearningResourcesNotifier, LearningResourcesState>(LearningResourcesNotifier.new);
