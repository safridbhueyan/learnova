import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import 'provider/learning_resources_provider.dart';
import 'widgets/category_chip_filter.dart';
import 'widgets/tutorial_card_widget.dart';

class LearningResourcesScreen extends ConsumerWidget {
  const LearningResourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(learningResourcesProvider);

    final filteredTutorials = state.tutorials.where((t) {
      final matchesCategory = state.activeCategory == "All" || t.category == state.activeCategory;
      final matchesQuery = state.searchQuery.isEmpty ||
          t.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          t.channelName.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          t.keyTopics.any((topic) => topic.toLowerCase().contains(state.searchQuery.toLowerCase()));
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_circle_fill_rounded, color: Colors.red, size: 20.r),
            ),
            10.horizontalSpace,
            Text(
              "YouTube Learning Hub",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input Bar
            TextField(
              onChanged: (val) {
                ref.read(learningResourcesProvider.notifier).setSearchQuery(val);
              },
              style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
              decoration: InputDecoration(
                hintText: "Search YouTube tutorials, topics, channels...",
                hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.textMuted),
                prefixIcon: Icon(Icons.search, color: AppColor.textMuted, size: 20.r),
                filled: true,
                fillColor: AppColor.cardBg,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColor.cardBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColor.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColor.primary),
                ),
              ),
            ),
            14.verticalSpace,
            const CategoryChipFilter(),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Curated Video Tutorials",
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
                Text(
                  "${filteredTutorials.length} Tutorials Found",
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textMuted),
                ),
              ],
            ),
            12.verticalSpace,
            if (filteredTutorials.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.video_library_outlined, size: 48.r, color: AppColor.textMuted),
                      12.verticalSpace,
                      Text(
                        "No tutorials found matching '$state.searchQuery'",
                        style: TextStyle(fontSize: 13.sp, color: AppColor.textMuted),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...List.generate(filteredTutorials.length, (index) {
                final tutorial = filteredTutorials[index];
                return ScaleFadeEntrance(
                  key: ValueKey(tutorial.id),
                  delay: Duration(milliseconds: index * 80),
                  child: TutorialCardWidget(tutorial: tutorial),
                );
              }),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
