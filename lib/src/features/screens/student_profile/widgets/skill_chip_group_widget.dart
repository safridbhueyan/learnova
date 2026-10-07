import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/student_profile_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class SkillChipGroupWidget extends StatelessWidget {
  final List<SkillItem> skills;
  final Function(SkillItem skill)? onSkillTap;

  const SkillChipGroupWidget({
    super.key,
    required this.skills,
    this.onSkillTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: skills.map((skill) {
        Color statusColor = AppColor.textMuted;
        if (skill.status == "Mastered") {
          statusColor = AppColor.mastered;
        } else if (skill.status == "Strong") {
          statusColor = AppColor.strong;
        } else if (skill.status == "Needs Improvement") {
          statusColor = AppColor.needsImprovement;
        } else if (skill.status == "Missing") {
          statusColor = AppColor.missing;
        }

        return GestureDetector(
          onTap: () => onSkillTap?.call(skill),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 1.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  skill.name,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textPrimary,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  "${skill.proficiency}%",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
