import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../auth/auth_screen.dart';
import '../auth/provider/auth_provider.dart';
import '../student_profile/provider/student_profile_provider.dart';
import '../student_profile/student_profile_screen.dart';
import 'provider/dashboard_provider.dart';
import 'widgets/ai_insight_banner.dart';
import 'widgets/career_goal_card.dart';
import 'widgets/quick_stats_grid.dart';
import 'widgets/readiness_gauge_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardProvider);
    final student = ref.watch(studentProfileProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StudentProfileScreen()),
                );
              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColor.primary,
                child: Text(
                  student.name.isNotEmpty ? student.name[0] : "S",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  Text(
                    "${student.university} • ${student.department}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded, color: AppColor.missing, size: 20.r),
            tooltip: "Sign Out",
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
          8.horizontalSpace,
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFadeEntrance(
              delay: Duration.zero,
              child: CareerGoalCard(
                careerGoal: summary.careerGoal,
                matchPercentage: summary.careerMatchPercentage,
              ),
            ),
            14.verticalSpace,
            ScaleFadeEntrance(
              delay: const Duration(milliseconds: 100),
              child: ReadinessGaugeWidget(
                readinessScore: summary.jobReadinessScore,
                statusLabel: "Job Ready Candidate",
              ),
            ),
            14.verticalSpace,
            ScaleFadeEntrance(
              delay: const Duration(milliseconds: 200),
              child: AIInsightBanner(
                text:
                    "Dart & Flutter UI at 88%+. Completing REST API integration and Clean Architecture qualifies you for top roles.",
              ),
            ),
            18.verticalSpace,
            ScaleFadeEntrance(
              delay: const Duration(milliseconds: 280),
              child: Text(
                "Quick Access Hub",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
            ),
            10.verticalSpace,
            ScaleFadeEntrance(
              delay: const Duration(milliseconds: 350),
              child: QuickStatsGrid(
                skillProgress: summary.skillProgressPercentage,
                completedRoadmap: summary.completedRoadmapItems,
                totalRoadmap: summary.totalRoadmapItems,
                skillGaps: summary.skillGapsCount,
                jobMatches: summary.recommendedJobsCount,
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
