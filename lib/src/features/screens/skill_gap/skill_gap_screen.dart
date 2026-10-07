import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../student_profile/provider/student_profile_provider.dart';
import 'provider/skill_gap_provider.dart';
import 'widgets/skill_progress_bar_widget.dart';

class SkillGapScreen extends ConsumerWidget {
  const SkillGapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gapItems = ref.watch(skillGapProvider);
    final student = ref.watch(studentProfileProvider);

    final missingCount = gapItems.where((item) => item.gapStatus == "Missing").length;
    final needsImpCount = gapItems.where((item) => item.gapStatus == "Needs Improvement").length;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Skill-Gap Matrix",
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
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                gradient: AppColor.cardGradient,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: AppColor.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Target Role: ${student.targetCareer}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      _buildCountBadge("$missingCount Missing Skills", AppColor.missing),
                      10.horizontalSpace,
                      _buildCountBadge("$needsImpCount Needs Improvement", AppColor.needsImprovement),
                    ],
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Text(
              "Skill Comparison against Industry Standard",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            12.verticalSpace,
            ...gapItems.map((item) => SkillProgressBarWidget(gapItem: item)),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildCountBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
