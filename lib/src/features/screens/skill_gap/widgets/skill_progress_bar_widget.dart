import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/models/skill_gap_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class SkillProgressBarWidget extends StatelessWidget {
  final SkillGapModel gapItem;

  const SkillProgressBarWidget({super.key, required this.gapItem});

  @override
  Widget build(BuildContext context) {
    Color statusColor = AppColor.mastered;
    if (gapItem.gapStatus == "Strong") {
      statusColor = AppColor.strong;
    } else if (gapItem.gapStatus == "Needs Improvement") {
      statusColor = AppColor.needsImprovement;
    } else if (gapItem.gapStatus == "Missing") {
      statusColor = AppColor.missing;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gapItem.skillName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  gapItem.gapStatus.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current: ${gapItem.currentProficiency}%",
                style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary),
              ),
              Text(
                "Industry Req: ${gapItem.requiredProficiency}%",
                style: TextStyle(fontSize: 11.sp, color: AppColor.accent),
              ),
            ],
          ),
          8.verticalSpace,
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 8.h,
            percent: (gapItem.currentProficiency / 100).clamp(0.0, 1.0),
            backgroundColor: AppColor.surfaceLight,
            progressColor: statusColor,
            barRadius: Radius.circular(4.r),
          ),
          10.verticalSpace,
          Text(
            gapItem.actionTip,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColor.textMuted,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
