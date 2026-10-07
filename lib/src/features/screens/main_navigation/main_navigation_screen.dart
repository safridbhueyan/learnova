import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../ai_chatbot/ai_chatbot_screen.dart';
import '../career_recommendations/career_recommendations_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../learning_resources/learning_resources_screen.dart';
import '../personalized_roadmap/personalized_roadmap_screen.dart';
import '../result_analyzer/result_analyzer_screen.dart';
import 'provider/navigation_provider.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    final screens = const [
      DashboardScreen(key: ValueKey('screen_0')),
      CareerRecommendationsScreen(key: ValueKey('screen_1')),
      PersonalizedRoadmapScreen(key: ValueKey('screen_2')),
      LearningResourcesScreen(key: ValueKey('screen_3')),
      ResultAnalyzerScreen(key: ValueKey('screen_4')),
      AIChatbotScreen(key: ValueKey('screen_5')),
    ];

    final clampedIndex = selectedIndex.clamp(0, screens.length - 1);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomAnimatedSwitcher(
        child: screens[clampedIndex],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
