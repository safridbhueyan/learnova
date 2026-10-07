import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/roadmap_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class RoadmapPhaseCardWidget extends StatelessWidget {
  final RoadmapPhaseModel phase;
  final VoidCallback onToggleStatus;

  const RoadmapPhaseCardWidget({
    super.key,
    required this.phase,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = phase.status == "completed";
    bool isInProgress = phase.status == "inProgress";

    Color statusColor = isCompleted
        ? AppColor.mastered
        : (isInProgress ? AppColor.primary : AppColor.textMuted);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isInProgress ? AppColor.primary : AppColor.cardBorder,
          width: isInProgress ? 2.w : 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${phase.phaseNumber}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    "PHASE 0${phase.phaseNumber}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      letterSpacing: 1.w,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isCompleted ? AppColor.mastered : AppColor.textMuted,
                  size: 24.r,
                ),
                onPressed: onToggleStatus,
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            phase.title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
            ),
          ),
          4.verticalSpace,
          Text(
            phase.subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.textSecondary,
              height: 1.3,
            ),
          ),
          14.verticalSpace,
          Text(
            "Recommended Resources:",
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.accent),
          ),
          6.verticalSpace,
          ...phase.resources.map((res) {
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.play_circle_fill_outlined, size: 14.r, color: AppColor.primary),
                  6.horizontalSpace,
                  Expanded(
                    child: Text(
                      "${res.title} (${res.estimatedTime})",
                      style: TextStyle(fontSize: 11.sp, color: AppColor.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColor.surfaceLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.build_outlined, size: 14.r, color: AppColor.warning),
                    6.horizontalSpace,
                    Expanded(
                      child: Text(
                        "Project Challenge: ${phase.project.title}",
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                      ),
                    ),
                  ],
                ),
                4.verticalSpace,
                Text(
                  phase.project.description,
                  style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
