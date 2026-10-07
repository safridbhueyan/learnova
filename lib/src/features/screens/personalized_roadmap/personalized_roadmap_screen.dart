import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../student_profile/provider/student_profile_provider.dart';
import 'provider/roadmap_provider.dart';
import 'widgets/roadmap_phase_card_widget.dart';

class PersonalizedRoadmapScreen extends ConsumerWidget {
  const PersonalizedRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phases = ref.watch(roadmapProvider);
    final student = ref.watch(studentProfileProvider);

    final completedCount = phases.where((p) => p.status == "completed").length;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Personalized Learning Roadmap",
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
            ScaleFadeEntrance(
              delay: Duration.zero,
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  gradient: AppColor.heroGradient,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Adaptive Roadmap for:",
                            style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary.withValues(alpha: 0.8)),
                          ),
                          Text(
                            student.targetCareer,
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                          ),
                          8.verticalSpace,
                          Text(
                            "$completedCount of ${phases.length} Phases Completed",
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColor.textOnPrimary),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.alt_route, size: 40.r, color: AppColor.textOnPrimary),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              "Sequential Skill Development Pipeline",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            14.verticalSpace,
            ...List.generate(phases.length, (index) {
              final phase = phases[index];
              return ScaleFadeEntrance(
                delay: Duration(milliseconds: 100 + (index * 80)),
                child: RoadmapPhaseCardWidget(
                  phase: phase,
                  onToggleStatus: () {
                    ref.read(roadmapProvider.notifier).togglePhaseStatus(phase.phaseNumber);
                  },
                ),
              );
            }),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
