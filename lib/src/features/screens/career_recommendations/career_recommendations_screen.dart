import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../skill_gap/provider/skill_gap_provider.dart';
import '../skill_gap/widgets/skill_progress_bar_widget.dart';
import '../student_profile/provider/student_profile_provider.dart';
import 'provider/career_recommendations_provider.dart';
import 'widgets/career_card_widget.dart';
import 'widgets/career_detail_modal.dart';

// Riverpod provider for tab toggle state
class CareerTabNotifier extends Notifier<int> {
  @override
  int build() => 0; // 0: Career Tracks, 1: Skill Gaps
  void setTab(int index) => state = index;
}

final careerTabProvider = NotifierProvider<CareerTabNotifier, int>(CareerTabNotifier.new);

class CareerRecommendationsScreen extends ConsumerWidget {
  const CareerRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(careerTabProvider);
    final careerPaths = ref.watch(careerRecommendationsProvider);
    final gapItems = ref.watch(skillGapProvider);
    final student = ref.watch(studentProfileProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Careers & Skill Matrix",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Segment Controller
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: AppColor.surfaceLight,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(careerTabProvider.notifier).setTab(0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: activeTab == 0 ? AppColor.primary : AppColor.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            "AI Career Tracks",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: activeTab == 0 ? AppColor.textOnPrimary : AppColor.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(careerTabProvider.notifier).setTab(1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: activeTab == 1 ? AppColor.primary : AppColor.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            "Skill Gap Matrix",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: activeTab == 1 ? AppColor.textOnPrimary : AppColor.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            CustomAnimatedSwitcher(
              key: ValueKey('career_tab_$activeTab'),
              child: activeTab == 0
                  ? Column(
                      children: List.generate(careerPaths.length, (index) {
                        final career = careerPaths[index];
                        final isTarget = student.targetCareer.contains("Flutter") && career.id == "mobile_flutter";
                        return ScaleFadeEntrance(
                          delay: Duration(milliseconds: index * 90),
                          child: CareerCardWidget(
                            career: career,
                            isSelectedTarget: isTarget,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => CareerDetailModal(career: career),
                              );
                            },
                            onSelectAsTarget: () {
                              ref.read(studentProfileProvider.notifier).updateTargetCareer(career.title);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColor.primary,
                                  content: Text("Target set to: ${career.title}"),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    )
                  : Column(
                      children: List.generate(gapItems.length, (index) {
                        final item = gapItems[index];
                        return ScaleFadeEntrance(
                          delay: Duration(milliseconds: index * 90),
                          child: SkillProgressBarWidget(gapItem: item),
                        );
                      }),
                    ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
